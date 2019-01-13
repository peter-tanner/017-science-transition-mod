for i, force in pairs(game.forces) do 
	local get_input_count = force.item_production_statistics.get_input_count
	if get_input_count("science-pack-2") > 0 then
		force.recipes["science-pack-2"].enabled = true
		force.technologies["science-pack-2"].researched = true
	--	game.print(force.name .. " | " .. "science-pack-2" .. " | " .. get_input_count("science-pack-2"))
	end
	if get_input_count("science-pack-3") > 0 then
		force.recipes["science-pack-3"].enabled = true
		force.recipes["17-chemical-science-pack"].enabled = true
		force.technologies["science-pack-3"].researched = true
	--	game.print(force.name .. " | " .. "science-pack-3" .. " | " .. get_input_count("science-pack-3"))
	end
	if get_input_count("production-science-pack") > 0 then
		force.recipes["production-science-pack"].enabled = true
		force.recipes["17-production-science-pack"].enabled = true
		force.technologies["production-science-pack"].researched = true
	--	game.print(force.name .. " | " .. "production-science-pack" .. " | " .. get_input_count("production-science-pack"))
	end
	if get_input_count("high-tech-science-pack") > 0 then
		force.recipes["high-tech-science-pack"].enabled = true
		force.recipes["17-utility-science-pack"].enabled = true
		force.technologies["high-tech-science-pack"].researched = true
	--	game.print(force.name .. " | " .. "high-tech-science-pack" .. " | " .. get_input_count("high-tech-science-pack"))
	end
end