# Gröbner walk

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.11065978.svg)](https://doi.org/10.5281/zenodo.11065978)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ooinaruhugh.github.io/GroebnerWalk.jl/dev)
[![CI](https://github.com/ooinaruhugh/GroebnerWalk.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/ooinaruhugh/GroebnerWalk.jl/actions/workflows/CI.yml)

GroebnerWalk.jl is a Julia package providing implementations of Gröbner walk algorithms
for computing Gröbner bases over fields on top of [Oscar.jl](https://oscar-system.github.io/Oscar.jl).

Most of the functionality of this package is also contained in Oscar.jl. This version of the package serves as testbed for experiments and improvements
independently from the development cycle of Oscar.jl.

## Usage

GroebnerWalk.jl provides its entire functionality through the function `groebner_walk`.
The following example demonstrates the usage. First, we define the ideal using `Oscar`.
```julia
using Oscar

R, (x,y) = QQ[:x, :y]               # define ring ...
I = ideal([y^4+ x^3-x^2+x,x^4])     # ... and ideal
```

By default, `groebner_walk` starts with a Gröbner basis with respect to the default ordering on `R`
and converts this into a Gröbner basis with respect to the lexicographic ordering on `R`.
This is what the following code block accomplishes.
```julia
groebner_walk(I)                    # compute the Groebner basis
```
By default, this package does not export `groebner_walk` to avoid name clashes with the version in Oscar.jl. 
The implementation in this package is available under `GroebnerWalk.groebner_walk`.

If one wants to specify `target` and `start` orderings explicitly, above function call needs to be written as follows.
```julia
groebner_walk(I, lex(R), default_ordering(R)) # compute the Groebner basis
```

For more detailed usage instructions and examples, please refer to the [documentation](https://ooinaruhugh.github.io/GroebnerWalk.jl/).

## Status
At the moment, the standard walk by Collart, Kalkbrener and Mall (1997) and the generic walk by Fukuda et al. (2007) are implemented.

## Documentation 
The documentation for the GroebnerWalk.jl package can be found at <https://ooinaruhugh.github.io/GroebnerWalk.jl>

## Contacts
The library is maintained by Kamillo Ferry (kafe (at) kafe (dot) dev) and Francesco Nowell (francesconowell (at) gmail (dot) com).

## Acknowledgement
The initial implementation was based on an implementation by Jordi Welp. We thank him for 
laying the groundwork for this package.

## References
- Collart, S., M. Kalkbrener, and D. Mall. [‘Converting Bases with the Gröbner Walk’](https://doi.org/10.1006/jsco.1996.0145). Journal of Symbolic Computation 24, no. 3–4 (1997): 465–69.
- Cox, David A., John Little, and Donal O’Shea. [Using Algebraic Geometry](https://doi.org/10.1007/b138611). Vol. 185. Graduate Texts in Mathematics. New York: Springer-Verlag, 2005.
- Fukuda, K., A. N. Jensen, N. Lauritzen, and R. Thomas. [‘The Generic Gröbner Walk’](https://doi.org/10.1016/j.jsc.2006.09.004). Journal of Symbolic Computation 42, no. 3 (2007): 298–312.

