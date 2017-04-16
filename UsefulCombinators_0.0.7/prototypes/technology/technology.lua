data:extend({
  {
    type = "technology",
    name = "useful-combinators",
    icon = "__UsefulCombinators__/graphics/technology/clock.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "timer-combinator"
      },
      {
        type = "unlock-recipe",
        recipe = "counting-combinator"
      },
      {
        type = "unlock-recipe",
        recipe = "random-combinator"
      }--[[,
      {
        type = "unlock-recipe",
        recipe = "logic-combinator"
      }]],
      {
        type = "unlock-recipe",
        recipe = "comparator-combinator"
      },
      {
        type = "unlock-recipe",
        recipe = "min-combinator"
      },
      {
        type = "unlock-recipe",
        recipe = "max-combinator"
      }
    },
    prerequisites = {"circuit-network"},
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1}
      },
      time = 15
    },
    order = "a-d-d"
  }
})