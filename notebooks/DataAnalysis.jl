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

# + [markdown] slideshow={"slide_type": "slide"}
# # Basic data analysis tasks
#
# - Data: Fitness in Arabidopsis recombinant inbred lines
# - Data input: CSV files, missing data
# - Data description: Summary statistics, plots
# - Modeling: Linear regression

# + [markdown] slideshow={"slide_type": "slide"}
# ## Example: Fitness measured in Arabidopsis recombinant inbred lines
#
# This is phenotype data from Ågren et. al. (2013) via John Lovell.  A set of
# Arabidopsis recombinant inbred lines were derived from a cross of two
# parents from Italy and Sweden.  They were grown in three years
# (2009-2011) in Italy and Sweden.  The phenotype is the average number
# of seeds per plant for each line which is a measure of fitness. We also
# have the genotype data for the FLC (Flowering Time C) locus which is known to affect flowering time, an important trait affecting fitness in plants.
# -

using Statistics, CSV, Plots, DataFrames, GLM

# ## Reading data
#
# We read in data from a web URL by first downloading it into a local file,
# and then parsing that file into a data frame.
#
# Column names:
#
# - id: ID of RI line (first two are the parents)
# - it09: Italy 2009
# - it10: Italy 2010
# - it11: Italy 2011
# - sw09: Sweden 2009
# - sw10: Sweden 2010
# - sw11: Sweden 2011
# - flc: Flowering time locus (C) genotype
#

agrenURL = "https://raw.githubusercontent.com/sens/smalldata/master/arabidopsis/agren2013.csv"
agren = CSV.read(download(agrenURL),DataFrame,missingstring="NA")
first(agren,10)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Data description
#
# We get an outline of the variables in the data frame using `describe`. Note the types of each column.  Notice that the columns with missing data have a different type.  Julia has a special `missing` value and type.  Columns with missing data will be the union of the `Missing` type and the type of the rest of the data.
# -

describe(agren)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Calculating summary statistics
#
# To calculate summary statistics, we have to be aware of any missingness, and when we have missing data, we have to skip the missing observations using `skipmissing`. Otherwise, it will just return `missing`.
# -

mean(skipmissing(agren.it09)) |> (x-> round(x,digits=3))

mean(agren.it09)

# To calculate the mean of all the columns we can do it several ways.  One option is to apply the mean function to each column.

mean.(skipmissing.(eachcol(agren)))

# Another way is to use a map function over columns, as follows. This looks nicer.

mapcols(x -> mean(skipmissing(x)),agren)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Visualization: histogram
#
# One of the preliminary steps is to visualize the data using a histogram.  Since those functions only deal with non-missing data, we have to convert the data to floating point.
# -

Float64.(skipmissing(agren.it09)) |> (x->first(x,10))

histogram(Float64.(skipmissing(agren.it09)),lab="")
# display.(histogram.(eachcol(agren)))

# + [markdown] slideshow={"slide_type": "slide"}
# ## Visualization: scatterplot
#
# Making a scatterplot is straightforward.  We log transform the data here using the `log2` function.
# -

scatter(log2.(agren.it09),log2.(agren.it10),lab="")

# + [markdown] slideshow={"slide_type": "slide"}
# ## Modeling: linear regression
#
# If we want to predict the fitness in 2011 using 2009 data, we can use linear regression.  The syntax is very similar to what you might use in R.  Notice the use of the `@formula` macro to express a formula.  This is another example of a domain-specific language.
# -

out0 = lm(@formula(it11~it09+flc),agren)

# ## Extracting information
#
# We can get the coefficients and the variance-covariance matrix of the estimates using the `coef` and `vcov` functions.

coef(out0)

vcov(out0)

# + [markdown] slideshow={"slide_type": "slide"}
# ## Residual plots
#
# Residual plots are using the `resid` and `predict` functions.
# -

scatter(residuals(out0),predict(out0),lab="")

# ## GLM
#
# The syntax for generalized linear models is very similar to that of linear models.  One small difference is that here the estimation is done using maximum likelihood, and the user has to specify the distribution of the outcome/response, and the link function they wish to use.  There is no quasi-likelihood option here.

out1 = glm(@formula( it11 ~ log(it09) ),agren,Normal(),LogLink())

# ## Generating random numbers
#
# In Julia distributions are a type, so there is a uniform interface for interacting with them using multiple dispatch.  The idea is that depending on the type of distribution, a different function gets called behind the scenes. Here is how we generate random uniform or normal numbers.

using Random
using Distributions

rand(Uniform(),2,2)

rand(Normal(),2,2)

# For reproducibility, one might want to specify the type of pseudo random number generator and the seed.

# initialize random number generator
rnd = MersenneTwister(100)
# Draw uniform (0,1) numbers in 4x4 matrix
rand(rnd,Uniform(),4,4)

# ## Calculating probabilities and densities
#
# The interface for calculating othe probabilistic quantities is also uniform.

# Calculating the CDF of the normal distribution

cdf(Normal(0,1),1.96)

# Quantiles of the normal distribution.

quantile(Normal(),0.95)

# Generating random normal variables with mean 0.3 and standard deviation 0.5.

x = rand(Normal(0.3,0.5),1000);

# We now fit the MLE assuming a normal distribution.

normFit = fit_mle(Normal,x)

# We generate normal variables with parameters equal to the estimated ones.

rand(normFit,10)

# We will see more of this in the Bayesian data analysis lecture.

# ## Data wrangling tasks
#
# The DataFrames package has utilities for manipulating data frames.  As an example, we load a dataset for English Premier League results data.

eplURL = "https://raw.githubusercontent.com/sens/smalldata/master/soccer/E0.csv"
epl = CSV.read(download(eplURL),DataFrame);

first(epl)

names(epl)

# We create a narrower version by selecting necessary columns using regular expressions.

( eplNarrow = select(epl,r"Date|Team|HT|FT") )  |> (x->first(x,10))

# If we want to subset the data to only Arsenal home games, we use the `subset` function. Notice how the selectin function works in terms of the name of the column and the (anonymous) function used to generate true/false conditions.

subset(eplNarrow,:HomeTeam => (x->x.=="Arsenal"), :FTAG => (x->x.>0))

subset(eplNarrow,[:HomeTeam,:FTAG] => (x,y)-> (x.=="Arsenal").& (y.>0) )

# The `combine` function can be used for summarization.  Now, we use a similar "dictionary" approach where we name the column to operate on, the function being applied, and the name of the new column for the result.

combine( groupby(eplNarrow,:HomeTeam), :FTHG => sum => :TotalHomeGoals )

# Below is a more complex example, where we calculate the number of points earned by each team by first writing a function to calculate the number of points earned by a home team.  We calculate points at home, and away.  Then we add them and sort them.

homepoints(hg,ag) = 
begin 
    if(hg>ag) return 3
    elseif (hg==ag) return 1
    else return 0
    end
end

hp = combine( groupby(eplNarrow,:HomeTeam), [:FTHG,:FTAG] => ( (x,y) -> sum(homepoints.(x,y)) ) => :HomePoints  )
ap = combine( groupby(eplNarrow,:AwayTeam), [:FTHG,:FTAG] => ( (x,y) -> sum(homepoints.(y,x)) ) => :AwayPoints  );

hcat(sort(ap,:AwayTeam),sort(hp,:HomeTeam))

# ## Exercises
#
# - Arabidopsis: Predit fitness in Sweden in 2011 using fitness in Italy in 2011 and FLC locus.
# - EPL: Sort teams by total goals scored at home
