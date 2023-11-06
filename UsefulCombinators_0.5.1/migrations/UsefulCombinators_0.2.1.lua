game.reload_script()

for index, force in pairs(game.forces) do
  force.reset_technologies()
  if force.technologies["useful-combinators"].researched then
    force.recipes["random-combinator"].enabled = true
    force.recipes["comparator-combinator"].enabled = true
    force.recipes["converter-combinator"].enabled = true
    force.recipes["timer-combinator"].enabled = true
    force.recipes["counting-combinator"].enabled = true
    force.recipes["min-combinator"].enabled = true
    force.recipes["max-combinator"].enabled = true
    force.recipes["and-gate-combinator"].enabled = true
    force.recipes["or-gate-combinator"].enabled = true
    force.recipes["not-gate-combinator"].enabled = true
    force.recipes["nand-gate-combinator"].enabled = true
    force.recipes["nor-gate-combinator"].enabled = true
    force.recipes["xor-gate-combinator"].enabled = true
    force.recipes["xnor-gate-combinator"].enabled = true
    force.recipes["detector-combinator"].enabled = true
    force.recipes["sensor-combinator"].enabled = true
    force.recipes["railway-combinator"].enabled = true
    force.recipes["color-combinator"].enabled = true
  end
end