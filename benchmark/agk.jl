using Oscar

global kk
R, (x,y,z,u,v) = polynomial_ring(kk, ["x","y","z","u","v"])

start = weight_ordering([1,1,1,0,0], degrevlex(R))
target = weight_ordering([0,0,0,1,1], degrevlex(R))

F = [
    u + u^2 - 2*v - 2*u^2*v + 2*u*v^2 - x,
    -6*u + 2*v + v^2 - 5*v^3 + 2*u*v^2 - 4*u^2*v^2 - y,
    -2 + 2*u^2 + 6*v - 3*u^2*v^2 - z
]

I = ideal(F)
