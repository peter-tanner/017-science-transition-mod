if settings.startup["017-techtree"].value then
data:extend(
{
	{
		type = "technology",
		name = "logistics-science-pack",
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
		name = "chemical-science-pack",
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
		name = "utility-science-pack",
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
	},
	{
		type = "technology",
		name = "lubricant",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/lubricant.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "lubricant"}
		},
		prerequisites = {"oil-processing"},
		unit =
		{
			count = settings.startup["017-lubricant-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
			},
			time = settings.startup["017-lubricant-energy"].value
		},
		order = "d-a-a"
	},
	{
		type = "technology",
		name = "rocket-fuel",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/rocketfuel.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "rocket-fuel"}
		},
		prerequisites = {"engine", "flammables"},
		unit =
		{
			count = settings.startup["017-rocket-fuel-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
			},
			time = settings.startup["017-rocket-fuel-energy"].value
		},
		order = "d-a-b"
	},
	{
		type = "technology",
		name = "low-density-structure",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/rocketstructure.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "17-low-density-structure"}
		},
		prerequisites = {"advanced-material-processing"},
		unit =
		{
			count = settings.startup["017-rocket-structure-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
			},
			time = settings.startup["017-rocket-structure-energy"].value
		},
		order = "e-e-e"
	},
	{
		type = "technology",
		name = "rocket-control-unit",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/rocketcontrols.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "rocket-control-unit"}
		},
		prerequisites = {"speed-module"},
		unit =
		{
			count = settings.startup["017-rocket-control-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
				{"high-tech-science-pack", 1},
			},
			time = settings.startup["017-rocket-control-energy"].value
		},
		order = "e-e-e"
	},
	{
		type = "technology",
		name = "uranium-enrichment",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/uraniumenrichment.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "centrifuge"},
			{type = "unlock-recipe", recipe = "uranium-processing"}
		},
		prerequisites = data.raw["technology"]["nuclear-power"].prerequisites,
		unit =
		{
			count = settings.startup["017-uranium-enrichment-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
			},
			time = settings.startup["017-uranium-enrichment-energy"].value
		},
		order = "e-e-e"
	}
})
end

if settings.startup["017-techtree"].value and settings.startup["017-rocket-victory"].value then
data:extend(
{
	{
		type = "technology",
		name = "space-science-pack",
		icon_size = 128,
		icon = "__017_science__/graphics/technology/white.png",
		effects =
		{
			{type = "unlock-recipe", recipe = "satellite"}
		},
		prerequisites = {"rocket-silo"},
		unit =
		{
			count = settings.startup["017-nasa-cost"].value,
			ingredients =
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
				{"military-science-pack", 1},
				{"production-science-pack", 1},
				{"high-tech-science-pack", 1}
			},
			time = settings.startup["017-nasa-energy"].value,
		},
		order = "k-b"
	}
})
end