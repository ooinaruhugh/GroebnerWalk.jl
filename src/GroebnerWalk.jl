module GroebnerWalk
using Oscar

using PrecompileTools: @setup_workload, @compile_workload

import Oscar: 
  IdealGens,
  MonomialOrdering,
  ngens,
  weight_ordering,
  ZZMatrix,
  ZZRingElem 


import Oscar.Orderings: 
  MatrixOrdering,
  _support_indices

include("markedGB.jl")
include("common.jl")

include("special-ideals.jl")

include("standard-walk.jl")
include("generic-walk.jl")
include("perturbed-walk.jl")

export groebner_walk
export groebner_walk_with_detection

function groebner_walk_with_detection end

export newell_patch
export newell_patch_with_orderings

function __init__()
    add_verbosity_scope(:groebner_walk)
end

@setup_workload begin
  __init__()
  R, (x,y) = polynomial_ring(QQ, [:x,:y])
  I = ideal([y^4+ x^3-x^2+x,x^4])

  @compile_workload begin
    groebner_walk(I, lex(R))
    groebner_walk(I, lex(R); algorithm=:generic)
  end
end

end

