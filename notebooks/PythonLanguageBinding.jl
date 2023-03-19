# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     cell_metadata_json: true
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

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# # Language Binding with Python
# ---
#
# **Gregory Farage, Śaunak Sen**    
#
#     gfarage@uthsc.edu / sen@uthsc.edu
#     Division of Biostatistics
#     Department of Preventive Medicine
#     University of Tennessee Health Science Center
#     Memphis, TN
#
# The advantages of Julia can be fully appreciated when used exclusively, however, it is reassuring to know that there are multiple ways to incorporate Python and R into your workflow. The purpose of this notebook is for you to see as simple it is to call function or libraries from other programming languages. We show you few examples how to directly call and fully interoperate with Python from the Julia language, with the packages `PyCall.jl`.
#
#
# *References for this notebook:*
# * [PyCall.jl](https://docs.juliahub.com/PyCall/GkzkC/1.92.0/)
# * [Lecture by Steven Johnson ](https://github.com/mitmath/18S096/blob/master/lectures/lecture1/Boxes-and-registers.ipynb)
# * [Excelling at Julia Basics and Beyond (Huda Nassar, Jane Herriman)](https://github.com/xorJane/Excelling-at-Julia-Basics-and-Beyond)

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# ### Outline of this notebook
#
# - Toy example
# - Calling python built-in function 
# - Calling python hand-written function 
# - Importing python libraries
# -

# ## Toy example

# Let's use the `sum` function as an example to understand how calling mechanisms work.   
#
# The function `sum(x)` can computes the sum of all elements in an array `x` of length $n$:
# $$
# \mathrm{sum}(x) = \sum_{i=1}^n x_i.
# $$

# Generate a vector of random numbers

# + {"slideshow": {"slide_type": "subslide"}}
a = rand(10^3);

# + [markdown] {"slideshow": {"slide_type": "-"}}
# The expected value is 500, since the vector `a` has a uniform distribution on [0,1) with each entry having a mean of 0.5.

# + {"slideshow": {"slide_type": "-"}}
 sum(a)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ## Calling Python's built-in `sum` 

# + [markdown] {"slideshow": {"slide_type": "-"}}
# The `PyCall` package provides a Julia interface to Python:

# + {"slideshow": {"slide_type": "-"}}
# Using Pkg; Pkg.add("PyCall")
using PyCall
# -

# Let's use the Python built-in "sum" function:

# + {"slideshow": {"slide_type": "-"}}
pysum = pybuiltin("sum")

# + {"slideshow": {"slide_type": "-"}}
pysum(a)
# -

# Verify that the output of Julia's and Python's built-in sum functions are similar.

# + {"slideshow": {"slide_type": "-"}}
pysum(a) ≈ sum(a) # \approx ~ isapprox()

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ## Calling hand-written Python `sum` function 
#
#
# #### Loading local Python code
# In this example, we wrote a Python code, *python_sum.py*,  to compute our `sum` function and then source it from Julia using `PyCall`. This method permits us to load the code locally within Julia.

# + [markdown] {"slideshow": {"slide_type": "-"}}
#
# _filename: python_sum.py_
#
# ```python
# def py_sum(R):
#     s = 0.0
#     for r in R:
#         s += r
#     return s
# ```
# -

# We use the `pyimport()` function to directly source our Python code file.    
# First, we need to add the local directory to `pyimport()` searching path.

# + {"slideshow": {"slide_type": "-"}}
pushfirst!(PyVector(pyimport("sys")."path"), @__DIR__);  
# -

# Then, we generate a new module, **e.g.** `python_sum`, that can export the function `py_sum` from the file python_sum.py.

# + {"slideshow": {"slide_type": "subslide"}}
python_sum = pyimport("python_sum") 

# + {"slideshow": {"slide_type": "-"}}
python_sum.py_sum(a)
# -

# #### Wrapping Python code in Julia

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# The other option consist in writting our Python function and wrap it into the Julia macro `py`:
# -

py"""
def py_sum2(R):
    s = 0.0
    for r in R:
        s += r
    return s
"""
sum_py = py"py_sum2"

# + {"slideshow": {"slide_type": "-"}}
sum_py(a)

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ## Importing Python libraries 
#
# Here is a simple example to call Python `math` library and its sinus function `math.sin`:

# + {"slideshow": {"slide_type": "-"}}
math = pyimport("math")
math.sin(math.pi / 4) 

# + [markdown] {"slideshow": {"slide_type": "subslide"}}
# Now, let's consider the case where we need to add a library to our environment. As an example, let's add `numpy` which is a high-performance library written in C and can be accessed from Python. To install it in Julia and use its `sum` function, we can follow these steps:

# + {"slideshow": {"slide_type": "-"}}
# using Pkg; Pkg.add("Conda")
using Conda
# In case numpy is not already installed run:
# Conda.add("numpy");
# -

# *Please note that if you encounter an error while loading your library, you should verify your Python environment. You can learn how to specify the Python version by following this [link](https://github.com/JuliaPy/PyCall.jl#specifying-the-python-version). If you want to use Python from `Conda.jl`, simply set the environment as follows:* 
# ```julia
# julia> ENV["PYTHON"]=""
# ```
# We can use now the sum function from the `numpy` library:    
#

# + {"slideshow": {"slide_type": "subslide"}}
numpy_sum = pyimport("numpy")."sum"

# + {"slideshow": {"slide_type": "-"}}
numpy_sum(a)
# -

versioninfo()

# + [markdown] {"slideshow": {"slide_type": "slide"}}
# ## Summary
#
# * Access to a large number of Python libraries: `PyCall.jl` enables Julia users to access the vast ecosystem of Python libraries, including popular ones such as NumPy, Pandas, and TensorFlow.
#
# * Improved interoperability: `PyCall.jl` allows Julia users to seamlessly integrate their Julia code with existing Python codebases, improving interoperability between the two languages.
#
# * Faster prototyping: By leveraging the strengths of both languages, PyCall.jl enables users to prototype and experiment with different algorithms and models quickly.
#
# * Easy deployment: PyCall.jl makes it easy to deploy Julia code that relies on Python libraries, as the necessary Python dependencies can be installed along with the Julia code.
#
# * Similar packages exists also for R, Java, C++ and C.
