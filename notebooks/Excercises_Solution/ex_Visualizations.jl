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

# ## Exercise - Visualization

# ### Preparation:
#
# Load packages...

using Plots, StatsPlots , PlotThemes
using RData, DataFrames, Downloads 
using Statistics, CategoricalArrays, FreqTables

# Load and pre-process the data...

myurl = "https://datadryad.org/stash/downloads/file_stream/27091"
datafile = Downloads.download(myurl);
dataset = load(datafile) 
df = dataset["data"];
df = dropmissing(df);
df.age_cat = cut(df.age, [0, 25, 45, 55, 65, 75, 100])
first(df, 5)

# #### Ex.1: Histogram
#
# Plot the histogram of the haemoglobine (**hb**)



# ##### Ex.1 - solution:

histogram(df.hb)

# #### Ex.2: Scatter plot
#
# Make a scatter plot of the creatinine (**crea**) versus albumine (**alb**).



# ##### Ex.2 - solution:

scatter([df.crea], [df.alb], 
        xlab = "creatinine", ylab = "albumine",
        label = "")

# #### Ex.3 Shapes of the markers
#
# Change the shape of the markers in the scatter plot
#
# (hint: [list of attributes - here](https://docs.juliaplots.org/latest/generated/attributes_series/), look at `markershape`)



# ##### Ex.3 - solution:

scatter([df.crea], [df.alb],
        markershape = :diamond,
        xlab = "creatinine", ylab = "albumine",
        label = "")


