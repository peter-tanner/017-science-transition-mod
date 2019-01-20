local function compare(technology, science_pack, pre_tier)
	valid = true
	if technology and technology.unit then
		for l, j in pairs(technology.unit.ingredients) do
			if j[1] == pre_tier then
				valid = true
				break
			else
				valid = false
			end
		end
	end
	if valid == true then
		if technology.prerequisites then
			for _=1, #technology.prerequisites do
				local tech = data.raw["technology"][technology.prerequisites[_]]
				if valid == true then
					if tech then
						if tech.unit then
							for i, ingredients in pairs(tech.unit.ingredients) do
								if ingredients[1] == pre_tier then
									valid = false
									break
								else
									valid = true
								end
							end
						elseif valid == false then
							break
						end
					elseif valid == false then
						break
					end
				end
			end
		end
	end
	if technology.prerequisites and valid == true then
		technology.prerequisites[#technology.prerequisites+1] = science_pack
		return true
	else
		return false
	end
end

for _, tech in pairs(data.raw["technology"]) do
	if tech.name ~= ("logistics-science-pack" or "chemical-science-pack" or "production-science-pack" or "utility-science-pack" or "space-science-pack") then
		if tech.effects then
			if #tech.effects ~= 0 then
				for i, effect in pairs(tech.effects) do
					if effect then
						if effect.type then
							if effect.type == "unlock-recipe" then
								whitelisted = true
								break
							else
								whitelisted = false
							end
						end
					end
				end
			end
			if settings.startup["017-rocket-victory"].value then
				if whitelisted == false then
					if tech.unit then
						if tech.unit.ingredients then
							for j, nasa in pairs(tech.unit.ingredients) do
								if nasa[1] == "space-science-pack" then
									compare(tech, "space-science-pack", "space-science-pack")
									break
								else
									whitelisted = false
								end
							end
						end
					end
				end
			end
			if whitelisted == true then
				local valid = compare(tech, "logistics-science-pack", "science-pack-2")
				if valid == false then
					local valid = compare(tech, "chemical-science-pack", "science-pack-3") end
				if valid == false then
					local valid = compare(tech, "production-science-pack", "production-science-pack") end
				if valid == false then
					local valid = compare(tech, "military-science-pack", "military-science-pack") end
				if valid == false then
					compare(tech, "utility-science-pack", "high-tech-science-pack")
				end
			end
		end
	end
end