# GroebnerWalk.jl

[GroebnerWalk.jl](https://github.com/ooinaruhugh/GroebnerWalk.jl#readme) provides several variants of Gröbner walk algorithms for 
converting Gröbner bases. For this, we make use of the computer algebra system [OSCAR](https://oscar-system.github.io/Oscar.jl).

## Installation
For this package we require Julia version 1.10 or higher.


To use [GroebnerWalk.jl](https://github.com/ooinaruhugh/GroebnerWalk.jl), we require Oscar.jl.
Both packages can be installed using the Julia package manager. 
Open the Julia prompt and type `]` and enter the following command
```julia
pkg> add Oscar, GroebnerWalk
```

Equivalently, you can enter
```julia
julia> using Pkg; Pkg.add(["Oscar", "GroebnerWalk"])
```

## Quick start

Once you have installed the package, you can start using it in your Julia code. Here's a simple example:

```julia
using Oscar, GroebnerWalk

R, (x,y) = QQ[:x, :y]            # define ring ...
I = ideal([y^4+ x^3-x^2+x,x^4])  # ... and ideal

groebner_walk(I)                 # compute the Groebner basis
```
