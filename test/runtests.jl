using Oscar, GroebnerWalk
const groebner_walk = GroebnerWalk.groebner_walk
using Test
using Documenter

@testset verbose=true "All tests" begin
  @testset "Compilation" begin
    R,(x,y) = polynomial_ring(QQ, [:x,:y])
    I = ideal([
      x^3*y - 2x^2*y^2 + x,
      3x^4 - y
    ])

    Gs = groebner_walk(I, lex(R)) |> gens |> Oscar.IdealGens
    @test is_groebner_basis(Gs; ordering=lex(R))

    Gg = groebner_walk(I, lex(R); algorithm=:generic) |> gens |> Oscar.IdealGens
    @test is_groebner_basis(Gg; ordering=lex(R))
  end

  doctestsetup = quote
    using Oscar
    using GroebnerWalk

    const groebner_walk = GroebnerWalk.groebner_walk
  end
  DocMeta.setdocmeta!(GroebnerWalk, :DocTestSetup, doctestsetup; recursive=true)
  doctest(GroebnerWalk; manual = false)
  set_verbosity_level(:groebner_walk, 0)

  include("standard-walk.jl")
  include("generic-walk.jl")
end

nothing
