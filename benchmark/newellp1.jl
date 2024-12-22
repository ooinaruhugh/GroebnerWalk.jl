using Oscar: newell_patch_with_orderings
using GroebnerWalk

global kk

I, target, start = newell_patch_with_orderings(kk)
R = base_ring(I)
