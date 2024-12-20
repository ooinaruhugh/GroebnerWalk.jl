using Oscar
#using GroebnerWalk
#using BenchmarkTools

function kill_task(task)
  try
    Base.throwto(task, InterruptException())
  catch
  end
end

# Wrapper function to include timeout
function benchmark_with_timeout(f, timeout)
    Cis_done = Channel(1)
    Cresult = Channel(1)

    timer_task = @async begin
      sleep(timeout)
      put!(Cis_done, :no)
      put!(Cresult, timeout)
    end

    benchmark_task = @async begin
      t = @elapsed f()
      put!(Cresult, t)
      put!(Cis_done, :yes)

      kill_task(timer_task)
    end

    result = fetch(Cresult)
    is_done = fetch(Cis_done)
    close(Cis_done)
    close(Cresult)

    if is_done == :no
      kill_task(benchmark_task)
    end

    return result
end

include("cyclic.jl")
include("agk.jl")
include("tran3.3.jl")

const MAX_TIME = 3
const N_SAMPLES = 3
const N_EVALS = 3
#function benchmark(
#  io,
#  name::String,
#  I::Ideal,
#  target::MonomialOrdering,
#  start::MonomialOrdering
#)
#  print(io, gethostname(), ",")
#  print("Benchmarking $(name)...")
#  print(io, name, ","); flush(io)
#  t = @belapsed groebner_walk($I, $target, $start; algorithm=:standard) seconds=MAX_TIME samples=N_SAMPLES evals=N_EVALS
#  print(io, t, ","); flush(io)
#  t = @belapsed groebner_walk($I, $target, $start; algorithm=:generic) seconds=MAX_TIME samples=N_SAMPLES evals=N_EVALS
#  #print(io, t, ","); flush(io)
#  #t = @belapsed groebner_walk($I, $target, $start; algorithm=:perturbed) seconds=20000 samples=10
#  print(io, t, ","); flush(io)
#  t = @belapsed begin 
#    J = ideal(gens($I))
#    groebner_basis(J; ordering=$target) 
#  end seconds=MAX_TIME samples=N_SAMPLES evals=N_EVALS
#  println(io, t); flush(io)
#
#  println("\t\t\t[done]")
#end

function benchmark(
  io,
  name::String,
  I::Ideal,
  target::MonomialOrdering,
  start::MonomialOrdering
)
  print("Benchmarking $(name)...")

  print(io, gethostname(), ",")
  print(io, name, ","); flush(io)

  t = benchmark_with_timeout(() -> groebner_walk(I, target, start; algorithm = :standard), MAX_TIME)
  print(io, t, ","); flush(io)
  
  t = benchmark_with_timeout(() -> groebner_walk(I, target, start; algorithm = :generic), MAX_TIME)
  print(io, t, ","); flush(io)

  t = benchmark_with_timeout(begin 
    J = ideal(gens(I))
    groebner_basis(J; ordering=target) 
  end, MAX_TIME)

  println(io, t); flush(io)
end

function print_header(io)
  print(io, "name,standard_walk,generic_walk,perturbed_walk,buchberger\n")
end

p = 11863279
Fp = GF(p)
open("results.test.csv", "a") do io
  print_header(io)
  R, (x, y) = QQ[:x, :y]
  I = ideal([y^4 + x^3 - x^2 + x, x^4])
  benchmark(io, "simple", I, lex(R), default_ordering(R))
  
  benchmark(io, "cyclic5-QQ", cyclic5(QQ)...)
  benchmark(io, "cyclic5-Fp", cyclic5(Fp)...)

  benchmark(io, "cyclic6-QQ", cyclic6(QQ)...)
  benchmark(io, "cyclic6-Fp", cyclic6(Fp)...)
  
  I = katsura(6)
  R = base_ring(I)
  benchmark(io, "katsura6-QQ", I, lex(R), default_ordering(R))

  Ip = map(gens(I)) do f
    change_coefficient_ring(Fp, f)
  end |> ideal
  Rp = base_ring(Ip)
  benchmark(io, "katsura6-Fp", Ip, lex(Rp), default_ordering(Rp))

  benchmark(io, "cyclic7-QQ", cyclic7(QQ)...)
  benchmark(io, "cyclic7-Fp", cyclic7(Fp)...)

  benchmark(io, "agk4-QQ", agk4(QQ)...)
  benchmark(io, "agk4-Fp", agk4(Fp)...)

  benchmark(io, "tran3.3-QQ", tran33(QQ)...)
  benchmark(io, "tran3.3-Fp", tran33(Fp)...)

  benchmark(io, "newellp1-QQ", newell_patch_with_orderings(QQ)...)
  benchmark(io, "newellp1-Fp", newell_patch_with_orderings(Fp)...)
end

