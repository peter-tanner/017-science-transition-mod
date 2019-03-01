script.on_configuration_changed(function()
	local old_science = settings.startup["017-old-science"].value
	game.print("MIGRATING SAVE TO BASE 0.17 ...")
	if not settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do
			local f_recipes = force.recipes
			local f_technologies = force.technologies
			local f_print = force.print
			
			f_print("0.17 techtree disabled.")
			f_print("WARNING: MIGRATING SAVES WITH 0.17 TECHTREE DISABLED HAS NOT BEEN TESTED.")
			f_print("It is recommended that your base use the 0.17 techtree before upgrading.")
			f_print("Please report any issues to the disccusion page.")
			f_recipes["logistic-science-pack"].enabled = true
			
			if f_technologies["rocket-silo"].researched == true then
				f_recipes["satellite"].enabled = true
				f_print("rocket-silo researched for this force: satellite recipe auto-unlocked")
			else
				f_print("rocket-silo not researched: satellite recipe not auto-unlocking")
			end
			
			if f_technologies["oil-processing"].researched == true then
				f_recipes["lubricant"].enabled = true
				f_print("oil-processing researched for this force: lubricant recipe auto-unlocked")
			else
				f_print("oil-processing not researched: lubricant recipe not auto-unlocking")
			end	

			if f_technologies["military-2"].researched == true then
				f_recipes["military-science-pack"].enabled = true
				if old_science then
					f_recipes["military-science-pack"].enabled = true
				end				
				f_print("military-2 researched for this force: military-science-pack recipe auto-unlocked")
			else
				f_print("military-2 not researched: military-science-pack recipe not auto-unlocking")
			end
			
			if f_technologies["advanced-electronics"].researched == true then
				f_recipes["chemical-science-pack"].enabled = true
				if old_science then
					f_recipes["chemical-science-pack"].enabled = true
				end				
				f_print("advanced-electronics researched for this force: chemical-science-pack recipe auto-unlocked")
			else
				f_print("advanced-electronics not researched: chemical-science-pack recipe not auto-unlocking")
			end
			
			if f_technologies["nuclear-power"].researched == true then
				f_recipes["centrifuge"].enabled = true
				f_recipes["uranium-processing"].enabled = true
				f_print("nuclear-power researched for this force: centrifuge & uranium-processing recipes auto-unlocked")
			else
				f_print("nuclear-power not researched: recipes not auto-unlocking")
			end
			
			if f_technologies["advanced-electronics-2"].researched == true then
				f_recipes["rocket-control-unit"].enabled = true
				f_recipes["low-density-structure"].enabled = true
				f_recipes["utility-science-pack"].enabled = true
				if old_science then
					if not game.active_mods["bobrevamp"] then
						f_recipes["low-density-structure"].enabled = true
					end
					f_recipes["utility-science-pack"].enabled = true
				end
				f_print("advanced-electronics-2 researched for this force: utility-science-pack & low-density-structure & rocket-control-unit recipes auto-unlocked")
			else
				f_print("advanced-electronics-2 not researched: recipes not auto-unlocking")
			end
			
			if f_technologies["advanced-material-processing-2"].researched == true then
				if not game.active_mods["angelspetrochem"] then
					f_recipes["rocket-fuel"].enabled = true
				end
				f_recipes["production-science-pack"].enabled = true
				if old_science then
					f_recipes["production-science-pack"].enabled = true
				end
				f_print("advanced-material-processing-2 researched for this force: rocket-fuel & production-science-pack recipes auto-unlocked")
			else
				f_print("advanced-material-processing-2 not researched: recipes not auto-unlocking")
			end
			
			if get_input_count("fast-inserter") > 0 or get_input_count("filter-inserter") > 0 then
				f_recipes["fast-inserter"].enabled = true
				f_recipes["filter-inserter"].enabled = true
				f_technologies["fast-inserter"].researched = true
				f_print("force: " .. force.name .. " | fast-inserter recipe unlocked | total fast-inserter produced by force: " .. get_input_count("centrifuge"))
			else
				f_recipes["fast-inserter"].enabled = false
				f_recipes["filter-inserter"].enabled = false
				f_technologies["fast-inserter"].researched = false
				f_print("No fast-inserter produced by this force: technology won't be auto-researched.")
			end

			if f_technologies["steel-processing"].researched == true then
				f_technologies["steel-axe"].researched = true
				f_print("force: " .. force.name .. " | steel-axe unlocked | steel-processing researched")
			else
				f_print("steel-processing not researched by this force: steel-axe won't be unlocked")
			end
		end
	end
	if settings.startup["017-rocket-victory"].value and settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do 
			local get_input_count = force.item_production_statistics.get_input_count
			if (get_input_count("satellite") > 0) or (get_input_count("space-science-pack") > 0) then
				force.recipes["satellite"].enabled = true
				force.technologies["space-science-pack"].researched = true
				force.print("force: " .. force.name .. " | satellite recipe unlocked | total produced by force: " .. get_input_count("satellite"))
			else
				force.recipes["satellite"].enabled = false
				force.technologies["space-science-pack"].researched = false
				force.print("No space science OR satellites produced by this force: technology won't be auto-researched.")
			end
		end
	end
	if settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do
			local f_recipes = force.recipes
			local f_technologies = force.technologies
			local f_print = force.print
			local get_input_count = force.item_production_statistics.get_input_count
			local get_fluid_input_count = force.fluid_production_statistics.get_input_count
			
			f_print("0.17 techtree enabled.")

			if get_input_count("logistic-science-pack") > 0 then
				f_recipes["logistic-science-pack"].enabled = true
				f_technologies["logistic-science-pack"].researched = true
				f_print("force: " .. force.name .. " | logistic-science-pack recipe unlocked | total produced by force: " .. get_input_count("logistic-science-pack"))
			else
				f_recipes["logistic-science-pack"].enabled = false
				f_technologies["logistic-science-pack"].researched = false
				f_print("No logistics science produced by this force: technology won't be auto-researched.")
			end

			if get_input_count("military-science-pack") > 0 then
				f_recipes["military-science-pack"].enabled = true
				f_technologies["military-science-pack"].researched = true
				f_print("force: " .. force.name .. " | military-science-pack recipe unlocked | total produced by force: " .. get_input_count("military-science-pack"))
			else
				f_recipes["military-science-pack"].enabled = false
				f_technologies["military-science-pack"].researched = false
				f_print("No military science produced by this force: technology won't be auto-researched.")
			end

			if get_input_count("chemical-science-pack") > 0 then
				f_recipes["chemical-science-pack"].enabled = true
				f_technologies["chemical-science-pack"].researched = true
				f_print("force: " .. force.name .. " | chemical-science-pack recipe unlocked | total produced by force: " .. get_input_count("chemical-science-pack"))
			else
				f_recipes["chemical-science-pack"].enabled = false
				f_technologies["chemical-science-pack"].researched = false
				f_print("No chemical science produced by this force: technology won't be auto-researched.")
			end

			if get_input_count("production-science-pack") > 0 then
				f_recipes["production-science-pack"].enabled = true
				f_technologies["production-science-pack"].researched = true
				f_print("force: " .. force.name .. " | production-science-pack recipe unlocked | total produced by force: " .. get_input_count("production-science-pack"))
			else
				f_recipes["production-science-pack"].enabled = false
				f_technologies["production-science-pack"].researched = false
				f_print("No production science produced by this force: technology won't be auto-researched.")				
			end

			if get_input_count("utility-science-pack") > 0 then
				f_recipes["utility-science-pack"].enabled = true
				f_technologies["utility-science-pack"].researched = true
				f_print("force: " .. force.name .. " | high-tech-science-pack recipe unlocked | total produced by force: " .. get_input_count("utility-science-pack"))
			else
				f_recipes["utility-science-pack"].enabled = false
				f_technologies["utility-science-pack"].researched = false
				f_print("No utility science produced by this force: technology won't be auto-researched.")
			end			

		

			if get_fluid_input_count("lubricant") > 0 then
				f_recipes["lubricant"].enabled = true
				f_technologies["lubricant"].researched = true
				f_print("force: " .. force.name .. " | lubricant recipe unlocked | total produced by force: " .. get_fluid_input_count("lubricant"))
			else
				f_recipes["lubricant"].enabled = false
				f_technologies["lubricant"].researched = false
				f_print("No lubricant produced by this force: technology won't be auto-researched.")
			end

			if not game.active_mods["angelspetrochem"] then
				if get_input_count("rocket-fuel") > 0 then
					f_recipes["rocket-fuel"].enabled = true
					f_technologies["rocket-fuel"].researched = true
					f_print("force: " .. force.name .. " | rocket-fuel recipe unlocked | total produced by force: " .. get_input_count("rocket-fuel"))
				else
					f_recipes["rocket-fuel"].enabled = false
					f_technologies["rocket-fuel"].researched = false
					f_print("No rocket-fuel produced by this force: technology won't be auto-researched.")
				end
			elseif game.active_mods["angelspetrochem"] then
				if get_input_count("rocket-fuel") > 0 then
					f_technologies["angels-rocket-fuel"].researched = true
					f_recipes["rocket-oxidizer-capsule"].enabled = true
					f_recipes["rocket-fuel-capsule"].enabled = true
					f_recipes["rocket-fuel"].enabled = true
					f_print("force: " .. force.name .. " | rocket-fuel recipe unlocked | total produced by force: " .. get_input_count("rocket-fuel"))
				else
					f_technologies["angels-rocket-fuel"].researched = false
					f_recipes["rocket-oxidizer-capsule"].enabled = false
					f_recipes["rocket-fuel-capsule"].enabled = false
					f_recipes["rocket-fuel"].enabled = false
					f_print("No rocket-fuel produced by this force: technology won't be auto-researched.")
				end
			end
			
			if not game.active_mods["bobrevamp"] then
				if get_input_count("low-density-structure") > 0 then
					f_recipes["low-density-structure"].enabled = true
					f_technologies["low-density-structure"].researched = true
					f_print("force: " .. force.name .. " | low-density-structure recipe unlocked | total produced by force: " .. get_input_count("low-density-structure"))
				else
					f_recipes["low-density-structure"].enabled = false
					f_technologies["low-density-structure"].researched = false
					f_print("No low-density-structure produced by this force: technology won't be auto-researched.")
				end
			elseif game.active_mods["bobrevamp"] then
				if get_input_count("low-density-structure") > 0 then
					f_recipes["low-density-structure"].enabled = true
					f_technologies["low-density-structure"].researched = true
					f_print("force: " .. force.name .. " | low-density-structure recipe unlocked | total produced by force: " .. get_input_count("low-density-structure"))
				else
					f_recipes["low-density-structure"].enabled = false
					f_technologies["low-density-structure"].researched = false
					f_print("No low-density-structure produced by this force: technology won't be auto-researched.")
				end
			end

			if get_input_count("rocket-control-unit") > 0 then
				f_recipes["rocket-control-unit"].enabled = true
				f_technologies["rocket-control-unit"].researched = true
				f_print("force: " .. force.name .. " | rocket-control-unit recipe unlocked | total produced by force: " .. get_input_count("rocket-control-unit"))
			else
				f_recipes["rocket-control-unit"].enabled = false
				f_technologies["rocket-control-unit"].researched = false
				f_print("No rocket-control-unit produced by this force: technology won't be auto-researched.")
			end

			if get_input_count("centrifuge") > 0 or f_technologies["nuclear-power"].researched == true then
				f_recipes["centrifuge"].enabled = true
				f_recipes["uranium-processing"].enabled = true
				f_technologies["uranium-processing"].researched = true
				f_print("force: " .. force.name .. " | uranium-enrichment recipe unlocked | total centrifuges produced by force: " .. get_input_count("centrifuge"))
			else
				f_recipes["centrifuge"].enabled = false
				f_recipes["uranium-processing"].enabled = false
				f_technologies["uranium-processing"].researched = false
				f_print("No centrifuges produced by this force AND nuclear-power not researched: technology won't be auto-researched.")
			end
			
			if get_input_count("fast-inserter") > 0 or get_input_count("filter-inserter") > 0 then
				f_recipes["fast-inserter"].enabled = true
				f_recipes["filter-inserter"].enabled = true
				f_technologies["fast-inserter"].researched = true
				f_print("force: " .. force.name .. " | fast-inserter recipe unlocked | total fast-inserter produced by force: " .. get_input_count("fast-inserter"))
			else
				f_recipes["fast-inserter"].enabled = false
				f_recipes["filter-inserter"].enabled = false
				f_technologies["fast-inserter"].researched = false
				f_print("No fast-inserter produced by this force: technology won't be auto-researched.")
			end

			if f_technologies["steel-processing"].researched == true then
				f_technologies["steel-axe"].researched = true
				f_print("force: " .. force.name .. " | steel-axe unlocked | steel-processing researched")
			else
				f_print("steel-processing not researched by this force: steel-axe won't be unlocked")
			end
		end
	end
	for i, force in pairs(game.forces) do 
		force.reset_recipes()
	end
	for i, force in pairs(game.forces) do 
		force.reset_technologies()
	end
	global.axe_techs = nil
	game.print("!==================!")
	game.print("IMPORTANT WARNING!")
	game.print("DO NOT SAVE THIS WORLD OVER THE PRE-MIGRATION SAVE!")
	game.print("SAVE THIS GAME AS A NEW SAVE AND LEAVE THE OLD SAVE AS A BACKUP.")
end)