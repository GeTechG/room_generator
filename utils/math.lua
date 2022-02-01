

function math.clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

function math.normalDistribution(x, u, q)
  u = u or 0
  q = q or 1
  return 1 / math.sqrt(2 * math.pi) * math.exp(0 - math.pow(x - u, 2) / 2 * math.pow(q, 2))
end

function math.boxMullerRandom(u)
    local u = u or math.random()
    local v = math.random()
    local  z = math.sqrt(-2 * math.log(u)) * math.cos( 2 * math.pi * v)
    z = (z + 3) / 6
    z = math.clamp(z , 0 , 1 )
    return z
end



function math.choose(t)
   return t[math.random(1, #t)]
end
