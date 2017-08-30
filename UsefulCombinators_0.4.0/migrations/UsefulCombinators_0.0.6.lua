game.reload_script()

for index, force in pairs(game.forces) do
  force.reset_technologies()
  if force.technologies["useful-combinators"].researched then
    force.recipes["random-combinator"].enabled = true
    force.recipes["comparator-combinator"].enabled = true
    force.recipes["timer-combinator"].enabled = true
    force.recipes["counting-combinator"].enabled = true
    force.recipes["min-combinator"].enabled = true
    force.recipes["max-combinator"].enabled = true
  end
end