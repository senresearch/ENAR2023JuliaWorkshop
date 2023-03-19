# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     formats: ipynb,jl:light
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.5
#   kernelspec:
#     display_name: Julia 1.8.5
#     language: julia
#     name: julia-1.8
# ---

# # Bayesian data analysis
# ___
#
# **Gregory Farage, Śaunak Sen**    
#
#     gfarage@uthsc.edu / sen@uthsc.edu
#     Division of Biostatistics
#     Department of Preventive Medicine
#     University of Tennessee Health Science Center
#     Memphis, TN
#
#
# The Julia language is well-suited for Bayesian data analysis because it is possible to build upon probabilistic abtractions.  The [Turing.jl](https://turinglang.org/stable/) package provides Bayesian data analysis capabilities. It uses the domain-specific language in the `@model` macro to specify the joint distribution of observed and unobserved variables.  It is an example of a (Probabilistic Programming Language (PPL).  Other examples include [Stan](https://mc-stan.org/) and [MyMC](https://www.pymc.io/welcome.html).

# + [markdown] slideshow={"slide_type": "subslide"}
# ### Outline of this notebook
#
# - Normal one sample mean
# - Bivariate normal with missing 
# - Two-level Poisson regression
# - Additional reading 
# -

# ## Normal one sample mean
#
# Consider the problem of estimating the mean of a normally distributed variable with an unknown mean and unit variance.

# load packages we will use
using Turing, Random, Plots, StatsPlots, LinearAlgebra, CSV, DataFrames

# The `@model` macro specifies the joint distribution by specifying the conditional
# distributions.

@model normalvar(y) = 
    begin
    # prior for mean
    μ ~ Normal(1.0,1/10)
    # likelihood
    y ~ MvNormal(fill(μ,length(y)),I)
    # alternative specification for iid distributions
    # y ~ filldist(Normal(μ,1.0),length(y))
end

# We generate 100 observations from a normal distribution with mean 2 and variance 1.

Random.seed!(123);
normData = rand(Normal(2.0,1.0),100);

# We create an object from which we can draw samples (because the joint distribution has been specified).

normModel = normalvar(normData);
# typeof(normModel) |> supertype |> supertype

# Now we can draw samples from this joint distribution using the NUTS sampler.

normChain = sample(normModel,NUTS(),10_000);

normSummaries, normQuantiles = describe(normChain)

# We can see from the summaries that the posterior distribution is a compromose between the prior and the data.  It is halfway between the prior (mean 1, sd 0.1), and the data (100 samples with mean 2 and variance 1). This is the expectation from theory.

normSummaries

normQuantiles

plot(normChain)

# ## Bivariate normal with missing data
#
# The answer to the previous exercise was known.  Let us consider a non-trivial example -- that of a bivariate normal with some missing data.  We first write down the joint distribution of the observed and unobserved data.

@model bvNormalMissing(y) = 
    begin
    
    ## priors ##
    # weakly informative proper prior
    μ ~ MvNormal(zeros(2),1000.0*Matrix(I,2,2))
    # flat over plausible range
    ρ ~ Uniform(-0.99,0.99)
    s1 ~ Uniform(0.001,1000.0)
    s2 ~ Uniform(0.001,1000.0)
    
    ## likelihood ## 
    # sample size
    n = size(y,2)
    
    for i in 1:n
        # if the first observation is missing then the likelihood is
        # univariate normal for the second observation
        if(isnan(y[1,i]))
            # Turing.@addlogprob! logpdf(Normal(μ[2],1.0),y[2,i])
            y[2,i] ~ Normal(μ[2],s2)
        # if the second observation is missing then the likelihood is
        # univariate normal for the first observation
        elseif(isnan(y[2,i]))
            y[1,i] ~ Normal(μ[1],s1)
            # Turing.@addlogprob! logpdf(Normal(μ[1],1.0),y[1,i])
        # if both are observed we have bivariate normal likielihood
        else
            y[:,i] ~ MvNormal(μ,[s1^2 ρ*s1*s2; ρ*s1*s2 s2^2])
        end
    end
end

# We simulate data from a bivariate normal with mean 2.0 for both variables
# and variance is 1.0.  They have correlation 0.5.

# correlation matrix
R = [1 0.5; 0.5 1]
# simulate data
bvnData = rand(MvNormal(ones(2)*2,R),1000);
# first 200 are missing first obs
bvnData[1,1:200] .= NaN
# 501-700 are missing second obs
bvnData[2,501:700] .= NaN
# create the model
bvnModel = bvNormalMissing(bvnData);

bvnChain = sample(bvnModel,NUTS(),1000);
bvnSummaries, bnvQuantiles = describe(bvnChain)
bvnSummaries

plot(bvnChain)

# ## Two-level Poisson regression
#
# We will use the EPL data for this example.  We want to estimate the scoring ability of each team when playing at home.  We use a simplified model where we are observing the number of goals scored by each team at home.  We will use a two-level model.  First, we read in the data and just keep the relevant columns.

eplURL = "https://raw.githubusercontent.com/sens/smalldata/master/soccer/E0.csv"
epl = CSV.read(download(eplURL),DataFrame);
select!(epl,r"Date|Team|HT|FT") |> (x->first(x,5))

# Our model assumes that each team has a propensity to score goals at home.  That propensity is different for each team and has a normal distribution with mean $\mu$ and standard deviation $\tau$ truncated to be positive.  We put hyperpriors on both of them.  For the former it is a weakly informative normal prior with mean equal to the average number of home goals scored across teams.  For the latter, we he a half-Cauchy distribution.  Given the scoring propensity, the data have a Poisson distribution.

@model function poissonGoals(goals,team)

    ## number of teams
    nteams = length(unique(team))
    teamnames = sort(unique(team))
    
    ## priors
    μ ~ Normal(mean(goals),4*std(goals))
    τ ~ truncated(Cauchy(0,2);lower=0)

    ## team-level effects (scoring propensity)
    teamPropensity ~ filldist(truncated(Normal(μ,τ);lower=0),nteams)
    teamPropensityDict = mapreduce((x,y) -> Dict([(x,y)]), merge,
        teamnames,teamPropensity)

    ## likelihood
    expectedgoals = (x->teamPropensityDict[x]).(team)
    return goals .~ Poisson.(expectedgoals)
end;

# We get the data, and then sample from the posterior distribution.

# get the data
goals = epl.FTHG;
team = epl.HomeTeam;


poisModel = poissonGoals(goals,team);

poisChain = sample(poisModel,NUTS(),10_000);

poisSummaries, poisQuantiles = describe(poisChain);

# Now let's look at the posterior summaries of the propensities and compare it with the raw mean number of goals.

df = DataFrame(poisSummaries);
df.parameters[3:end] = Symbol.(sort(unique(team)));
df;

dfRaw = combine( groupby(epl,:HomeTeam), :FTHG => mean => :meanHomeGoals ) |> sort;

hcat(df[3:end,1:3],dfRaw)

# Notice the shrinkage for the estimtes for teams with more extreme scoring records (eg. Crystal Palace and Man City).

# ## Additional reading
#
# The Turing.jl website has some excellent [tutorials](https://turinglang.org/v0.24/tutorials/) including one for [Bayesian neural nets](https://turinglang.org/v0.24/tutorials/03-bayesian-neural-network/) using Flux.jl. Jose Storopoli has some excellent material on [Bayesian computation](https://storopoli.github.io/Bayesian-Julia/) using Turing.jl with detailed explanations. And finaly, there is the excellent book on [Bayesian Data Analysis](https://users.aalto.fi/~ave/BDA3.pdf) by Gelman, Carlin, Dunson, Stern, Vehtari and Rubin.
