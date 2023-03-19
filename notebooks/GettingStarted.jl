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

# # Getting Started with Julia Programming
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
# Julia is a high-level, high-performance dynamic programming language designed for numerical and scientific computing. In this tutorial, we will cover some of the basics of Julia programming, including how to assign variables, print results, add comments, and search for help.
#
# *References for this notebook:*
# * [The Julia language: Variable](https://docs.julialang.org/en/v1/manual/variables/)
# * [Excelling at Julia Basics and Beyond (Huda Nassar, Jane Herriman)](https://github.com/xorJane/Excelling-at-Julia-Basics-and-Beyond)
# * [wikibooks - The REPL](https://en.wikibooks.org/wiki/Introducing_Julia/The_REPL)

# + [markdown] slideshow={"slide_type": "subslide"}
# ### Outline of this notebook
#
# - Assigning Variables
# - Unicode Character
# - Printing Results
# - Adding Comments
# - Seraching for Help
# -

# ## Assigning Variables
# In Julia, we can assign values to variables using the `= `operator. Here is an example:

x = 10

# This assigns the value 10 to the variable x. We can also assign the result of an expression to a variable:

y = 2 * x

# This assigns the result of 2 * x to the variable y.

# ## Unicode Characters
#
# Julia supports Unicode characters, which can be useful for writing mathematical expressions, symbols, and other special characters, including mathematical symbols, Greek letters.
#
# Unicode characters can be typed directly into the code editor, as long as the editor supports Unicode input. The good news is that the Julia REPL supports Unicode.
#
# For example, to type the Greek letter alpha (α), you can simply type \alpha and press the TAB key. This will replace \alpha with the actual character.

α = 7

# We can also special character such as:

🐸 = 3

🐸 + α

# All possible input unicodes can be found [here](https://docs.julialang.org/en/v1/manual/unicode-input/)

# ## Printing Results
# To print the value of a variable or an expression, we can use the println() function. Here is an example:

println("The value of x is ", x)
println("The value of y is ", y)

# This will print the values of x and y to the console.

# ## Adding Comments
# Comments are used to add notes or explanations to code, and are ignored by the Julia interpreter. In Julia, comments start with the # character. Here is an example:

# This is a comment
x = 10 # This is also a comment

# Comments can be added to the end of a line of code, or on a separate line.

# ## Searching for Help
# Julia has extensive built-in documentation, which can be accessed using the ? operator. For example, to get help on the println() function, we can type ?println in the Julia console:

?println

# This will display the documentation for the `println()` function.

versioninfo()

# ## Summary
# This notebook covered some of the basics of Julia programming, including how to assign variables, print results, add comments, and search for help. 

# ## Exercise - Julia Basics

# #### Ex.1: Look up documentation for the `rand()` function



# #### Ex.2: Assign two random integers between 1 an 10 to two Unicode input variables of your choice. ([list of Unicode input](https://docs.julialang.org/en/v1/manual/unicode-input/)).   
# *hint: rand(1:10)*  
# Warning: some unicode input are reserved. For example, the unicode \sqrt is reserved for the actual square root function.
# ```julia
# √ 2
# 1.4142135623730951
# ```





# #### Ex.3: Write a function that takes two input arguments, adds them together, and then multiplies the sum by 2.
# *Hint: type "?function" to get documentaion about writing a function*



# #### Ex.4: Apply the function to the two Unicode variables created previously.


