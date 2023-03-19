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

# ## Exercise - Julia Basics

# #### Ex.1: Look up documentation for the `rand()` function

?rand

# #### Ex.2: Assign two random integers between 1 an 10 to two Unicode input variables of your choice. ([list of Unicode input](https://docs.julialang.org/en/v1/manual/unicode-input/)).   
# *hint: rand(1:10)*  
# Warning: some unicode input are reserved. For example, the unicode \sqrt is reserved for the actual square root function.
# ```julia
# √ 2
# 1.4142135623730951
# ```

🌞 = rand(1:10) 

🌈 = rand(1:10)

# #### Ex.3: Write a function that takes two input arguments, adds them together, and then multiplies the sum by 2.
# *Hint: type "?function" to get documentaion about writing a function*

?function

function f(x, y)
   return (x + y)*2 
end

# Or, we can use the mathematical expression:

f(x, y) = (x + y)*2 

# #### Ex.4: Apply the function to the two Unicode variables created previously.

f(🌞, 🌈)
