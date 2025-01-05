using Oscar
using GroebnerWalk
const groebner_walk = Oscar.groebner_walk
using BenchmarkTools

function print_header(io)
  #print(io, "hostname,name,standard_walk,generic_walk,perturbed_walk,buchberger\n")
  println(io, "hostname,instance,algorithm,time")
end

const example, algorithm, field, _ = ARGS

const MAX_TIME = parse(Int64, ARGS[end])
const N_SAMPLES = 3
const N_EVALS = 1

kk = QQ
if field == "Fp"
  p = 11863279
  kk = GF(p)
end

Ro, (x,y) = kk[:x, :y]
Io = ideal([y^4 + x^3 - x^2 + x, x^4])
println("Trigger compilation...")
if algorithm == "standard"
  groebner_walk(Io, lex(Ro), default_ordering(Ro); algorithm=:standard)
elseif algorithm == "generic"
  groebner_walk(Io, lex(Ro), default_ordering(Ro); algorithm=:generic)
elseif algorithm == "oscar"
  groebner_basis(Io; ordering=lex(Ro))
end

if example == "simple"
  R = Ro
  I = Io
  target = lex(R)
  start = default_ordering(R)
else
  include(example * ".jl")
end

t = NaN

is_fresh_file = !isfile("results.csv")
open("results.csv", "a") do io
  is_fresh_file && print_header(io)

  print(io, gethostname(), ",")

  print(io, example * "-" * field, ",", algorithm, ","); flush(io)

  println("Benchmarking $(algorithm) for $(example)-$(field)...")
  if algorithm == "standard"
    global t = @belapsed groebner_walk(I, target, start; algorithm=:standard) samples=N_SAMPLES evals=N_EVALS
  elseif algorithm == "generic"
    global t = @belapsed groebner_walk(I, target, start; algorithm=:generic) samples=N_SAMPLES evals=N_EVALS
  elseif algorithm == "oscar"
    global t = @belapsed begin
      Io = ideal(gens(I))
      groebner_basis(Io; ordering=target) 
    end samples=N_SAMPLES evals=N_EVALS
  end

  print(io, t)
end
