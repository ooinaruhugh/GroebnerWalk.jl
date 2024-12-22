using Oscar 

global kk
R, (x,y,z) = kk[:x,:y,:z]

F = [16 + 3*x^3+16*x^2*z+14*x^2*y^3, 6+y^3*z+17*x^2*z^2+7*x*y^2*z^2+13*x^3*z^2]

I = ideal(F)
target = lex(R)
start = default_ordering(R)

