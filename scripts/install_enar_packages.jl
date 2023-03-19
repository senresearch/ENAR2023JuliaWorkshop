# Install ENAR Workshop packages
# Load module Pkg
using Pkg

# Install ProgressMeter package if it is not already installed
if Base.find_package("ProgressMeter") == nothing
    Pkg.add("ProgressMeter")
end

# Load ProgressMeter
using ProgressMeter

# Create a list of packages to install

pkgList = [
        "BenchmarkTools",
        "CategoricalArrays", "Colors", "ColorSchemes", "Conda", "CSV",
        "DataFrames", "DataFramesMeta", "Distributions", "Downloads",
        "FileIO", "FreqTables",
        "GLM", 
        "HTTP", "Hwloc", "HypothesisTests",
        "IJulia", 
        "Flux",
        "Latexify", "LinearAlgebra",
        "Missings", "MultipleTesting", 
        "Optim",
        "Plots", "PlotlyJS", "PlotThemes", "Pluto", "PlutoUI", "PyCall",
        # "PythonCall", "PythonPlot", 
        "RData", "RDatasets", "Revise", "RCall", 
        "StatsBase", "StatsModels", "StatsPlots", 
        "Tables", 
        "UnicodePlots", 
        # "Weave", 
        # "XLSX",
]

n = length(pkgList)

# Install each package if necessary
@showprogress "Adding packages..." for i in 1:n
    if Base.find_package(pkgList[i]) == nothing
        Pkg.add(pkgList[i]);
    end
    sleep(0.1)
end
