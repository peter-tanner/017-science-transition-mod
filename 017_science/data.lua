require("recipe")

table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe",recipe = "17-military-science-pack"})
table.insert(data.raw["technology"]["advanced-electronics"].effects, {type = "unlock-recipe",recipe = "17-chemical-science-pack"})
table.insert(data.raw["technology"]["advanced-material-processing-2"].effects, {type = "unlock-recipe",recipe = "17-production-science-pack"})
table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "17-utility-science-pack"})

table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "low-density-structure"})
table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "17-low-density-structure"}) --LDS unlock for pre-rocket bases

local effects = data.raw["technology"]["rocket-silo"].effects --remove the duplicate LDS effect in rocket-silo research
for _=1, #effects do
	if effects[_].type == "unlock-recipe" and effects[_].recipe == "low-density-structure" then
		effects[_] = nil
	end
end