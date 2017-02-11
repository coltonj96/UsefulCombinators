data:extend({
  {
    type = "constant-combinator",
    name = "timer-combinator",
    icon = "__UsefulCombinators__/graphics/icons/timer-combinator.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "timer-combinator"},
    max_health = 50,
    corpse = "small-remnants",

    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    item_slot_count = 5,
    
    sprites =
    {
      north =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        x = 158,
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      east =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      south =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        x = 237,
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      west =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        x = 79,
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      }
    },

    activity_led_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-north.png",
        width = 11,
        height = 10,
        frame_count = 1,
        shift = {0.296875, -0.40625},
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-east.png",
        width = 14,
        height = 12,
        frame_count = 1,
        shift = {0.25, -0.03125},
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-south.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {-0.296875, -0.078125},
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-west.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.21875, -0.46875},
      }
    },

    activity_led_light =
    {
      intensity = 0.8,
      size = 1,
    },

    activity_led_light_offsets =
    {
      {0.296875, -0.40625},
      {0.25, -0.03125},
      {-0.296875, -0.078125},
      {-0.21875, -0.46875}
    },

    circuit_wire_connection_points =
    {
      {
        shadow =
        {
          red = {0.15625, -0.28125},
          green = {0.65625, -0.25}
        },
        wire =
        {
          red = {-0.28125, -0.5625},
          green = {0.21875, -0.5625},
        }
      },
      {
        shadow =
        {
          red = {0.75, -0.15625},
          green = {0.75, 0.25},
        },
        wire =
        {
          red = {0.46875, -0.5},
          green = {0.46875, -0.09375},
        }
      },
      {
        shadow =
        {
          red = {0.75, 0.5625},
          green = {0.21875, 0.5625}
        },
        wire =
        {
          red = {0.28125, 0.15625},
          green = {-0.21875, 0.15625}
        }
      },
      {
        shadow =
        {
          red = {-0.03125, 0.28125},
          green = {-0.03125, -0.125},
        },
        wire =
        {
          red = {-0.46875, 0},
          green = {-0.46875, -0.40625},
        }
      }
    },
    circuit_wire_max_distance = 7.5
  },
  {
    type = "constant-combinator",
    name = "counting-combinator",
    icon = "__UsefulCombinators__/graphics/icons/counting-combinator.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "counting-combinator"},
    max_health = 50,
    corpse = "small-remnants",

    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

    item_slot_count = 3,
    
    sprites =
    {
      north =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities2.png",
        x = 158,
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      east =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities2.png",
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      south =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities2.png",
        x = 237,
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      west =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities2.png",
        x = 79,
        y = 126,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      }
    },

    activity_led_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-north.png",
        width = 11,
        height = 10,
        frame_count = 1,
        shift = {0.296875, -0.40625},
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-east.png",
        width = 14,
        height = 12,
        frame_count = 1,
        shift = {0.25, -0.03125},
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-south.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {-0.296875, -0.078125},
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-constant-west.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.21875, -0.46875},
      }
    },

    activity_led_light =
    {
      intensity = 0.8,
      size = 1,
    },

    activity_led_light_offsets =
    {
      {0.296875, -0.40625},
      {0.25, -0.03125},
      {-0.296875, -0.078125},
      {-0.21875, -0.46875}
    },

    circuit_wire_connection_points =
    {
      {
        shadow =
        {
          red = {0.15625, -0.28125},
          green = {0.65625, -0.25}
        },
        wire =
        {
          red = {-0.28125, -0.5625},
          green = {0.21875, -0.5625},
        }
      },
      {
        shadow =
        {
          red = {0.75, -0.15625},
          green = {0.75, 0.25},
        },
        wire =
        {
          red = {0.46875, -0.5},
          green = {0.46875, -0.09375},
        }
      },
      {
        shadow =
        {
          red = {0.75, 0.5625},
          green = {0.21875, 0.5625}
        },
        wire =
        {
          red = {0.28125, 0.15625},
          green = {-0.21875, 0.15625}
        }
      },
      {
        shadow =
        {
          red = {-0.03125, 0.28125},
          green = {-0.03125, -0.125},
        },
        wire =
        {
          red = {-0.46875, 0},
          green = {-0.46875, -0.40625},
        }
      }
    },
    circuit_wire_max_distance = 7.5
  }--[[,
  {
    type = "decider-combinator",
    name = "pulse-decider-combinator",
    icon = "__UsefulCombinators__/graphics/icons/pulse-decider-combinator.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "pulse-decider-combinator"},
    max_health = 50,
    corpse = "small-remnants",
    collision_box = {{-0.35, -0.65}, {0.35, 0.65}},
    selection_box = {{-0.5, -1}, {0.5, 1}},

    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    active_energy_usage = "1KW",

    sprites =
    {
      north =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        x = 158,
        y = 63,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      east =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        y = 63,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      south =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        x = 237,
        y = 63,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      },
      west =
      {
        filename = "__UsefulCombinators__/graphics/entity/combinator/combinator-entities.png",
        x = 79,
        y = 63,
        width = 79,
        height = 63,
        frame_count = 1,
        shift = {0.140625, 0.140625},
      }
    },

    activity_led_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-north.png",
        width = 11,
        height = 12,
        frame_count = 1,
        shift = {0.265625, -0.53125},
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-east.png",
        width = 11,
        height = 11,
        frame_count = 1,
        shift = {0.515625, -0.078125},
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-south.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.25, 0.03125},
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/activity-leds/combinator-led-decider-west.png",
        width = 12,
        height = 12,
        frame_count = 1,
        shift = {-0.46875, -0.5},
      }
    },

    activity_led_light =
    {
      intensity = 0.8,
      size = 1,
    },

    activity_led_light_offsets =
    {
      {0.265625, -0.53125},
      {0.515625, -0.078125},
      {-0.25, 0.03125},
      {-0.46875, -0.5}
    },

    screen_light =
    {
      intensity = 0.3,
      size = 0.6,
    },

    screen_light_offsets =
    {
      {0.015625, -0.265625},
      {0.015625, -0.359375},
      {0.015625, -0.265625},
      {0.015625, -0.359375}
    },

    equal_symbol_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      }
    },
    greater_symbol_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      }
    },
    less_symbol_sprites =
    {
      north =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      east =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      },
      south =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.265625}
      },
      west =
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        frame_count = 1,
        shift = {0.015625, -0.359375}
      }
    },

    input_connection_bounding_box = {{-0.5, 0}, {0.5, 1}},
    output_connection_bounding_box = {{-0.5, -1}, {0.5, 0}},

    input_connection_points =
    {
      {
        shadow =
        {
          red = {0.328125, 0.703125},
          green = {0.859375, 0.703125}
        },
        wire =
        {
          red = {-0.28125, 0.34375},
          green = {0.25, 0.34375},
        }
      },
      {
        shadow =
        {
          red = {-0.265625, -0.171875},
          green = {-0.296875, 0.296875},
        },
        wire =
        {
          red = {-0.75, -0.5},
          green = {-0.75, -0.0625},
        }
      },
      {
        shadow =
        {
          red = {0.828125, -0.359375},
          green = {0.234375, -0.359375}
        },
        wire =
        {
          red = {0.25, -0.71875},
          green = {-0.28125, -0.71875}
        }
      },
      {
        shadow =
        {
          red = {1.29688, 0.328125},
          green = {1.29688, -0.140625},
        },
        wire =
        {
          red = {0.75, -0.0625},
          green = {0.75, -0.53125},
        }
      }
    },

    output_connection_points =
    {
      {
        shadow =
        {
          red = {0.234375, -0.453125},
          green = {0.828125, -0.453125}
        },
        wire =
        {
          red = {-0.3125, -0.78125},
          green = {0.28125, -0.78125},
        }
      },
      {
        shadow =
        {
          red = {1.17188, -0.109375},
          green = {1.17188, 0.296875},
        },
        wire =
        {
          red = {0.65625, -0.4375},
          green = {0.65625, -0.03125},
        }
      },
      {
        shadow =
        {
          red = {0.828125, 0.765625},
          green = {0.234375, 0.765625}
        },
        wire =
        {
          red = {0.28125, 0.40625},
          green = {-0.3125, 0.40625}
        }
      },
      {
        shadow =
        {
          red = {-0.140625, 0.328125},
          green = {-0.140625, -0.078125},
        },
        wire =
        {
          red = {-0.6875, -0.03125},
          green = {-0.6875, -0.4375},
        }
      }
    },
    circuit_wire_max_distance = 7.5
  }]]
})