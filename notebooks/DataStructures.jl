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

# # Data Structures in Julia
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
# Julia has a rich collection of built-in data structures that make it easy to handle and manipulate data in various formats.
# In this tutorial, we will explore four of the most commonly used data structures in Julia: 
# * Arrays
# * Tuples
# * Named Tuples
# * Dictionaries
#
# We will cover how to create, access, and modify each data structure.
#
# *References for this notebook:*
# * [Julia language: a concise tutorial - Data Type](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/data-types)
# * [MIT lectures](https://github.com/mitmath/18S096)
# * [Excelling at Julia Basics and Beyond (Huda Nassar, Jane Herriman)](https://github.com/xorJane/Excelling-at-Julia-Basics-and-Beyond)
# * [wikibooks - Introducing Julia/Arrays and tuples](https://en.wikibooks.org/wiki/Introducing_Julia/Arrays_and_tuples)

# + [markdown] slideshow={"slide_type": "subslide"}
# ### Outline of this notebook
#
# - Arrays
# - Tuples 
# - Named Tuples
# - Dictionaries 
# -

# ## Arrays
# An array is a collection of elements of the same type, arranged in one or more dimensions. Arrays can be used to represent matrices, vectors, tables, and other data structures.

# ### Creating Arrays
# We can create an array in Julia using the Array constructor or the `[ ]` syntax. For example, let's create an array of integers:

arr = []

# We can also create an array with initial values by specifying them inside the square brackets:

arr = [1, 2, 3, 4, 5]

# In this case, the array arr has five elements with values 1, 2, 3, 4, and 5.   
# An array of one dimension is also called `Vector`.

typeof(arr)

# We note that `typeof(arr)` returned:
# * the type of our data structure: `Array`
# * the type of each element: `Int64`
# * the dimension of our array: `1`.

# Let's create a 2-dimensional (2x4) array by hand: 

arr2 = [1 2 3 4;5 6 7 8]

# We can also create arrays of specific sizes filled up with zeros or ones by using the `zeros()` or `ones()` functions:

arr_0s = zeros(3, 3)

arr_1s = ones(2, 7)

# In these examples, zeros_array is a 3x3 array of zeros and ones_array is a 2x7 array of ones. Arrays of 2-dimensions are called `Matrix`.

typeof(arr_1s)

# The `rand()` function provides a different way to generate a vector or a matrix:

rand(10) # will create a vector of length 10

rand(3, 3) # will create a 3-by-3 matrix

# ### Indexing Arrays
# We can access individual elements of an array using indexing. In Julia, indexing starts at 1 (unlike some other programming languages, **e.g.** Python, where it starts at 0).

vect = collect('A':'G')

println(vect[1]) # prints A
println(vect[3]) # prints C

# We can also use slicing to access a range of elements in an array:

println(vect[5:7]) # prints ['E', 'F', 'G']

# We can also append elements to an array using the `push!()` function:

push!(vect, 'H')
println(vect) # prints ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

# ### Broadcasting across arrays
# Broadcasting is a way of applying an operation to each element of an array or collection, without explicitly writing a loop.   
# For example, let's say we have two matrix `mat1` and `mat2`:

mat1 = [1  2; 3 4]

mat2 = [0 3; 3 0]

# If we want to multiply the elements of mat1 and mat2 together, we can use broadcasting with the dot `.` operator:

mat1 .* mat2

# We can also use broadcasting with user-defined functions. To enable broadcasting for a function, we insert the `. operator` between the function name and its arguments.  
# As an example, let's apply the cosine funtion to each element of `mat2` and add 2:

cos.(mat2) .+ 2

# ### Useful Array Functions
#
# There are many useful functions that we can use with arrays in Julia. Here are some examples:
#
# * length(arr): returns the length of the array
# * size(arr): returns the length of each dimension the array
# * reverse(arr): returns the array in reverse order
# * sort(arr): sorts the array in ascending order
# * sum(arr): returns the sum of the elements in the array

# **Note: what is the type of the following array?**
# ```julia
# vec_new = [1, 2, 3, "A", "B", "C"]
# ```

# ## Tuples
#
# A tuple is a collection of elements that can be of different types and different size.   
# Unlike arrays, tuples are immutable, meaning that their elements cannot be changed after they are created.    

# ### Creating Tuples
#
# To create an empty tuple, we can use the `()` operator with no arguments:

tpl = ()

# To create a tuple with initial values, we specify them inside the parentheses:

tpl = ([1, 2, 3], "hello", 3.14)

# In this example, we create a tuple of an array of integers, a string, and a floating-point number.

# We can also convert a vector into a Tuple with the `Tuple()` constructor:

v = [1,2,3]
Tuple(v)

# ### Accessing Elements
#
# We can access elements in a tuple using indexing. The index of the first element in a tuple is always `1`.    
# For example, to access the first element of the tuple t we created earlier, we can use the following code:

tpl[1] # returns [1, 2, 3]

# ### Operations on Tuples
#
# Tuples support a variety of operations, including indexing, concatenation, and iteration.
# For example, let's concatenate two tuples:

tpl1 = ([1, 2], "A", "B")
tpl2 = (3.0, 5.0)
tpl3 = (tpl1, tpl2) # try using splat operator ...

# This creates a new tuple `tpl3` containing the tuples elements `tpl1` and `tpl2`.

# We can iterate over the elements of a tuple using a for loop. For example, let's iterate over the elements of a tuple:

for x in tpl
    println(x)
end

# ## Named Tuples in Julia
#
# Named tuples are a data structure in Julia that combine the features of tuples and dictionaries. Like tuples, they are immutable and ordered, but they also have named fields like dictionaries. This makes them a convenient way to store and access structured data.

# ### Creating a Named Tuple

# Named Tuples are similar to Tuples, but with the added feature of assigning a name to each element. To create a named tuple, the syntax involves using the `=` operator within the Tuple.For example, we can create a named tuple that represents the geographical coordinate of a location like this:

coor_Nashville = (latitude = 36.1627, longitude = -86.7816)

# This creates a named tuple `coor_Nashville` with two fields `latitude` and `longitude`, and assigns them the values 36.1627 and 36.1627, -86.7816, respectively.    
# We can also create a named tuple using the `NamedTuple` constructor:

coor_Nashville = NamedTuple{(:latitude, :longitude)}((36.1627, -86.7816))

# This is equivalent to the previous example.

# ### Accessing Fields in a Named Tuple
#
# We can access the fields in a named tuple using dot `.` notation. For example, to get the value of the `latitude` field in `corr_Nashville`, we can use:

coor_Nashville.latitude

# We can also access the fields using square bracket notation, like tuples:

coor_Nashville[1]

# ### Converting Named Tuples to Other Types
# We can convert a named tuple to a dictionary using the `Dict()` function with the `pairs()` function:

coor_Nashville_dict = coor_Nashville |> pairs |> Dict

# This creates a dictionary `coor_Nashville_dict` with the fields and values of `coor_Nashville`.

# We can also convert a named tuple to a regular tuple using the Tuple function:

coor_Nashville_tuple = Tuple(coor_Nashville)

# ## Dictionaries
#
# Dictionaries are collections of key-value pairs. Each key is associated with a value, and we can use the key to retrieve the corresponding value. Dictionaries are also known as associative arrays.

# ### Creating Dictionaries
#
# We can create a dictionary in Julia using the `Dict()` constructor or the `[ ]` syntax. For example, let's create a dictionary of names and ages:

ages_dict = Dict("Alice" => 25, "Bob" => 30, "Charlie" => 40, "Eve" => 35)

ages2_dict = Dict("Alice" => 25, "Bob" => 30, "Charlie" => 40, "Eve" => 35)

# We can observe that dictionnaries do not preserve order.

# *Notes: FYI [the story of Alice and Bob](https://en.wikipedia.org/wiki/Alice_and_Bob#:~:text=For%20example%2C%20%22How%20can%20Bob,a%20public%2Dkey%20cryptosystem%3F%22)*

# ### Accessing Elements
#
# We can access elements in a dictionary using the keys. For example, to access the age of Alice in the dictionary `ages_dict`, we can use the following code:

ages_dict["Alice"] 

# We can also use the function `get()` which requires a default value to return in case a key is not found in the dictionary:

get(ages_dict, "Bob", "key does not exist!!!")

get(ages_dict, "Mallory", "Key does not exist!!!")

# ### Removing Values from a Dictionary   
#
# You can remove a key-value pair from a dictionary using the `delete!()` function:

delete!(ages_dict, "Charlie")


# This will remove the key-value pair corresponding to the key "Charlie" from the dictionary.   
# Similarly, we can use the `pop!()` function:

pop!(ages_dict, "Eve")

ages_dict

versioninfo()

# ## Summary
#
# In this notebook, we learned how to create arrays, tuples and dictionaries, access their elements, and perform operations on them, such as concatenation, iteration, adding, and deleting element

# ## Exercise - Data Structure

# #### Ex.1: Arrays in Julia
#
# Create a 3x3 matrix A with random integers between 1 and 10 using the function `rand()`. Then check the data type of the A.



# #### Ex.2: Functions in Julia
# Define a function `f(x)` that takes in an integer number x and returns its squared value.



# #### Ex.3: Loops in Julia
#
# Apply the function f(x) to each element of the matrix A using a loop, with the number of iterations obtained by `size(A)`, and then store the result in a new matrix B.



# #### Ex.4: Broadcasting
#
# Apply this function f(x) to each element of the matrix A using broadcasting (by `f.()`) and store the result in a matrix C.



# #### Ex.5 Tuples in Julia
# Create a tuple of three, containing the numbers in the second column of matrix A, and store the results in the new tuple D.
#
# Check the data type of D.



# #### Optional: Broadcasting in the Tuple
#
# Apply the function f(x) to the tuple D with broadcasting. 
#
# Assign the output to variable E.


