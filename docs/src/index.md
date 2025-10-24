# GroebnerWalk.jl

[GroebnerWalk.jl](https://github.com/ooinaruhugh/GroebnerWalk.jl#readme) provides several variants of Gröbner walk algorithms for 
converting Gröbner bases. For this, we make use of the computer algebra system [OSCAR](https://oscar-system.github.io/Oscar.jl).

## Installation
For this package we require Julia version 1.10 or higher and OSCAR in at least version 1.0.

Both OSCAR and this package can be installed using the Julia package manager. 
Open the Julia prompt and type `]` and enter the following command
```julia
pkg> add Oscar, GroebnerWalk
```

Equivalently, you can enter
```julia
julia> using Pkg; Pkg.add(["Oscar", "GroebnerWalk"])
```

## Quick start

The Gröbner walk is also implemented in OSCAR and can be used by calling the function `groebner_walk`.
Thus, it is sufficient to load OSCAR to use the Gröbner walk.
```julia
using Oscar

R, (x,y) = QQ[:x, :y]            # define ring ...
I = ideal([y^4+ x^3-x^2+x,x^4])  # ... and ideal

groebner_walk(I)                 # compute the Groebner basis
```

If you specifically wish to use the implementation contained in this package, you need to call it using 
the fully qualified name `GroebnerWalk.groebner_walk`. 

