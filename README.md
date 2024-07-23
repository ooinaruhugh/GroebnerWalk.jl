# Gröbner walk

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.11065978.svg)](https://doi.org/10.5281/zenodo.11065978)

GroebnerWalk provides implementations of Gröbner walk algorithms
for computing Gröbner bases over fields in Oscar.jl.

## Usage

GroebnerWalk provides its entire functionality through the function `groebner_walk`.
The following example demonstrates the usage. First, we define the ideal.
```julia
R, (x,y) = QQ[:x, :y]                  # define ring ...
I = ideal([y^4+ x^3-x^2+x,x^4])        # ... and ideal
```

Then, we can pass the ideal to `groebner_walk` to calculate the Gröbner basis.
Here, we want a Gröbner basis with respect to the lexicographic ordering on `R`.
```julia
using Oscar
using Oscar.GroebnerWalk

groebner_walk(I, lex(R)) # compute the Groebner basis
```

## Status
At the moment, the standard walk by Collart, Kalkbrener and Mall (1997) and the generic walk by Fukuda et al. are implemented.

## Contacts
The library is maintained by Kamillo Ferry (kafe (at) kafe (dot) dev) and Francesco Nowell (francesconowell (at) gmail (dot) com).

## Acknowledgement
The current implementation is based on an implementation by Jordi Welp. We thank him for 
laying the groundwork for this package.

## References
- Collart, S., M. Kalkbrener, and D. Mall. ‘Converting Bases with the Gröbner Walk’. Journal of Symbolic Computation 24, no. 3–4 (September 1997): 465–69. https://doi.org/10.1006/jsco.1996.0145.
- Fukuda, K., A. N. Jensen, N. Lauritzen, and R. Thomas. ‘The Generic Gröbner Walk’. Journal of Symbolic Computation 42, no. 3 (1 March 2007): 298–312. https://doi.org/10.1016/j.jsc.2006.09.004.

