data:extend(
{
	-- {
		-- type = "recipe",
		-- name = "science-pack-1",
		-- energy_required = 5,
		-- ingredients =
		-- {
			-- {"copper-plate", 1},
			-- {"iron-gear-wheel", 1}
		-- },
		-- result = "science-pack-1"
	-- },
	-- {
		-- type = "recipe",
		-- name = "science-pack-2",
		-- energy_required = 6,
		-- ingredients =
		-- {
			-- {"inserter", 1},
			-- {"transport-belt", 1}
		-- },
		-- result = "science-pack-2"
	-- },
	{
		type = "recipe",
		name = "17-chemical-science-pack", --"science-pack-3"
		enabled = false,
		energy_required = 24, --12
		ingredients =
		{
			{"advanced-circuit", 3}, --3
			{"engine-unit", 2}, --1
			{"solid-fuel", 1} --{"electric-mining-drill", 1}
		},
		icon = "__017_science__/graphics/icons/chemical.png",
		icon_size = 64,
		result_count = 2, --(+)
		result = "science-pack-3"
	},
	{
		type = "recipe",
		name = "17-military-science-pack", --"military-science-pack"
		enabled = false,
		energy_required = 10,
		ingredients =
		{
			{"piercing-rounds-magazine", 1},
			{"grenade", 1},
			{"stone-wall", 2} --{"gun-turret", 1}
		},
		icon = "__017_science__/graphics/icons/military.png",
		icon_size = 64,		
		result_count = 2,
		result = "military-science-pack"
	},
	{
		type = "recipe",
		name = "17-production-science-pack", --"production-science-pack"
		enabled = false,
		energy_required = 21, --14
		ingredients =
		{
			{"rail", 30}, --{"electric-engine-unit", 1},
			{"electric-furnace", 1},
			{"productivity-module", 1} --(+)
		},
		icon = "__017_science__/graphics/icons/production.png",
		icon_size = 64,
		result_count = 3, --2
		result = "production-science-pack"
	},
	{
		type = "recipe",
		name = "17-utility-science-pack", --"high-tech-science-pack"
		enabled = false,
		energy_required = 21, --14
		ingredients =
		{
			--{"battery", 1},
			{"processing-unit", 2}, --3
			{"flying-robot-frame", 1}, --{"speed-module", 1},
			{"low-density-structure", 3} --{"copper-cable", 30}
		},
		icon = "__017_science__/graphics/icons/utility.png",
		icon_size = 64,
		result_count = 3,
		result = "high-tech-science-pack"
	},
	
	--LDS changes
	{		
		type = "recipe",
		name = "17-low-density-structure",
		category = "crafting",
		normal =
		{
			energy_required = 20, --30
			enabled = false,
			ingredients =
			{
				{"steel-plate", 2}, --10
				{"copper-plate", 20}, --5
				{"plastic-bar", 5} --5
			},
			result= "low-density-structure"
		},
		expensive =
		{
			energy_required = 20, --30
			enabled = false,
			ingredients =
			{
				{"steel-plate", 4}, --10
				{"copper-plate", 20}, --10
				{"plastic-bar", 10}
			},
			result= "low-density-structure"
		},
		icon = "__017_science__/graphics/icons/LDS.png",
		icon_size = 32
	}
})
--Mining
if settings.startup["017-axe"].value then
data:extend(
{
	{
		type = "recipe",
		name = "017-mine",
		energy = 0.025,
		ingredients = {},
		result = "017-mine",
		icon = "__base__/graphics/icons/iron-axe.png",
		icon_size = 32
	},
	{
		type = "item",
		name = "017-mine",
		localised_description = {"item-description.mining-tool"},	
		icon = "__base__/graphics/icons/iron-axe.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "tool",
		order = "a[mining]-a[iron-axe]",
		stack_size = 1
	}
})
end
