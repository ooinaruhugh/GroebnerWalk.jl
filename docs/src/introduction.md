
# Usage

The Gröbner walk is an approach to reduce the computational complexity of Gröbner basis computations 
that was originally proposed in [Amrhein.Gloor.ea:1997](@cite).

This is done by performing a reverse local search on the cones of the Gröbner fan.
Then, a Gröbner basis is calculated for each encountered cone while reusing the generators obtained 
from the previous cone.

The implemented algorithms may be accessed using the following function.


```@docs
    groebner_walk(
      I::MPolyIdeal, 
      target::MonomialOrdering = lex(base_ring(I)),
      start::MonomialOrdering = default_ordering(base_ring(I));
      perturbation_degree = ngens(base_ring(I)),
      algorithm::Symbol = :standard
    )
```
    
