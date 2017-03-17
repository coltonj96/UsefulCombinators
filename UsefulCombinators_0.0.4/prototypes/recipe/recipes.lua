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
  },
  {
    type = "recipe",
    name = "random-combinator",
    enabled = "false",
    ingredients =
    {
      {"advanced-circuit", 1},
      {"constant-combinator", 1}
    },
    result = "random-combinator"
  }--[[,
  {
    type = "recipe",
    name = "logic-combinator",
    enabled = "false",
    ingredients =
    {
      {"advanced-circuit", 1},
      {"decider-combinator", 1}
    },
    result = "logic-combinator"
  }]],
  {
    type = "recipe",
    name = "comparator-combinator",
    enabled = "false",
    ingredients =
    {
      {"constant-combinator", 1},
      {"decider-combinator", 1}
    },
    result = "comparator-combinator"
  }
})