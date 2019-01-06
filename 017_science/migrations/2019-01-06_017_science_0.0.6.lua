for i, force in pairs(game.forces) do 
	if force.technologies["advanced-electronics-2"].researched then 
		force.recipes["rocket-control-unit"].enabled = true
	end
	if force.technologies["advanced-material-processing-2"].researched then
		force.recipes["rocket-fuel"].enabled = true
	end
end

for i, force in pairs(game.forces) do 
	force.reset_recipes()
end

for i, force in pairs(game.forces) do 
	force.reset_technologies()
end