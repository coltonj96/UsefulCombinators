data:extend({
	{
		type = "technology",
		name = "useful-combinators",
		icon = "__UsefulCombinators__/graphics/technology/clock.png",
		icon_size = 256,
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "uc-timer-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-counting-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-random-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-converter-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-min-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-max-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-and-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-nand-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-nor-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-not-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-or-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-xnor-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-xor-gate-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-detector-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-sensor-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-railway-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-color-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-emitter-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-receiver-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-power-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-daytime-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-pollution-combinator"
			},
			{
				type = "unlock-recipe",
				recipe = "uc-statistic-combinator"
			}
		},
		prerequisites = {"circuit-network"},
		unit =
		{
			count = 100,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1}
			},
			time = 15
		},
		order = "a-d-d"
	}
})