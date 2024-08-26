
@doc raw"""
    newell_patch(k::Union{QQField, QQBarFieldElem}, n::Int=1)

Let $n$ be an integer between 1 and 32. Returns the ideal corresponding to 
the implicitization of the $n$-th bi-cubic patch describing
the Newell's teapot as a parametric surface.

The specific generators for each patch have been taken from [Tra04](@cite).
"""
function newell_patch(k::Union{QQField, QQBarFieldElem}, n::Int=1)
  return get_newell_patch_generators(n) |> ideal
end

@doc raw"""
    newell_patch(k::Field, n::Int=1)

Let $n$ be an integer between 1 and 32. Returns the ideal corresponding to 
the implicitization of the $n$-th bi-cubic patch describing
the Newell's teapot as a parametric surface.

The specific generators for each patch have been taken from [Tra04](@cite).

For fields $k\neq\mathbb{Q},\bar{\mathbb{Q}}$, this gives a variant of the ideal with 
integer coefficients.
"""
function newell_patch(k::Field, n::Int=1)
  F = get_newell_patch_generators(n)

  lcm_denom = [
      lcm(numerator.(coefficients(f))) for f in F
  ]
  integral_F = [
      change_coefficient_ring(
          k, l*f
      ) for (l, f) in zip(lcm_denom, F)
  ]

  return ideal(integral_F)
end

@doc raw"""
    newell_patch_with_orderings(k::Field, n::Int=1)

Let $n$ be an integer between 1 and 32. Returns the ideal corresponding to 
the implicitization of the $n$-th bi-cubic patch describing
the Newell's teapot as a parametric surface.
Additionally returns suitable start and target orderings, e.g. for use with the Gröbner walk.

The specific generators for each patch have been taken from [Tra04](@cite).

For fields $k\neq\mathbb{Q},\bar{\mathbb{Q}}$, this gives a variant of the ideal with 
integer coefficients.
"""
function newell_patch_with_orderings(k::Field, n::Int=1)
  I = newell_patch(k, n)
  R = base_ring(I)
  o1 = matrix_ordering(R, [1 1 1 0 0; 0 0 0 1 1; 0 0 0 1 0; 1 1 0 0 0; 1 0 0 0 0])
  o2 = matrix_ordering(R, [0 0 0 1 1; 1 1 1 0 0; 1 1 0 0 0; 1 0 0 0 0; 0 0 0 1 0])
  return I, o2, o1
end

function get_newell_patch_generators(n::Int)
  _, (x,y,z,u,v) = polynomial_ring(QQ, ["x","y","z","u","v"])

  if n == 1
    return [
        -x + 7//5 - 231//125 * v^2 + 39//80 * u^2 - 1//5 * u^3 + 99//400 * u * v^2 - 1287//2000 * u^2 * v^2 + 33//125 * u^3 * v^2 - 3//16 * u + 56//125 * v^3 - 3//50 * u * v^3 + 39//250 * u^2 * v^3 - 8//125 * u^3 * v^3,
        -y + 63//125 * v^2 - 294//125 * v + 56//125 * v^3 - 819//1000 * u^2 * v + 42//125 * u^3 * v - 3//50 * u * v^3 + 351//2000 * u^2 * v^2 + 39//250 * u^2 * v^3 - 9//125 * u^3 * v^2 - 8//125 * u^3 * v^3,
        -z + 12//5 - 63//160 * u^2 + 63//160 * u
    ]
  elseif n == 2
    return [
      −x + 63//125 * v^2 − 294//125 * v + 56//125 * v^3 − 819//1000 * u^2 * v + 42//125 * u^3 * v − 3//50 * u * v^3 + 351//2000 * u^2 * v^2 + 39//250 * u^2 * v^3 − 9//125 * u^3 * v^2 − 8//125 * u^3 * v^3 + 63//200 * u * v − 27//400 * u * v^2,
      −y − 7//5 + 231//125 * v^2 − 39//80 * u^2 + 1//5 * u^3 − 99//400 * u * v^2 + 1287//2000 * u^2 * v^2 − 33//125 * u^3 * v^2 + 3//16 * u − 56//125 * v^3 + 3//50 * u * v^3 − 39//250 * u^2 * v^3 + 8//125 * u^3 * v^3,
      −z + 12//5 − 63//160 * u^2 + 63//160 * u
    ]
  elseif n==3
    return [
      −x − 7//5 + 231//125 * v^2 − 39//80 * u^2 + 1//5 * u^3 − 99//400 * u * v^2 + 1287//2000 * u^2 * v^2 − 33//125 * u^3 * v^2 + 3//16 * u − 56//125 * v^3 + 3//50 * u * v^3 − 39//250 * u^2 * v^3 + 8//125 * u^3 * v^3,
      −y − 63//125 * v^2 + 294//125 * v − 56//125 * v^3 + 819//1000 * u^2 * v − 42//125 * u^3 * v + 3//50 * u * v^3 − 351//2000 * u^2 * v^2 − 39//250 * u^2 * v^3 + 9//125 * u^3 * v^2 + 8//125 * u^3 * v^3 + 63//200 * u * v − 27//400 * u * v^2,
      −z + 12//5 − 63//160 * u^2 + 63//160 * u
    ]
  elseif n==4
    return [
      −x − 63//125 * v^2 + 294//125 * v − 56//125 * v^3 + 819//1000 * u^2 * v − 42//125 * u^3 * v + 3//50 * u * v^3 − 351//2000 * u^2 * v^2 − 39//250 * u^2 * v^3 + 9//125 * u^3 * v^2 + 8//125 * u^3 * v^3 − 63//200 * u * v + 27//400 * u * v^2,
      −y + 7//5 − 231//125 * v^2 + 39//80 * u^2 − 1//5 * u^3 + 99//400 * u * v^2 − 1287//2000 * u^2 * v^2 + 33//125 * u^3 * v^2 − 3//16 * u + 56//125 * v^3 − 3//50 * u * v^3 + 39//250 * u^2 * v^3 − 8//125 * u^3 * v^3,
      −z + 12//5 − 63//160 * u^2 + 63//160 * u
    ]
  elseif n==5
    return [
      −x + 3//2 − 99//50 * v^2 − 1//4 * u^3 − 99//100 * u * v^2 + 33//100 * u^3 * v^2 + 3//4 * u + 12//25 * v^3 + 6//25 * u * v^3 − 2//25 * u^3 * v^3,
      −y + 27//50 * v^2 − 63//25 * v + 12//25 * v^3 + 21//50 * u^3 * v + 6//25 * u * v^3 − 9//100 * u^3 * v^2 − 2//25 * u^3 * v^3 − 63//50 * u * v + 27//100 * u * v^2,
      −z + 12//5 + 3//40 * u^3 − 63//40 * u
    ]
  elseif n==6
    return [
      −x + 27//50 * v^2 − 63//25 * v + 12//25 * v^3 + 21//50 * u^3 * v + 6//25 * u * v^3 − 9//100 * u^3 * v^2 − 2//25 * u^3 * v^3 − 63//50 * u * v + 27//100 * u * v^2,
      −y − 3//2 + 99//50 * v^2 + 1//4 * u^3 + 99//100 * u * v^2 − 33//100 * u^3 * v^2 − 3//4 * u − 12//25 * v^3 − 6//25 * u * v^3 + 2//25 * u^3 * v^3, 
      −z + 12//5 + 3//40 * u^3 − 63//40 * u
    ]
  elseif n==7
    return [
      −x − 3//2 + 99//50 * v^2 + 1//4 * u^3 + 99//100 * u * v^2 − 33//100 * u^3 * v^2 − 3//4 * u − 12//25 * v^3 − 6//25 * u * v^3 + 2//25 * u^3 * v^3, 
      −y − 27//50 * v^2 + 63//25 * v − 12//25 * v^3 − 21//50 * u^3 * v − 6//25 * u * v^3 + 9//100 * u^3 * v^2 + 2//25 * u^3 * v^3 + 63//50 * u * v − 27//100 * u * v^2, 
      −z + 12//5 + 3//40 * u^3 − 63//40 * u
    ]
  elseif n == 8
    return [
      −x − 27//50 * v^2 + 63//25 * v − 12//25 * v^3 − 21//50 * u^3 * v − 6//25 * u * v^3 + 9//100 * u^3 * v^2 + 2//25 * u^3 * v^3 + 63//50 * u * v − 27//100 * u * v^2, 
      −y + 3//2 − 99//50 * v^2 − 1//4 * u^3 − 99//100 * u * v^2 + 33//100 * u^3 * v^2 + 3//4 * u + 12//25 * v^3 + 6//25 * u * v^3 − 2//25 * u^3 * v^3, 
      −z + 12//5 + 3//40 * u^3 − 63//40 * u
    ]
  elseif n == 9
    return [
      −x + 2− 66//25 * v^2 − 3//2 * u^2 + u^3 + 99//50 * u^2 * v^2 − 33//25 * u^3 * v^2 + 16//25 * v^3 − 12//25 * u^2 * v^3 + 8//25 * u^3 * v^3, 
      -y - 18//25 * v^2 + 16//25 * v^3 + 63//25 * u^2 * v − 42//25 * u^3 * v − 27//50 * u^2 * v^2 − 12//25 * u^2  * v^3 +9//25 * u^3 * v^2 +8//25 * u^3 * v^3 − 84//25 * v,
      −z + 9//10 + 27//40 * u^2 − 3//40 * u^3 − 27//20 * u
    ]
  elseif n == 10
    return [
      -x - 18//25 * v^2 + 16//25 * v^3 + 63//25 * u^2 * v - 42//25 * u^3 * v - 27//50 * u^2 * v^2 - 12//25 * u^2 * v^3 + 9//25 * u^3 * v^2 + 8//25 * u^3 * v^3 - 84//25 * v,
      -y - 2 + 66//25 * v^2 + 3//2 * u^2 - u^3 - 99//50 * u^2 * v^2 + 33//25 * u^3 * v^2 - 16//25 * v^3 + 12//25 * u^2 * v^3 - 8//25 * u^3 * v^3,
      -z + 9//10 + 27//40 * u^2 - 3//40 * u^3 - 27//20 * u
    ]
  elseif n == 11
    return [
      -x - 2 + 66//25 * v^2 + 3//2 * u^2 - u^3 - 99//50 * u^2 * v^2 + 33//25 * u^3 * v^2 - 16//25 * v^3 + 12//25 * u^2 * v^3 - 8//25 * u^3 * v^3,
      -y + 18//25 * v^2 - 16//25 * v^3 - 63//25 * u^2 * v + 42//25 * u^3 * v + 27//50 * u^2 * v^2 + 12//25 * u^2 * v^3 - 9//25 * u^3 * v^2 - 8//25 * u^3 * v^3 + 84//25 * v,
      -z + 9//10 + 27//40 * u^2 - 3//40 * u^3 - 27//20 * u
    ]
  elseif n == 12
    return [
      -x + 18//25 * v^2 - 16//25 * v^3 - 63//25 * u^2 * v + 42//25 * u^3 * v + 27//50 * u^2 * v^2 + 12//25 * u^2 * v^3 - 9//25 * u^3 * v^2 - 8//25 * u^3 * v^3 + 84//25 * v,
      -y + 2 - 66//25 * v^2 - 3//2 * u^2 + u^3 + 99//50 * u^2 * v^2 - 33//25 * u^3 * v^2 + 16//25 * v^3 - 12//25 * u^2 * v^3 + 8//25 * u^3 * v^3,
      -z + 9//10 + 27//40 * u^2 - 3//40 * u^3 - 27//20 * u
    ]
  elseif n == 13
    return [
      −x + 3//10 *  v^2 + 9//10 *  u^2 − 1//5 *  v^3 + 1//10 *  u^3 + 1//5 *  u^3 *  v^3 − 27//10 *  u *  v^2 + 9//5 *  u *  v^3 + 9//5 *  u^2 *  v^2 − 6//5 *  u^2 *  v^3 − 3//10 *  u^3 *  v^2 − 21//10 *  u − 8//5, 
      −y − 9//10 *  v + 9//10 *  v^2, 
      −z + 81//40 + 27//40 *  v^2 − 9//20 *  v^3 − 9//40 *  u^3 + 9//20 *  u^3 *  v^3 − 27//40 *  u^3 *  v^2
    ]
  elseif n == 14
    return [
      −x − 3//2 − 3//10 *  v^2 + 3//2 *  u^2 + 1//5 *  v^3 − 1//5 *  u^3 *  v^3 + 27//10 *  u *  v^2 − 9//5 *  u *  v^3 − 9//5 *  u^2 *  v^2 + 6//5 *  u^2 *  v^3 + 3//10 *  u^3 *  v^2 − 3 *  u, 
      −y + 9//10 *  v − 9//10 *  v^2, 
      −z + 9//4 − 27//40 *  v^2 + 9//20 *  v^3 − 9//20 *  u^3 − 9//20 *  u^3 *  v^3 + 27//40 *  u^3 *  v^2
    ]
  elseif n == 15
    return [
      −x − 27//10 − 9//10 *  v^2 + 3//5 *  u^2 + 3//5 *  v^3 + 1//10 *  u^3 + 1//10 *  u^3 *  v^3 + 27//20 *  u^2 *  v^2 − 9//10 *  u^2 *  v^3 − 3//20 *  u^3 *  v^2, 
      −y − 9//10 *  v + 9//10 *  v^2, 
      −z − 27//40 *  u^2 + 9//20 *  u^3 + 33//40 *  u^3 *  v^3 − 81//40 *  u *  v^2 + 27//20 *  u *  v^3 + 189//80 *  u^2 *  v^2 − 63//40 *  u^2 *  v^3 − 99//80 *  u^3 *  v^2 − 27//40 *  u + 9//5
    ]
  elseif n == 16
    return [
      −x − 3 + 9//10 *  v^2 + 21//20 *  u^2 − 3//5 *  v^3 + 1//20 *  u^3 − 1//10 *  u^3 *  v^3 − 27//20 *  u^2 *  v^2 + 9//10 *  u^2 *  v^3 + 3//20 *  u^3 *  v^2, 
      −y + 9//10 *  v − 9//10 *  v^2, 
      −z + 9//80 *  u^2 + 3//80 *  u^3 − 33//40 *  u^3 *  v^3 + 81//40 *  u *  v^2 − 27//20 *  u *  v^3 − 189//80 *  u^2 *  v^2 + 63//40 *  u^2 *  v^3 + 99//80 *  u^3 *  v^2 − 27//20 *  u + 9//5
    ]
  elseif n == 17
    return [
      −x + 17//10 − 18//5 *  u^2 + 19//10 *  u^3 − 18//5 *  u^3 *  v^3 + 9//2 *  u *  v^2 − 3 *  u *  v^3 − 81//10 *  u^2 *  v^2 + 27//5 *  u^2 *  v^3 + 27//5 *  u^3 *  v^2 + 27//10 *  u, 
      −y + 369//100 *  u^2 *  v − 123//50 *  u^3 *  v − 99//50 *  v − 369//100 *  u^2 *  v^2 + 123//50 *  u^3 *  v^2 + 99//50 *  v^2, 
      −z + 57//40 − 99//40 *  v^2 + 81//40 *  u^2 + 33//20 *  v^3 − 21//20 *  u^3 + 3//2 *  u^3 *  v^3 + 81//40 *  u *  v^2 − 27//20 *  u *  v^3 + 27//10 *  u^2 *  v^2 − 9//5 *  u^2 *  v^3 − 9//4 *  u^3 *  v^2
    ]
  elseif n == 18
    return [
      −x + 17//10 − 63//10 *  u^2 + 37//10 *  u^3 + 18//5 *  u^3 *  v^3 − 9//2 *  u *  v^2 + 3 *  u *  v^3 + 81//10 *  u^2 *  v^2 − 27//5 *  u^2 *  v^3 − 27//5 *  u^3 *  v^2 + 21//5 *  u, 
      −y − 369//100 *  u^2 *  v + 123//50 *  u^3 *  v + 99//50 *  v + 369//100* u^2 * v^2 − 123//50* u^3 * v^2 − 99//50* v^2, 
      −z + 3//5+ 99//40* v^2 + 117//40* u^2 − 33//20* v^3 − 9//5*  u^3 − 3//2*  u^3 *  v^3 − 81//40*  u *  v^2 + 27//20*  u *  v^3 − 27//10*  u^2 *  v^2 + 9//5*  u^2 *  v^3 + 9//4*  u^3 *  v^2 + 27//40*  u
    ]
  elseif n == 19
    return [
      −x + 27//10 + 9//5 *  v^2 − 6//5 *  v^3 − 1//5 *  u^3 − 13//20 *  u^3 *  v^3 + 9//8 *  u *  v^2 − 3//4 *  u *  v^3 − 27//10 *  u^2 *  v^2 + 9//5 *  u^2 *  v^3 + 39//40 *  u^3 *  v^2 + 3//10 *  u, 
      −y − 3//4 *  v + 9//10 *  u^2 *  v − 3//5 *  u^3 *  v + 3//4 *  v^2 − 9//10 *  u^2 *  v^2 + 3//5 *  u^3 *  v^2, 
      −z + 12//5 − 9//40 *  u^2 + 9//80 *  u^3 *  v^3 + 27//160 *  u *  v^2 − 9//80 *  u *  v^3 − 27//160 *  u^3 *  v^2 + 9//40 *  u
    ]
  elseif n == 20
    return [
      −x + 33//10 − 9//5 *  v^2 − 9//10 *  u^2 + 6//5 *  v^3 + 1//8 *  u^3 + 13//20 *  u^3 *  v^3 − 9//8 *  u *  v^2 + 3//4 *  u *  v^3 + 27//10 *  u^2 *  v^2 − 9//5 *  u^2 *  v^3 − 39//40 *  u^3 *  v^2 + 27//40 *  u, 
      −y + 3//4 *  v − 9//10 *  u^2 *  v + 3//5 *  u^3 *  v − 3//4 *  v^2 + 9//10 *  u^2 *  v^2 − 3//5 *  u^3 *  v^2,
      −z + 12//5 − 9//40 *  u^2 − 9//160 *  u^3 − 9//80 *  u^3 *  v^3 − 27//160 *  u *  v^2 + 9//80 *  u *  v^3 + 27//160 *  u^3 *  v^2 + 9//32 *  u
    ]
  elseif n == 21
    return [
      −x + 12//5 * u − 63//20 * u * v^2 − 24//5 * u^2 + 63//10 * u^2 * v^2 + 13//5 * u^3 − 1707//500 * u^3 * v^2 + 3//4 * u * v^3 − 3//2 * u^2 * v^3 + 407//500 * u^3 * v^3, 
      −y − 81//20 * u * v + 9//10 * u * v^2 + 3//4 * u * v^3 + 81//10 * u^2 * v − 9//5 * u^2 * v^2 − 3//2 * u^2 * v^3 − 2193//500 * u^3 * v + 243//250 * u^3 * v^2 + 407//500 * u^3 * v^3,
      −z + 63//20 − 9//10 * u^2 + 9//20 * u^3
    ]
  elseif n == 22
    return [
      −x − 81//20 * u * v + 9//10 * u * v^2 + 3//4 * u * v^3 + 81//10 * u^2 * v − 9//5 * u^2 * v^2 − 3//2 * u^2 * v^3 − 2193//500 * u^3 * v + 243//250 * u^3 * v^2 + 407//500 * u^3 * v^3, 
      −y − 12//5 * u + 63//20 * u * v^2 + 24//5 * u^2 − 63//10 * u^2 * v^2 − 13//5 * u^3 + 1707//500 * u^3 * v^2 − 3//4 * u * v^3 + 3//2 * u^2 * v^3 − 407//500 * u^3 * v^3, 
      −z + 63//20 − 9//10 * u^2 + 9//20 * u^3
    ]
  elseif n == 23
    return [
      −x − 12//5 * u + 63//20 * u * v^2 + 24//5 * u^2 − 63//10 * u^2 * v^2 − 13//5 * u^3 + 1707//500 * u^3 * v^2 − 3//4 * u * v^3 + 3//2 * u^2 * v^3 − 407//500 * u^3 * v^3, 
      −y + 81//20 * u * v − 9//10 * u * v^2 − 3//4 * u * v^3 − 81//10 * u^2 * v + 9//5 * u^2 * v^2 + 3//2 * u^2 * v^3 + 2193//500 * u^3 * v − 243//250 * u^3 * v^2 − 407//500 * u^3 * v^3, 
      −z + 63//20 − 9//10 * u^2 + 9//20 * u^3
    ]
  elseif n == 24
    return [
      −x + 81//20 * u * v − 9//10 * u * v^2 − 3//4 * u * v^3 − 81//10 * u^2 * v + 9//5 * u^2 * v^2 + 3//2 * u^2 * v^3 + 2193//500 * u^3 * v − 243//250 * u^3 * v^2 − 407//500 * u^3 * v^3, 
      −y + 12//5 * u − 63//20 * u * v^2 − 24//5 * u^2 + 63//10 * u^2 * v^2 + 13//5 * u^3 − 1707//500 * u^3 * v^2 + 3//4 * u * v^3 − 3//2 * u^2 * v^3 + 407//500 * u^3 * v^3, 
      −z + 63//20 − 9//10 * u^2 + 9//20 * u^3
    ]
  elseif n == 25
    return [
      −x − 33//125 * v^2 + 21//10 * u^2 − 8//5 * u^3 − 99//125 * u * v^2 − 693//250 * u^2 * v^2 + 264//125 * u^3 * v^2 + 3//5 * u + 1//5 + 8//125 * v^3 + 24//125 * u * v^3 + 84//125 * u^2 * v^3 − 64//125 * u^3 * v^3, 
      −y + 9//125 * v^2 + 8//125 * v^3 − 441//125 * u^2 * v + 336//125 * u^3 * v + 24//125 * u * v^3 + 189//250 * u^2 * v^2 + 84//125 * u^2 * v^3 − 72//125 * u^3 * v^2 − 64//125 * u^3 * v^3 − 42//125 * v − 126//125 * u * v + 27//125 * u * v^2, 
      −z + 27//10 + 9//20 * u^2 − 3//10 * u^3 − 9//20 * u
    ]
  elseif n == 26
    return [
      −x + 9//125 * v^2 + 8//125 * v^3 − 441//125 * u^2 * v + 336//125 * u^3 * v + 24//125 * u * v^3 + 189//250 * u^2 * v^2 + 84//125 * u^2 * v^3 − 72//125 * u^3 * v^2 − 64//125 * u^3 * v^3 − 42//125 * v − 126//125 * u * v + 27//125 * u * v^2, 
      −y + 33//125 * v^2 − 21//10 * u^2 + 8//5 * u^3 + 99//125 * u * v^2 + 693//250 * u^2 * v^2 − 264//125 * u^3 * v^2 − 3//5 * u − 1//5 − 8//125 * v^3 − 24//125 * u * v^3 − 84//125 * u^2 * v^3 + 64//125 * u^3 * v^3, 
      −z + 27//10 + 9//20 * u^2 − 3//10 * u^3 − 9//20 * u
    ]
  elseif n == 27
    return [
      −x + 33//125 * v^2 − 21//10 * u^2 + 8//5 * u^3 + 99//125 * u * v^2 + 693//250 * u^2 * v^2 − 264//125 * u^3 * v^2 − 3//5 * u − 1//5 − 8//125 * v^3 − 24//125 * u * v^3 − 84//125 * u^2 * v^3 + 64//125 * u^3 * v^3, 
      −y − 9//125 * v^2 − 8//125 * v^3 + 441//125 * u^2 * v − 336//125 * u^3 * v − 24//125 * u * v^3 − 189//250 * u^2 * v^2 − 84//125 * u^2 * v^3 + 72//125 * u^3 * v^2 + 64//125 * u^3 * v^3 + 42//125 * v + 126//125 * u * v − 27//125 * u * v^2, 
      −z + 27//10 + 9//20 * u^2 − 3//10 * u^3 − 9//20 * u
    ]
  elseif n == 28
    return [
      −x − 9//125 * v^2 − 8//125 * v^3 + 441//125 * u^2 * v − 336//125 * u^3 * v − 24//125 * u * v^3 − 189//250 * u^2 * v^2 − 84//125 * u^2 * v^3 + 72//125 * u^3 * v^2 + 64//125 * u^3 * v^3 + 42//125 * v + 126//125 * u * v − 27//125 * u * v^2, 
      −y − 33//125 * v^2 + 21//10 * u^2 − 8//5 * u^3 − 99//125 * u * v^2 − 693//250 * u^2 * v^2 + 264//125 * u^3 * v^2 + 3//5 * u + 1//5 + 8//125 * v^3 + 24//125 * u * v^3 + 84//125 * u^2 * v^3 − 64//125 * u^3 * v^3, 
      −z + 27//10 + 9//20 * u^2 − 3//10 * u^3 − 9//20 * u
    ]
  elseif n == 29
    return [
      −x − 5643//1000 * u * v^2 + 51//40 * u^3 + 2673//500 * u^2 * v^2 − 1683//1000 * u^3 * v^2 − 81//20 * u^2 + 171//40 * u + 171//125 * u * v^3 − 162//125 * u^2 * v^3 + 51//125 * u^3 * v^3, 
      −y − 1539//1000 * u * v^2 − 171//125 * u * v^3 + 1071//500 * u^3 * v + 162//125 * u^2 * v^3 − 459//1000 * u^3 * v^2 − 51//125 * u^3 * v^3 − 1701//250 * u^2 * v + 729//500 * u^2 * v^2 + 3591//500 * u * v, 
      −z + 9//40 * u^2 − 3//40 * u^3
    ]
  elseif n == 30
    return [
      −x + 1539//1000 * u * v^2 + 171//125 * u * v^3 − 1071//500 * u^3 * v − 162//125 * u^2 * v^3 + 459//1000 * u^3 * v^2 + 51//125 * u^3 * v^3 + 1701//250 * u^2 * v − 729//500 * u^2 * v^2 − 3591//500 * u * v, 
      −y − 5643//1000 * u * v^2 + 51//40 * u^3 + 2673//500 * u^2 * v^2 − 1683//1000 * u^3 * v^2 − 81//20 * u^2 + 171//40 * u + 171//125 * u * v^3 − 162//125 * u^2 * v^3 + 51//125 * u^3 * v^3, 
      −z + 9//40 * u^2 − 3//40 * u^3
    ]
  elseif n == 31
    return [
      −x + 5643//1000 * u * v^2 − 51//40 * u^3 − 2673//500 * u^2 * v^2 + 1683//1000 * u^3 * v^2 + 81//20 * u^2 − 171//40 * u − 171//125 * u * v^3 + 162//125 * u^2 * v^3 − 51//125 * u^3 * v^3, 
      −y + 1539//1000 * u * v^2 + 171//125 * u * v^3 − 1071//500 * u^3 * v − 162//125 * u^2 * v^3 + 459//1000 * u^3 * v^2 + 51//125 * u^3 * v^3 + 1701//250 * u^2 * v − 729//500 * u^2 * v^2 − 3591//500 * u * v, 
      −z + 9//40 * u^2 − 3//40 * u^3
    ]
  elseif n == 32
    return [
      −x − 1539//1000 * u * v^2 − 171//125 * u * v^3 + 1071//500 * u^3 * v + 162//125 * u^2 * v^3 − 459//1000 * u^3 * v^2 − 51//125 * u^3 * v^3 − 1701//250 * u^2 * v + 729//500 * u^2 * v^2 + 3591//500 * u * v, 
      −y + 5643//1000 * u * v^2 − 51//40 * u^3 − 2673//500 * u^2 * v^2 + 1683//1000 * u^3 * v^2 + 81//20 * u^2 − 171//40 * u − 171//125 * u * v^3 + 162//125 * u^2 * v^3 − 51//125 * u^3 * v^3, 
      −z + 9//40 * u^2 − 3//40 * u^3
    ]
  else # TODO: Add the other patches
    # TODO: Throw error
  end
end

