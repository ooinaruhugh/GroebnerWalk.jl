@testset "Standard walk" begin
    R1, (x,y,z) = polynomial_ring(QQ, [:x,:y,:z])
            
    I1 = ideal([x^2 + y*z, x*y + z^2]) 
    # The Oscar.IdealGens type stores whether the generators form a GB.
    # To test whether the generators really form a GB, we recreate the object.
    G1 = groebner_walk(I1) |> gens |> Oscar.IdealGens
    @test is_groebner_basis(G1; ordering=lex(R1))
    
    I2 = ideal([x^2 - y, x*z - y^2 + y*z])
    os = weight_ordering([5,4,1], degrevlex(R1))
    ot = weight_ordering([6,1,3], lex(R1))
    G2 = groebner_walk(I2, ot, os)

    F2 = [x*z + y*z - y^2,x^2 - y,x*y^2 - y^3 + y^2*z - y*z,y^2*z^2 - 2y^3*z + y^4 - y*z^2]

    isGB = all(F2) do f
      f in G2
    end
    @test isGB==true

#    I2 = ideal([z^3 - z^2 - 4])
#    G2 = groebner_basis(I2)
#
#    I3 = ideal([x^6 - 1])
#    G3 = groebner_basis(I3)
#
#    #@test bounding_vectors(G1) == Vector{ZZRingElem}.([[1,1,-2],[2,-1,-1], [-1,2,-1]])
#    #@test next_weight(G1, ZZ.([1,1,1]), ZZ.([1,0,0])) == ZZ.([1,1,1])
#
#    @test is_groebner_basis(groebner_walk(I2); ordering=lex(R1))
#    #@test bounding_vectors(G2) == ZZ.([[0,0,1],[0,0,3]])
#
#    @test is_groebner_basis(groebner_walk(I3); ordering=lex(R1))
#    #@test bounding_vectors(G3) == ZZ.([[6,0,0]])
#    #@test next_weight(G3, ZZ.([1,1,1]), ZZ.([1,0,0])) == ZZ.([1,0,0])
end 

