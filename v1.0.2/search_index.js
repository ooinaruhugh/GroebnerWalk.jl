var documenterSearchIndex = {"docs":
[{"location":"references/#References","page":"References","title":"References","text":"","category":"section"},{"location":"references/","page":"References","title":"References","text":"B. Amrhein, O. Gloor and W. Küchlin. Walking faster. In: Design and Implementation of Symbolic Computation Systems, Vol. 1128 of Lecture Notes in Computer Science (Springer Berlin Heidelberg, 1996); pp. 150–161.\n\n\n\nB. Amrhein, O. Gloor and W. Küchlin. On the walk. Theoretical Computer Science 187, 179–202 (1997).\n\n\n\nD. A. Cox, J. Little and D. O'Shea. Using Algebraic Geometry. Vol. 185 of Graduate Texts in Mathematics (Springer-Verlag, 2005).\n\n\n\nK. Fukuda, A. N. Jensen, N. Lauritzen and R. Thomas. The generic Gröbner walk. Journal of Symbolic Computation 42, 298–312 (2007).\n\n\n\nQ.-N. Tran. Efficient Groebner walk conversion for implicitization of geometric objects. Computer Aided Geometric Design 21, 837–857 (2004).\n\n\n\n","category":"page"},{"location":"special-ideals/#Special-ideals-used-for-benchmarking","page":"Special ideals used for benchmarking","title":"Special ideals used for benchmarking","text":"","category":"section"},{"location":"special-ideals/","page":"Special ideals used for benchmarking","title":"Special ideals used for benchmarking","text":"We bundle a couple of special ideals useful for benchmarking of the Gröbner walk.","category":"page"},{"location":"special-ideals/","page":"Special ideals used for benchmarking","title":"Special ideals used for benchmarking","text":"    newell_patch(k::Union{QQField, QQBarFieldElem}, n::Int=1)\n    newell_patch(k::Field, n::Int=1)","category":"page"},{"location":"special-ideals/#newell_patch","page":"Special ideals used for benchmarking","title":"newell_patch","text":"newell_patch(k::Union{QQField, QQBarFieldElem}, n::Int=1)\n\nLet n be an integer between 1 and 32. Returns the ideal corresponding to  the implicitization of the n-th bi-cubic patch describing the Newell's teapot as a parametric surface.\n\nThe specific generators for each patch have been taken from [Tra04].\n\n\n\n\n\n","category":"function"},{"location":"special-ideals/#newell_patch-2","page":"Special ideals used for benchmarking","title":"newell_patch","text":"newell_patch(k::Field, n::Int=1)\n\nLet n be an integer between 1 and 32. Returns the ideal corresponding to  the implicitization of the n-th bi-cubic patch describing the Newell's teapot as a parametric surface.\n\nThe specific generators for each patch have been taken from [Tra04].\n\nFor fields kneqmathbbQbarmathbbQ, this gives a variant of the ideal with  integer coefficients.\n\n\n\n\n\n","category":"function"},{"location":"special-ideals/","page":"Special ideals used for benchmarking","title":"Special ideals used for benchmarking","text":"    newell_patch_with_orderings(k::Field, n::Int=1)","category":"page"},{"location":"special-ideals/#newell_patch_with_orderings","page":"Special ideals used for benchmarking","title":"newell_patch_with_orderings","text":"newell_patch_with_orderings(k::Field, n::Int=1)\n\nLet n be an integer between 1 and 32. Returns the ideal corresponding to  the implicitization of the n-th bi-cubic patch describing the Newell's teapot as a parametric surface. Additionally returns suitable start and target orderings, e.g. for use with the Gröbner walk.\n\nThe specific generators for each patch have been taken from [Tra04].\n\nFor fields kneqmathbbQbarmathbbQ, this gives a variant of the ideal with  integer coefficients.\n\n\n\n\n\n","category":"function"},{"location":"introduction/#Usage","page":"Usage","title":"Usage","text":"","category":"section"},{"location":"introduction/","page":"Usage","title":"Usage","text":"The Gröbner walk is an approach to reduce the computational complexity of Gröbner basis computations  that was originally proposed in [AGK97].","category":"page"},{"location":"introduction/","page":"Usage","title":"Usage","text":"This is done by performing a reverse local search on the cones of the Gröbner fan. Then, a Gröbner basis is calculated for each encountered cone while reusing the generators obtained  from the previous cone.","category":"page"},{"location":"introduction/","page":"Usage","title":"Usage","text":"The implemented algorithms may be accessed using the following function.","category":"page"},{"location":"introduction/","page":"Usage","title":"Usage","text":"    groebner_walk(\n      I::MPolyIdeal, \n      target::MonomialOrdering = lex(base_ring(I)),\n      start::MonomialOrdering = default_ordering(base_ring(I));\n      perturbation_degree = ngens(base_ring(I)),\n      algorithm::Symbol = :standard\n    )","category":"page"},{"location":"introduction/#groebner_walk","page":"Usage","title":"groebner_walk","text":"groebner_walk(\n  I::MPolyIdeal, \n  target::MonomialOrdering = lex(base_ring(I)),\n  start::MonomialOrdering = default_ordering(base_ring(I));\n  perturbation_degree = ngens(base_ring(I)),\n  algorithm::Symbol = :standard\n)\n\nCompute a reduced Groebner basis w.r.t. to a monomial ordering by converting it using the Groebner Walk.\n\nArguments\n\nI::MPolyIdeal: ideal one wants to compute a Groebner basis for.\ntarget::MonomialOrdering=:lex: monomial ordering one wants to compute a Groebner basis for.\nstart::MonomialOrdering=:degrevlex: monomial ordering to begin the conversion.\nperturbationDegree::Int=2: the perturbation degree for the perturbed Walk.\nalgorithm::Symbol=:standard: strategy of the Groebner Walk. One can choose between:\nstandard: Standard Walk [CLO05],\ngeneric: Generic Walk [FJLT07],\nperturbed: Perturbed Walk [AGK96].\n\nExamples\n\njulia> R,(x,y) = polynomial_ring(QQ, [\"x\",\"y\"]);\n\njulia> I = ideal([y^4+ x^3-x^2+x,x^4]);\n\njulia> groebner_walk(I, lex(R))\nGröbner basis with elements\n1 -> x + y^12 - y^8 + y^4 r\n2 -> y^16\nwith respect to the ordering\nlex([x, y])\n\njulia> groebner_walk(I, lex(R); algorithm=:perturbed)\nGröbner basis with elements\n1 -> x + y^12 - y^8 + y^4\n2 -> y^16\nwith respect to the ordering\nlex([x, y])\n\njulia> set_verbosity_level(:groebner_walk, 1);\njulia> groebner_walk(I, lex(R))\nResults for standard_walk\nCrossed Cones in: \nZZRingElem[1, 1]\nZZRingElem[4, 3]\nZZRingElem[4, 1]\nZZRingElem[12, 1]\nCones crossed: 4\nGröbner basis with elements\n1 -> x + y^12 - y^8 + y^4\n2 -> y^16\nwith respect to the ordering\nlex([x, y])\n\njulia> groebner_walk(I, lex(R); algorithm=:perturbed)\nperturbed_walk results\nCrossed Cones in: \n[4, 3]\n[4, 1]\n[5, 1]\n[12, 1]\n[1, 0]\nCones crossed: 5\nGröbner basis with elements\n1 -> y^16\n2 -> x + y^12 - y^8 + y^4\nwith respect to the ordering\nmatrix_ordering([x, y], [1 0; 0 1])\n\n\n\n\n\n","category":"function"},{"location":"#GroebnerWalk.jl","page":"Home","title":"GroebnerWalk.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"GroebnerWalk.jl provides several variants of Gröbner walk algorithms for  converting Gröbner bases. For this, we make use of the computer algebra system OSCAR.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"For this package we require Julia version 1.10 or higher.","category":"page"},{"location":"","page":"Home","title":"Home","text":"To use GroebnerWalk.jl, we require Oscar.jl. Both packages can be installed using the Julia package manager.  Open the Julia prompt and type ] and enter the following command","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add Oscar, GroebnerWalk","category":"page"},{"location":"","page":"Home","title":"Home","text":"Equivalently, you can enter","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using Pkg; Pkg.add([\"Oscar\", \"GroebnerWalk\"])","category":"page"},{"location":"#Quick-start","page":"Home","title":"Quick start","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Once you have installed the package, you can start using it in your Julia code. Here's a simple example:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Oscar, GroebnerWalk\n\nR, (x,y) = QQ[:x, :y]            # define ring ...\nI = ideal([y^4+ x^3-x^2+x,x^4])  # ... and ideal\n\ngroebner_walk(I)                 # compute the Groebner basis","category":"page"}]
}