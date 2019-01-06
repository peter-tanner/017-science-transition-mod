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

data.raw["technology"]["rocket-silo"].unit.ingredients =
{
	{"science-pack-1", 1},
	{"science-pack-2", 1},
	{"science-pack-3", 1},
	--{"military-science-pack", 1},
	{"production-science-pack", 1},
	{"high-tech-science-pack", 1}
}

data.raw["recipe"]["atomic-bomb"].ingredients =
{
	{"rocket-control-unit", 15}, --{"processing-unit", 20},
	{"explosives", 10},
	{"uranium-235", 30}
}
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