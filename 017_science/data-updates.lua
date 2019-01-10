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

local function replace_table(table, condition, replace)
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

replace_table(data.raw["technology"]["rocket-silo"].unit.ingredients, "military-science-pack", nil)

if settings.startup["017-recipes-changes"].value then
	replace_table(data.raw["recipe"]["atomic-bomb"].ingredients, "processing-unit", {"rocket-control-unit", 15})
	
	replace_table(data.raw["recipe"]["power-armor-mk2"].ingredients, "speed-module-3", {"speed-module-2", 5})
	replace_table(data.raw["recipe"]["power-armor-mk2"].ingredients, "effectivity-module-3", {"effectivity-module-2", 5})
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