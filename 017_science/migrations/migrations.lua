for i, force in pairs(game.forces) do 
	force.reset_recipes()
end

for i, force in pairs(game.forces) do 
	force.reset_technologies()
end

for i, force in pairs(game.forces) do 
	if force.technologies["military-2"].researched then 
		force.recipes["17-military-science-pack"].enabled = true
	end
	if force.technologies["advanced-electronics"].researched then 
		force.recipes["17-chemical-science-pack"].enabled = true
	end
	if force.technologies["advanced-material-processing-2"].researched then 
		force.recipes["17-production-science-pack"].enabled = true
		force.recipes["rocket-fuel"].enabled = true
	end
	if force.technologies["advanced-electronics-2"].researched then 
		force.recipes["low-density-structure"].enabled = true
		force.recipes["17-low-density-structure"].enabled = true
		force.recipes["17-utility-science-pack"].enabled = true
		force.recipes["rocket-control-unit"].enabled = true
	end
end