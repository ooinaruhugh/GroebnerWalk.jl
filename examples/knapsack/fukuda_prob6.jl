using Oscar 
using GroebnerWalk
R, (t, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) = polynomial_ring(QQ, ["t","x1","x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10" ])

f = 12223*x1 + 12224*x2 +36674*x3+61119*x4+85569*x5 -89643481

f1 = x1 - t^20601
f2 = x2 - t^40429
f3 = x3 - t^42207
f4 = x4 - t^45415
f5 = x5 - t^53725
f6 = x6 - t^61919
f7 = x7 - t^64670
f8 = x8 - t^69340
f9 = x9 - t^78539
f10 = x10 - t^95043 
I = ideal([f1, f2, f3, f4, f5, f6, f7, f8, f9, f10])

set_verbosity_level(:groebner_walk, 1)
o_t = matrix_ordering(R, [
1 0 0 0 0 0 0 0 0 0 0;
0 1 1 1 1 1 1 1 1 1 1;
0 1 1 1 1 1 1 1 1 1 0;
0 1 1 1 1 1 1 1 1 0 0;
0 1 1 1 1 1 1 1 0 0 0;
0 1 1 1 1 1 1 0 0 0 0; 
0 1 1 1 1 1 0 0 0 0 0;
0 1 1 1 1 0 0 0 0 0 0;
0 1 1 1 0 0 0 0 0 0 0;
0 1 1 0 0 0 0 0 0 0 0;
0 1 0 0 0 0 0 0 0 0 0])
o_s = matrix_ordering(R, [
0 1 1 1 1 1 1 1 1 1 1;
1 0 0 0 0 0 0 0 0 0 0;
1 1 0 0 0 0 0 0 0 0 0;
1 1 1 0 0 0 0 0 0 0 0;
1 1 1 1 0 0 0 0 0 0 0;
1 1 1 1 1 0 0 0 0 0 0;
1 1 1 1 1 1 0 0 0 0 0; 
1 1 1 1 1 1 1 0 0 0 0;
1 1 1 1 1 1 1 1 0 0 0;
1 1 1 1 1 1 1 1 1 0 0;
1 1 1 1 1 1 1 1 1 1 0])

Ginit = groebner_basis(I, ordering = o_s)

tg = @elapsed Gg = groebner_walk(I, o_t, o_s, algorithm =:generic) #>1hr
ts = @elapsed Gs = groebner_walk(I, o_t, o_s, algorithm =:standard)
tb = @elapsed Gb = groebner_basis(I, ordering = o_t, complete_reduction = true) #139s