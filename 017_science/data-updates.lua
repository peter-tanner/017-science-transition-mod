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