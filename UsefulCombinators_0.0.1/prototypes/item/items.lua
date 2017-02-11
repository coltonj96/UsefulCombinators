data:extend(
{ 
  {
    type = "item",
    name = "timer-combinator",
    icon = "__UsefulCombinators__/graphics/icons/timer-combinator.png",
    flags = { "goes-to-quickbar" },
    subgroup = "circuit-network",
    place_result="timer-combinator",
    order = "b[combinators]-u[timer-combinator]",
    stack_size= 10,
  },
  {
    type = "item",
    name = "counting-combinator",
    icon = "__UsefulCombinators__/graphics/icons/counting-combinator.png",
    flags = { "goes-to-quickbar" },
    subgroup = "circuit-network",
    place_result="counting-combinator",
    order = "b[combinators]-u[counting-combinator]",
    stack_size= 10,
  }--[[,
  {
    type = "item",
    name = "pulse-decider-combinator",
    icon = "__UsefulCombinators__/graphics/icons/pulse-decider-combinator.png",
    flags = { "goes-to-quickbar" },
    subgroup = "circuit-network",
    place_result="pulse-decider-combinator",
    order = "b[combinators]-u[pulse-decider-combinator]",
    stack_size= 10,
  }]]
}) 