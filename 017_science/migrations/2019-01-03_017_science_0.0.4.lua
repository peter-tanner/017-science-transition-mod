for i, force in pairs(game.forces) do 
	if force.technologies["advanced-electronics-2"].researched then 
		force.recipes["low-density-structure"].enabled = true
		force.recipes["17-low-density-structure"].enabled = true
	end
end

for i, force in pairs(game.forces) do 
	force.reset_recipes()
end

for i, force in pairs(game.forces) do 
	force.reset_technologies()
end