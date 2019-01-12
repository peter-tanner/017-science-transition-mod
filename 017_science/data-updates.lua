--whitelist for productivity module effect
for _, mod in pairs(data.raw.module) do
	if mod.effect ~= nil then
		for _, effect in pairs(mod.effect) do
			if effect[1] == productivity then
				if mod.limitation ~= nil then
					local limitation = mod.limitation
					--new stuff
					table.insert(limitation, "17-military-science-pack")
					table.insert(limitation, "17-chemical-science-pack")
					table.insert(limitation, "17-production-science-pack")
					table.insert(limitation, "17-utility-science-pack")
					table.insert(limitation, "17-low-density-structure")					
				end
			end
		end
	end
end

--overrides
local function recipe_change(table, condition, replace)
	for _=1, #table do
		if table[_][1] == condition then
			table[_] = replace
		end
	end
end

local function prerequisites(technology, condition, replace)
	for _=1, #technology do
		if technology[_] == condition then
			table.remove(technology, _)
			if replace ~= nil then
				table.insert(technology, replace)
			end
		end
	end
end

local function remove_science(technology, science_pack)
	for _, ingredient in pairs (technology) do
		if ingredient[1] == science_pack then
			table.remove(technology, _)
		end
	end
end

remove_science(data.raw["technology"]["rocket-silo"].unit.ingredients, "military-science-pack")

if settings.startup["017-recipes-changes"].value then
	recipe_change(data.raw["recipe"]["atomic-bomb"].ingredients, "processing-unit", {"rocket-control-unit", 15})
	
	recipe_change(data.raw["recipe"]["power-armor-mk2"].ingredients, "speed-module-3", {"speed-module-2", 5})
	recipe_change(data.raw["recipe"]["power-armor-mk2"].ingredients, "effectivity-module-3", {"effectivity-module-2", 5})
	local power_armor = data.raw["technology"]["power-armor-2"].prerequisites
	prerequisites(power_armor, "speed-module-3", "speed-module-2")
	prerequisites(power_armor, "effectivity-module-3", "effectivity-module-2")
	table.insert(power_armor, "advanced-electronics-2")
end

local effects = data.raw["technology"]["rocket-silo"].effects --remove the duplicate LDS effect in rocket-silo research
for _=1, #effects do
	if effects[_].type == "unlock-recipe" and (effects[_].recipe == "low-density-structure" or effects[_].recipe == "rocket-fuel" or effects[_].recipe == "rocket-control-unit") then
		effects[_] = nil
	end
end

prerequisites(data.raw["technology"]["rocket-silo"].prerequisites, "rocket-speed-5", nil)

--player equipment changes
--https://forums.factorio.com/viewtopic.php?t=6059
if settings.startup["017-durability"].value then
	for _, axe in pairs(data.raw["mining-tool"]) do
		axe.durability = math.huge
	end

	for _, armor in pairs(data.raw["armor"]) do
		armor.durability = math.huge
	end
end

if settings.startup["017-axe"].value then
	for _, axe in pairs(data.raw["mining-tool"]) do
		for i, r in pairs(data.raw["recipe"]) do
			if data.raw["recipe"][i].result == axe.name then
				data.raw["recipe"][i].hidden = true
				data.raw["recipe"][i].ingredients = {}
			end
		end
	end
end

if settings.startup["017-equipment"].value and data.raw["recipe"]["belt-immunity-equipment"] == nil then
	data:extend({
		{
			type = "technology",
			name = "belt-immunity-equipment",
			icon_size = 128,
			icon = "__017_science__/graphics/belt-immunity-equipment.png",
			prerequisites = {"modular-armor"},
			effects =
			{
				{
					type = "unlock-recipe",
					recipe = "belt-immunity-equipment"
				}
			},
			unit =
			{
				count = 50,
				ingredients = {{"science-pack-1", 1}, {"science-pack-2", 1}},
				time = 15
			},
			order = "g-ga"
		},
		{
			type = "recipe",
			name = "belt-immunity-equipment",
			enabled = false,
			energy_required = 10,
			ingredients =
			{
				{"advanced-circuit", 5},
				{"steel-plate", 10}
			},
			result = "belt-immunity-equipment"
		}
	})
end

local lds_recipes = {
	"energy-shield-mk2-equipment",
	"battery-mk2-equipment",
	"fusion-reactor-equipment",
	"personal-laser-defense-equipment",
	"discharge-defense-equipment", -- sorry for indirectly nerfing discharge-defense :(
	"exoskeleton-equipment",
	"personal-roboport-mk2-equipment",
	"power-armor-mk2"
}

if settings.startup["017-lds"].value then
	local recipe = data.raw["recipe"]
	for _, r in pairs(recipe) do
		for _, l in pairs(lds_recipes) do
			if r.name == l then
				modified = false
				for _=1, #r.ingredients do
					if r.ingredients[_][1] == "steel-plate" then
						local n = math.ceil(r.ingredients[_][2] / 2)
						table.remove(r.ingredients, _)
						r.ingredients[#r.ingredients+1] = {"low-density-structure", n}
						modified = true
					end
				end
				if modified == false then
					for _=1, #r.ingredients do
						if r.ingredients[_][1] == "processing-unit" then
							local n = math.ceil(r.ingredients[_][2] / settings.startup["017-lds-num"].value)
							r.ingredients[#r.ingredients+1] = {"low-density-structure", n}
						end
					end
				end
			end
		end
	end
end

--HUGE THANKS to Dimava for the following changes
--Added options for some changes (for modded users)

--increase belt speed to 15x
for _, belt in pairs(data.raw["splitter"]) do
	if (belt.speed * 32) % 1 == 0 and belt.speed * 32 < 8 then
		belt.speed = belt.speed * 45 / 40;
	end
end
for _, belt in pairs(data.raw["transport-belt"]) do
	if (belt.speed * 32) % 1 == 0 and belt.speed * 32 < 8 then
		belt.speed = belt.speed * 45 / 40;
	end
end
for _, belt in pairs(data.raw["underground-belt"]) do
	if (belt.speed * 32) % 1 == 0 and belt.speed * 32 < 8 then
		belt.speed = belt.speed * 45 / 40;
	end
end

if settings.startup["017-drill"].value then
	--simplify drill stats
	data.raw["mining-drill"]["burner-mining-drill"].mining_speed = 0.25
	data.raw["mining-drill"]["burner-mining-drill"].mining_power = 3

	--simplify ore hardness
	for _, ore in pairs(data.raw.resource) do
		if ore.minable.hardness == 0.9 then
			ore.minable.hardness = 1
		end
	end
	data.raw.resource.stone.minable.hardness = 1
end

if settings.startup["017-smelting"].value then
	--decrease smelting times
	for _, recipe in pairs(data.raw.recipe) do
		if recipe.category=="smelting" then
			if recipe.energy_required then
				if (recipe.energy_required / 3.5) % 1 == 0 then
					recipe.energy_required = recipe.energy_required * 3.2 / 3.5
				end
			else
				if (recipe.normal.energy_required / 3.5) % 1 == 0 then
					recipe.normal.energy_required = recipe.normal.energy_required * 3.2 / 3.5
				end
				if (recipe.expensive.energy_required / 3.5) % 1 == 0 then
					recipe.expensive.energy_required = recipe.expensive.energy_required * 3.2 / 3.5
				end			
			end
		end
	end
end

if settings.startup["017-assem-lim"].value then
	--remove assembling-machine ingredient_count limits
	for _, machine in pairs(data.raw["assembling-machine"]) do
		if machine.ingredient_count < 10 then
			machine.ingredient_count = 10
		end
	end
end