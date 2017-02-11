data:extend({
  {
    type = "recipe",
    name = "timer-combinator",
    enabled = "false",
    ingredients =
    {
      {"arithmetic-combinator", 1},
      {"constant-combinator", 1}
    },
    result = "timer-combinator"
  },
  {
    type = "recipe",
    name = "counting-combinator",
    enabled = "false",
    ingredients =
    {
      {"arithmetic-combinator", 1},
      {"decider-combinator", 1}
    },
    result = "counting-combinator"
  }--[[,
  {
    type = "recipe",
    name = "pulse-decider-combinator",
    enabled = "false",
    ingredients =
    {
      {"copper-cable", 2},
      {"decider-combinator", 1}
    },
    result = "counting-combinator"
  }]]
})