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

# ## Exercise - Data Structure

# #### Ex.1: Arrays in Julia
#
# Create a 3x3 matrix A with random integers between 1 and 10 using the function `rand()`. Then check the data type of the A.

# ##### Ex.1 - solution:

A = rand(1:10, 3, 3)

# Or, by hand

A = Array{Int, 2}(undef, 3, 3);
for i in 1:3
    for j in 1:3
        A[i, j] = rand(1:10)
    end
end
A

# Using `typeof()` to see the data type of A, you'll see

typeof(A) # Check the data type of the A.

# #### Ex.2: Functions in Julia
# Define a function `f(x)` that takes in an integer number x and returns its squared value.



# ##### Ex.2 - solution:

function f(x::Int)
    return x^2
end

# #### Ex.3: Loops in Julia
#
# Apply the function f(x) to each element of the matrix A using a loop, with the number of iterations obtained by `size(A)`, and then store the result in a new matrix B.



# ##### Ex.3 - solution:

B = copy(A);
for i in 1:3
    for j in 1:3
        B[i, j] = f(A[i, j])
    end
end

B

# #### Ex.4: Broadcasting
#
# Apply this function f(x) to each element of the matrix A using broadcasting (by `f.()`) and store the result in a matrix C.

f(A)

# ##### Ex.4 - solution:

C = f.(A)

A

# #### Ex.5 Tuples in Julia
# Create a tuple of three, containing the numbers in the second column of matrix A, and store the results in the new tuple D.
#
# Check the data type of D.



# ##### Ex.5 - solution:

D = (A[1, 2], A[2, 2], A[3, 2])

# Or,

D = Tuple(A[:, 2])

typeof(D)

A # check if the numbers match

# #### Optional: Broadcasting in the Tuple
#
# Apply the function f(x) to the tuple D with broadcasting. 
#
# Assign the output to variable E.



# ##### solution:

E = f.(D)
