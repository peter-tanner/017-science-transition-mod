require("recipe")

table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe",recipe = "17-military-science-pack"})
table.insert(data.raw["technology"]["advanced-electronics"].effects, {type = "unlock-recipe",recipe = "17-chemical-science-pack"})
table.insert(data.raw["technology"]["advanced-material-processing-2"].effects, {type = "unlock-recipe",recipe = "17-production-science-pack"})
table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "17-utility-science-pack"})

table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "rocket-control-unit"})

table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "low-density-structure"})
table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "17-low-density-structure"}) --LDS unlock for pre-rocket bases

table.insert(data.raw["technology"]["advanced-material-processing-2"].effects, {type = "unlock-recipe",recipe = "rocket-fuel"})

local effects = data.raw["technology"]["rocket-silo"].effects --remove the duplicate LDS effect in rocket-silo research
for _=1, #effects do
	if effects[_].type == "unlock-recipe" and (effects[_].recipe == "low-density-structure" or effects[_].recipe == "rocket-fuel" or effects[_].recipe == "rocket-control-unit") then
		effects[_] = nil
	end
end

local technology = data.raw["technology"]["rocket-silo"].prerequisites
for _=1, #technology do
	if technology[_] == "rocket-speed-5" then
		technology[_] = nil
	end
end

if not settings.startup["017-old-science"].value then
	data.raw["recipe"]["science-pack-3"].hidden = true
	local effects = data.raw["technology"]["advanced-electronics"].effects
	for _=1, #effects do if effects[_].type == "unlock-recipe" and effects[_].recipe == "science-pack-3" then effects[_] = nil end end

	data.raw["recipe"]["military-science-pack"].hidden = true
	local effects = data.raw["technology"]["military-2"].effects
	for _=1, #effects do if effects[_].type == "unlock-recipe" and effects[_].recipe == "military-science-pack" then effects[_] = nil end end	

	data.raw["recipe"]["production-science-pack"].hidden = true
	local effects = data.raw["technology"]["advanced-material-processing-2"].effects
	for _=1, #effects do if effects[_].type == "unlock-recipe" and effects[_].recipe == "production-science-pack" then effects[_] = nil end end	

	data.raw["recipe"]["high-tech-science-pack"].hidden = true
	local effects = data.raw["technology"]["advanced-electronics-2"].effects
	for _=1, #effects do if effects[_].type == "unlock-recipe" and effects[_].recipe == "high-tech-science-pack" then effects[_] = nil end end	
end