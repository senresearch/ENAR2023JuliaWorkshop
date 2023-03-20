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

# ## Exercise - Optimization 

using Distributed

# #### Ex.1: 
#
# Find out how many cores and threads you can run on your computer.

# ##### Ex.1 - solution:

# There can be many ways to see it, either by typing in the corresponding command (for your specific OS) from the command line (also you can check out `ParallelComputing.ipynb` section 1.2)
#
# From the command line, type:
#
# **linux**:
# `lscpu`
#
# **macOS**:
# `sysctl -a | grep cpu | grep hw`
#
# **windows**:
# `wmic cpu get NumberOfCores,NumberOfLogicalProcessors`
#
# or simply by looking into the system report for your computer (such as in macOS, `Apple` -> `About This Mac` -> `System Report...`)

# From Julia, you can use the package `Hwloc`

using Hwloc

# Check how many physical cores you have:

num_physical_cores() 

# Check how many virtual cores (virtual processes) you can have:

num_virtual_cores()

# You may see that `num_virtual_cores()` is two times the `num_physical_cores()`.
#
# This is because normally on one physical core, there can be two processes (distributed processes, or threads) running concurrently. 

# #### Ex.2: Procs() 
# Add at least two processes to your instance.

# ##### Ex.2 - solution:

procs() # run this before adding procs

addprocs(2)

procs() # run this after adding procs

workers() # only `workers` will be `working`

# **Q:** Why are there three processes while only two are working? 
#
# Check out this `StackOverflow` thread: https://stackoverflow.com/questions/75247172/number-of-workers-and-processes-in-julia (and the Julia doc with link also provided in this thread).

# #### Ex.3:
# Generate four **Uniform(0,1)** random numbers on each core and return the matrix; call that A

# ##### Ex.3 - solution:

# First, let **all workers** know what information they will need to know in order to work: 

@everywhere using Distributions, Random 
# here just to let them "know" the packages

# We can then use `pmap` to let the workers to generate the columns of matrix A.

A_columns = pmap(i -> rand(Uniform(0, 1), 4), 1:nworkers())

# (as the ordinary `map`, `pmap` returns a collection of the outputs after mapping the )

# Then we can use `reduce`, which will apply the operation defined in the first argument on the given collection (the second argument) to "reduce" its dimensionality, to generate the matrix.

A = reduce(hcat, A_columns) # hcat to concatenate horizontally the vectors

# #### Ex.4: 
# Calculate $A(A^TA)^{-1}A^T$ (transpose matrix A, if it is not full rank).

# ##### Ex.4 - solution:

P = A*(A'A)^(-1)*A'
