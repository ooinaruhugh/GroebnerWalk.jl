using Oscar
#using GroebnerWalk
global kk

I = katsura(6)
R = base_ring(I)

I = map(gens(I)) do f
      change_coefficient_ring(kk, f)
    end |> ideal
R = base_ring(I)

target = lex(R)
start = default_ordering(R)
