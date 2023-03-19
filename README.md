# ENAR 2023: Julia Workshop

**Sunday, March 19 | 1:00 pm – 5:00 pm**   
**SC6 | An Introduction to Julia for Biostatistics**

**Instructors:**   
- **Saunak Sen**, Division of Biostatistics, Department of Preventive Medicine, University of Tennessee Health Science Center    
- **Gregory Farage**, Division of Biostatistics, Department of Preventive Medicine, University of Tennessee Health Science Center    

**Teaching Assistant:**
- **Zifan (Fred) Yu,** Scientific Research Programmer, Division of Biostatistics, Department of Preventive Medicine, University of Tennessee Health Science Center

## Description 

Julia is an open-source programming language for scientific computing that offers several attractive features for data science. It offers the prototyping simplicity of an interpreted language such as R or Python with the speed of compiled languages such as C/C++. It has strong support for visualization, interactive graphics, machine learning, and parallel computing.    

The short course will begin with the basics of getting started with Julia using the terminal and an IDE (integrated development environment). We will present Julia's language design and features comparing it with other languages. We will demonstrate how to install/uninstall packages and use commonly-used packages. We will then show basic data science tasks such as manipulating tabular data, statistical tests, regression, graphics, report generation, and connecting to R/Python/C libraries. Students will have the opportunity to get hands-on experience in Julia programming via examples and small exercises related to data science and scientific computing.   

Statistical/programming knowledge required:    
* No prior experience with Julia is required.  
* Prior programming experience in a language such as R, SAS, Stata, MATLAB, or Python is  required.   
* We will assume that participants have statistical knowledge equivalent to a master's degree in statistics or biostatistics.

## Outline

### Julia for Biostatistics 1:00pm-5:00pm

| Time | Topic |
|:-----------|:------------|
| 1:00-1:30 | Why Julia? - Julia installation and REPL/Pkg |
| 1:30-2:30 | Syntax and Language Design - Getting Started - Macro - Data Structure |
| 2:00-2:30 | Mundane data analysis tasks |
| 2:30-3:00 | Graphics |
| 3:30-4:00 | Scientific Computing |
| 4:00-4:30 | Connecting - to R/Python libraries |
| 4:30-5:00 | Machine learning and Bayesian Analysis |

## Intruction to load required Julia packages

The project file `Project.toml` contains the information of the package/project dependencies that we will use for the workshop. Follow the instructions below to instantiate packages.  

Open your Terminal, `cd` to move into the folder `ENAR2023JuliaWorkshop` you downloaded in your computer.
(make your Terminal session is **inside** the folder)

After a successful installation of Julia, launch Julia REPL (you should be able to launch Julia by typing `julia` from the Terminal) and then follow the steps below:

- First, type `]` in Julia REPL. This will move you to the Pkg REPL, which is the package manager in Julia.

```julia
julia> ]
```
You shall see `(@v1.8) pkg>` when you are in the Pkg REPL.

- Next, run

```julia
(@v1.8) pkg> activate .
```

to activate the package environment of the current Julia project ("ENAR2023JuliaWorkshop").

At this point, you should see that `(@v1.8)`  changed to `(ENAR2023JuliaWorkshop)`.

- Then, run 

```
(ENAR2023JuliaWorkshop) pkg> resolve
(ENAR2023JuliaWorkshop) pkg> instantiate
```

Then it will load to the Julia only the packages required for this workshop. 

- Check if your current Julia session has all you need: run

```
(ENAR2023JuliaWorkshop) pkg> status
```

Comparing the output printed out with the `ENAR2023JuliaWorkshop/Project.toml` file, you shall confirm that you have loaded all the packages with the versions matched with in `Project.toml`.

## Resources

#### Tutorial

- [Quick Start](https://www.juliafordatascience.com/quickstart/)
- [Julia language](https://www.julialang.org)
- [Official Julia documentation](https://docs.julialang.org/en/v1/)
- [JSM-Julia-Short-Course-2022](https://github.com/GregFa/JSM-Julia-Short-Course-2022)
- [Julia Academy](https://juliaacademy.com/courses/)
- [Julia code practice and learning site](https://exercism.io/tracks/julia) 
- [Introducing Julia](https://en.wikibooks.org/wiki/Introducing_Julia)
- [RIP tutorial](https://riptutorial.com/julia-lang)
- [Book: Statistics with Julia](https://statisticswithjulia.org/)
- [Julia cheatsheet](https://juliadocs.github.io/Julia-Cheat-Sheet/)
- [Sen Research Group Resources](https://senresearch.github.io/)
 

#### Extra

- [Annual Julia User & Developer Survey 2021](https://julialang.org/blog/2021/08/julia-user-developer-survey/) presented by Andrew Claster.
- [Annual Julia User & Developer Survey 2019](https://julialang.org/blog/2019/08/2019-julia-survey) presented by Viral Shah.
- [Announcing composable multi-threaded parallelism in
  Julia](https://julialang.org/blog/2019/07/multithreading)
- [Remark.jl](https://github.com/piever/Remark.jl "Package on Github") created by Pietro Vertechi   
"*Create markdown presentations from Julia*"
- [JuDoc.jl](https://github.com/tlienart/JuDoc.jl "Package on Github") created by Thibaut Lienart   
"*Static site generator. Simple, fast, compatible with basic LaTeX,
maths with KaTeX, optional pre-rendering, written in Julia.*"
- [Pluto.jl](https://github.com/fonsp/Pluto.jl "Package on Github") created by Fons Varder Plas   
"*Reactive Notebook, written in Julia.*"
- [Plots.jl](https://github.com/JuliaPlots/Plots.jl "Package on Github") created by Tom Breloff   
"*Plotting metapackage: it's an interface over many different plotting libraries.*"



#### Useful links


[A Comprehensive Tutorial to Learn Data Science with Julia from Scratch](https://www.analyticsvidhya.com/blog/2017/10/comprehensive-tutorial-learn-data-science-julia-from-scratch/)

[10 Reasons Why You Should Learn Julia](https://blog.goodaudience.com/10-reasons-why-you-should-learn-julia-d786ac29c6ca)

[Noteworthy Differences from other Languages](https://docs.julialang.org/en/v1/manual/noteworthy-differences/)

[Julia Cheat Sheet](https://juliadocs.github.io/Julia-Cheat-Sheet/)
