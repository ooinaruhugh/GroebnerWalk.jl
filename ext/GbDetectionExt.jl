module GbDetectionExt
using Oscar
using GroebnerWalk
using SagbiGbDetection: weightVectorsRealizingGB

function GroebnerWalk.groebner_walk_with_detection(
  I::MPolyIdeal, 
  target::MonomialOrdering = lex(base_ring(I)),
  perturbation_degree = ngens(base_ring(I)), # meaning, n=#gens(R)
  algorithm::Symbol = :standard
)
  R = base_ring(I)
  sR = singular_poly_ring(R)
  w,_ = weightVectorsRealizingGB(sR.(gens(I)), sR)

  if !isempty(w)
    ow = weight_ordering(w[1], default_ordering(R))
    return groebner_walk(I, target, ow; perturbation_degree=perturbation_degree, algorithm=algorithm)
  else
    return groebner_walk(I, target; perturbation_degree=perturbation_degree, algorithm=algorithm)
  end
end

end
