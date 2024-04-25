using Oscar
using GroebnerWalk
using BenchmarkTools

include("cyclic.jl")
include("katsura.jl")
include("agk.jl")
include("tran3.3.jl")
include("newellp1.jl")

function benchmark(
  io,
  name::String,
  I::Ideal,
  target::MonomialOrdering,
  start::MonomialOrdering
)
  print(io, name, ","); flush(io)
  t = @belapsed groebner_walk($I, $target, $start; algorithm=:standard) seconds=20000 samples=10
  print(io, t, ","); flush(io)
  t = @belapsed groebner_walk($I, $target, $start; algorithm=:generic) seconds=20000 samples=10
  print(io, t, ","); flush(io)
  t = @belapsed groebner_basis($I; ordering=$target) seconds=20000 samples=10
  println(io, t); flush(io)
end

p = 11863279
Fp = GF(p)
open("results.csv", "a") do io
  R, (x, y) = QQ[:x, :y]
  I = ideal([y^4 + x^3 - x^2 + x, x^4])
  benchmark(io, "simple", I, lex(R), default_ordering(R))
  
  benchmark(io, "cyclic5-QQ", cyclic5(QQ)...)
  benchmark(io, "cyclic5-Fp", cyclic5(Fp)...)

  benchmark(io, "cyclic6-QQ", cyclic6(QQ)...)
  benchmark(io, "cyclic6-Fp", cyclic6(Fp)...)
  
  benchmark(io, "katsura6-QQ", katsura6(QQ)...)
  benchmark(io, "katsura6-Fp", katsura6(Fp)...)

  benchmark(io, "cyclic7-QQ", cyclic7(QQ)...)
  benchmark(io, "cyclic7-Fp", cyclic7(Fp)...)

  benchmark(io, "agk4-QQ", agk4(QQ)...)
  benchmark(io, "agk4-Fp", agk4(Fp)...)

  benchmark(io, "tran3.3-QQ", tran33(QQ)...)
  benchmark(io, "tran3.3-Fp", tran33(Fp)...)

  benchmark(io, "newellp1-QQ", newellp1(QQ)...)
  benchmark(io, "newellp1-Fp", newellp1(Fp)...)
end