if settings.startup["017-techtree"].value then
data:extend(
{
	{
		type = "technology",
		name = "science-pack-2",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/green.png",
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "science-pack-2"
			}
		},
		unit =
		{
			count = settings.startup["017-green-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
			},
			time = settings.startup["017-green-energy"].value
		},
		order = "d-a-a-a"
	},
	{
		type = "technology",
		name = "science-pack-3",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/blue.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "17-chemical-science-pack"}
		},
		prerequisites = {"oil-processing", "advanced-electronics", "engine"},
		unit =
		{
			count = settings.startup["017-chem-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
			},
			time = settings.startup["017-chem-energy"].value
		},
		order = "a-d-b-a"
	},
	{
		type = "technology",
		name = "production-science-pack",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/purple.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "17-production-science-pack"}
		},
		prerequisites = {"advanced-material-processing-2", "productivity-module", "railway"},
		unit =
		{
			count = settings.startup["017-purple-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
			},
			time = settings.startup["017-purple-energy"].value
		},
		order = "c-c-b"
	},
	{
		type = "technology",
		name = "high-tech-science-pack",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/yellow.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "17-utility-science-pack"}
		},
		prerequisites = {"advanced-electronics-2", "robotics"},
		unit =
		{
			count = settings.startup["017-gold-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
			},
			time = settings.startup["017-gold-energy"].value
		},
		order = "e-e-e"
	}--, (NEXT UPDATE! SPACE SCIENCE + SATELLITE REBALANCING)
	-- {
		-- type = "technology",
		-- name = "space-science-pack",
		-- icon_size = 128,
		-- icon = "__017_science__/graphics/technology/white.png",
		-- effects =
		-- {
			-- {type = "unlock-recipe", recipe = "17-utility-science-pack"}
		-- },
		-- unit =
		-- {
			-- count = 250,
			-- ingredients =
			-- {
				-- {"science-pack-1", 1},
				-- {"science-pack-2", 1},
				-- {"science-pack-3", 1},
			-- },
			-- time = 15
		-- },
		-- order = "a-d-b-a"
	-- }
})
end