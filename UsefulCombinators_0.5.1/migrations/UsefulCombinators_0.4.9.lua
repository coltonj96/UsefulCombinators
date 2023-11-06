game.reload_script()

for index, force in pairs(game.forces) do
  force.reset_technologies()
  if force.technologies["useful-combinators"].researched then
    force.recipes["uc-random-combinator"].enabled = true
    if force.recipes["uc-comparator-combinator"] then
      force.recipes["uc-comparator-combinator"].enabled = true
    end
    force.recipes["uc-converter-combinator"].enabled = true
    force.recipes["uc-timer-combinator"].enabled = true
    force.recipes["uc-counting-combinator"].enabled = true
    force.recipes["uc-min-combinator"].enabled = true
    force.recipes["uc-max-combinator"].enabled = true
    force.recipes["uc-and-gate-combinator"].enabled = true
    force.recipes["uc-or-gate-combinator"].enabled = true
    force.recipes["uc-not-gate-combinator"].enabled = true
    force.recipes["uc-nand-gate-combinator"].enabled = true
    force.recipes["uc-nor-gate-combinator"].enabled = true
    force.recipes["uc-xor-gate-combinator"].enabled = true
    force.recipes["uc-xnor-gate-combinator"].enabled = true
    force.recipes["uc-detector-combinator"].enabled = true
    force.recipes["uc-sensor-combinator"].enabled = true
    force.recipes["uc-railway-combinator"].enabled = true
    force.recipes["uc-color-combinator"].enabled = true
    force.recipes["uc-emitter-combinator"].enabled = true
    force.recipes["uc-receiver-combinator"].enabled = true
    force.recipes["uc-power-combinator"].enabled = true
    force.recipes["uc-daytime-combinator"].enabled = true
    force.recipes["uc-pollution-combinator"].enabled = true
    force.recipes["uc-statistic-combinator"].enabled = true
  end
end