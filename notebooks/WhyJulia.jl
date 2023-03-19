### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 0b6fe281-ff5f-4062-9d75-2e97bc0680dc
using Pkg

# ╔═╡ 785c7ff0-be2e-4d18-a34c-d5f63cff5d17
Pkg.activate("~/GIT/enar_julia_workshop_2023")

# ╔═╡ c8b9a5cb-cf22-4919-81a7-7a3d94ce20f4
using Plots

# ╔═╡ 9c645d11-6ffd-4993-9ed4-e972a5d53a90
begin
  using Random, Distributions
  Z = rand(Normal(),10000,100)
end;

# ╔═╡ 7865244c-c13d-4565-909c-b9fc6e857aef
html"<button onclick='present()'>present</button>"

# ╔═╡ 941bde5c-4c72-4362-b43a-0d77a120f896
md"""
# ENAR 2023: Julia Workshop

**Sunday, March 19 | 1:00 pm – 5:00 pm**  
**SC6 | An Introduction to Julia for Biostatistics**

**Instructors:**   
- **Saunak Sen,** Professor, Division of Biostatistics, Department of Preventive Medicine, University of Tennessee Health Science Center    
- **Gregory Farage,** Instructor, Division of Biostatistics, Department of Preventive Medicine, University of Tennessee Health Science Center

**Teaching Assistant:**
- **Zifan (Fred) Yu,** Scientific Research Programmer, Division of Biostatistics, Department of Preventive Medicine, University of Tennessee Health Science Center
"""


# ╔═╡ 1eb2b962-c64e-11ed-3a48-53c869cfc1d3
md"""
# Why Julia?

    Saunak Sen
    Division of Biostatistics
    Department of Preventive Medicine
    University of Tennessee Health Science Cener

    ENAR Workshop 2023
    2023-03-19
"""

# ╔═╡ df4985a0-c9d3-46b8-936b-8be4e47ada1d
md"""
# Our journey with Julia

- A chance encounter in 2015
- Used for penalized matrix linear models
- Many packages since
"""

# ╔═╡ 5aaace6d-08f3-4086-b210-cc3d427d8ceb
md"""
## Our registered packages

- BulkLMM.jl Julia package for performing a large number of univariate linear mixed model genome scans; suitable for eQTL analysis and genome scans with high-throughput phenotypes (Zifan Yu, Gregory Farage, Saunak Sen)
- GeneNetworkAPI.jl Julia interface to the GeneNetwork API (Chelsea Trotter, Gregory Farage, Saunak Sen)
- MatrixLMnet.jl Julia package for elastic net penalized matrix linear models (Jane Liang, Gregory Farage, Chenhao Zhao)
- MatrixLM.jl Julia package with core functions for matrix linear models (Jane Liang, Gregory Farage, Chenhao Zhao)
- Helium.jl A fast and flexible Julia tabular serialization format (Gregory Farage)
- FlxQTL.jl Julia package for multivariate LMMs for structured traits (Hyeonju Kim)
- LiteQTL.jl Julia package for eQTL scans using GPUs (Chelsea Trotter)
- GeneticScreens.jl Julia package for analysis of high-throughput genetic screens (Jane Liang)
- FastLMM.jl Julia package for univariate LMMs (Saunak Sen)
"""

# ╔═╡ 68c50a16-6b0f-4251-9af5-ed64ac0fa925
md"""
# Reasons for our choice

- Try something new
- Pleasing syntax
- Prototype code is fast
- Parallel/distributed computing support


- Easy to learn
- Abstractions using types and multiple dispatch
- Growing ecosystem, innovative packages
- Package manager, development system
"""

# ╔═╡ e17b576f-5964-4fac-ae5e-7253d0d6adc3
md"""
# Pleasing syntax
"""

# ╔═╡ 047cc67f-36d8-48a4-a1f9-5b8905179abb
X = [ 2 1; 3 4]

# ╔═╡ 0398c9be-c9f5-4413-975c-2a7f89b8b2d3
X'X

# ╔═╡ 5f69a062-7cc3-4db9-b692-64bbd2845242
md"""
# Prototype code is fast
"""

# ╔═╡ 380feca1-304f-42ad-b445-ffdb697a765d
Pkg.instantiate()

# ╔═╡ 866dda2e-df4a-481c-af1e-493e6906e2a6
@time Z*inv(Z'Z)*(Z');

# ╔═╡ 26dcecb1-0095-46f7-8cbf-0709fa28f118
md"""
# Parallel, distributed, multi-threaded, GPU computing support

- Easy to distribute jobs
- Linear algebra is multi-threaded by default
- Shared memory objects
- Multi-threading support
- GPU kernels (see LiteQTL.jl paper)
"""

# ╔═╡ 0ddd8294-41e0-4934-be31-89d1e8a5380d
md"""
# Easy to learn

- Extensive documentation
- Easy, familiar syntax
- Tutorials/books
"""

# ╔═╡ 09f049ab-2b81-46bd-b65c-d0e901ec8e1a
md"""
# Abstractions, multiple dispatch
"""

# ╔═╡ 7cce1fae-8bd3-42df-b540-b687af51e477
cdf(Normal(),0.0)

# ╔═╡ e2dcd48c-49b6-44af-a8d7-581577c27a58
cdf(Exponential(), 0.0)

# ╔═╡ 082b5fd1-c146-4ec6-89f8-65688c79052c
begin
	import Base.+
	+(d1::Distribution,d2::Distribution) = convolve(d1,d2)
end

# ╔═╡ 948f5fc8-f4aa-467d-8679-94d42cc48aec
f(x) = x^2 + x + 1;

# ╔═╡ 140a3f18-c79e-40cc-8b82-6798c5746b7c
plot( x-> π + 2sin(x^2), -4, 4,label="quadratic")

# ╔═╡ b33f62a7-5a02-4c13-95a3-ba86662979fc
Exponential()+Exponential()+(Exponential()+Exponential())

# ╔═╡ c1042d89-11ff-4ef6-9b35-ca54bb634ca1
md"""
# Growing ecosystem

- Statistical analysis: GLM, LinearMixedModels, DataFrames
- Machine learning: Flux, MLJ
- Bayesian analysis: Turing
- Pharma: Pumas
"""

# ╔═╡ ebd920a7-d96e-47cf-9879-d7371eec8d39
md"""
# Package development

- Modern package manager
- Support for environments
- Versioned package development system
- Private and public registries
"""

# ╔═╡ c6e6496a-297f-4df6-a16e-0d71cee13baf
md"""
# Julia sets
"""

# ╔═╡ c8982135-39ad-4464-9373-1f57fcb73c89
begin

	f(z::Complex,c::Complex) = z^2 + c

	function level(z::Complex,c,f::Function,n::Int64=500,R::Float64=10.0)
    	i = 0
    	while( (i<N) & (abs(z)<R) )
        	z = f(z,c)
        	i += 1
    	end
    	return i/(n+1)
	end

	logit(x) = log(x/(1-x))

	N = 500
	x = y = ((-N):N)/N
	z = complex.(x,y')
	c0 = complex(-1.0,0.0)
	c1 = complex(-0.75,0.3)
	c2 = complex(-0.65,0.45)
	w = abs.(logit.(level.(z,c2,f)));

	# colorschemes https://makie.juliaplots.org/stable/colors.html
	Plots.heatmap(x,y,w',size=(500,500),xaxis=false,yaxis=false,legend=false,color=:blues)
end

# ╔═╡ 5b6831ae-0039-41ee-9b32-e7e0aa534659
plot(f,-4,4,label="f")

# ╔═╡ Cell order:
# ╟─7865244c-c13d-4565-909c-b9fc6e857aef
# ╟─941bde5c-4c72-4362-b43a-0d77a120f896
# ╟─1eb2b962-c64e-11ed-3a48-53c869cfc1d3
# ╟─df4985a0-c9d3-46b8-936b-8be4e47ada1d
# ╟─5aaace6d-08f3-4086-b210-cc3d427d8ceb
# ╟─68c50a16-6b0f-4251-9af5-ed64ac0fa925
# ╟─e17b576f-5964-4fac-ae5e-7253d0d6adc3
# ╠═c8b9a5cb-cf22-4919-81a7-7a3d94ce20f4
# ╠═047cc67f-36d8-48a4-a1f9-5b8905179abb
# ╠═0398c9be-c9f5-4413-975c-2a7f89b8b2d3
# ╠═948f5fc8-f4aa-467d-8679-94d42cc48aec
# ╠═5b6831ae-0039-41ee-9b32-e7e0aa534659
# ╠═140a3f18-c79e-40cc-8b82-6798c5746b7c
# ╟─5f69a062-7cc3-4db9-b692-64bbd2845242
# ╠═0b6fe281-ff5f-4062-9d75-2e97bc0680dc
# ╠═785c7ff0-be2e-4d18-a34c-d5f63cff5d17
# ╠═380feca1-304f-42ad-b445-ffdb697a765d
# ╠═9c645d11-6ffd-4993-9ed4-e972a5d53a90
# ╠═866dda2e-df4a-481c-af1e-493e6906e2a6
# ╟─26dcecb1-0095-46f7-8cbf-0709fa28f118
# ╟─0ddd8294-41e0-4934-be31-89d1e8a5380d
# ╟─09f049ab-2b81-46bd-b65c-d0e901ec8e1a
# ╠═7cce1fae-8bd3-42df-b540-b687af51e477
# ╠═e2dcd48c-49b6-44af-a8d7-581577c27a58
# ╠═082b5fd1-c146-4ec6-89f8-65688c79052c
# ╠═b33f62a7-5a02-4c13-95a3-ba86662979fc
# ╟─c1042d89-11ff-4ef6-9b35-ca54bb634ca1
# ╟─ebd920a7-d96e-47cf-9879-d7371eec8d39
# ╟─c6e6496a-297f-4df6-a16e-0d71cee13baf
# ╟─c8982135-39ad-4464-9373-1f57fcb73c89
