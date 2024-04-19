using Oscar
using GroebnerWalk
using BenchmarkTools

R, (x,y,z,u,v) = polynomial_ring(QQ, ["x","y","z","u","v"])

o1 = weight_ordering([1,1,1,0,0], degrevlex(R))
o2 = weight_ordering([0,0,0,1,1], degrevlex(R))

I1 = ideal([
    u + u^2 - 2*v - 2*u^2*v + 2*u*v^2 - x,
    -6*u + 2*v + v^2 - 5*v^3 + 2*u*v^2 - 4*u^2*v^2 - y,
    -2 + 2*u^2 + 6*v - 3*u^2*v^2 - z
])

t_standard = @elapsed G = groebner_walk(I1, o2, o1; algorithm=:standard)
# t_generic = @elapsed G = groebner_walk(I1, o2, o1; algorithm=:generic)
# t_perturbed = @elapsed G = groebner_walk(I1, o2, o1; algorithm=:perturbed)