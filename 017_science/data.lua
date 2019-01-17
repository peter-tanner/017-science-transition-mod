require("recipe")
require("technology")

if not settings.startup["017-techtree"].value then
	table.insert(data.raw["technology"]["military-2"].effects, {type = "unlock-recipe",recipe = "17-military-science-pack"})
	table.insert(data.raw["technology"]["advanced-electronics"].effects, {type = "unlock-recipe",recipe = "17-chemical-science-pack"})
	table.insert(data.raw["technology"]["advanced-material-processing-2"].effects, {type = "unlock-recipe",recipe = "17-production-science-pack"})
	table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "17-utility-science-pack"})
	
	table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "rocket-control-unit"})
	table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "17-low-density-structure"}) --LDS unlock for pre-rocket bases
	table.insert(data.raw["technology"]["advanced-material-processing-2"].effects, {type = "unlock-recipe",recipe = "rocket-fuel"})
	if settings.startup["017-old-science"].value then
		table.insert(data.raw["technology"]["advanced-electronics-2"].effects, {type = "unlock-recipe",recipe = "low-density-structure"})		
	end
end


if not settings.startup["017-old-science"].value then
	local function hide(name, technology)
		data.raw["recipe"][name].hidden = true
		local effects = data.raw["technology"][technology].effects
		for _=1, #effects do
			if effects[_].type == "unlock-recipe" and effects[_].recipe == name then
				effects[_] = nil
			end
		end
	end
	
	hide("science-pack-3", "advanced-electronics")
	hide("military-science-pack", "military-2")
	hide("production-science-pack", "advanced-material-processing-2")
	hide("high-tech-science-pack", "advanced-electronics-2")
	
	data.raw["recipe"]["low-density-structure"].normal.hidden = true
	data.raw["recipe"]["low-density-structure"].expensive.hidden = true	
elseif settings.startup["017-old-science"].value then
	data.raw["recipe"]["science-pack-3"].hidden = false
	data.raw["recipe"]["military-science-pack"].hidden = false
	data.raw["recipe"]["production-science-pack"].hidden = false
	data.raw["recipe"]["high-tech-science-pack"].hidden = false
	data.raw["recipe"]["low-density-structure"].normal.hidden = false
	data.raw["recipe"]["low-density-structure"].expensive.hidden = false	
end