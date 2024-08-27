using Oscar, GroebnerWalk
using Test

@testset verbose=true "All tests" begin
  include("standard-walk.jl")
  include("generic-walk.jl")
end

nothing
