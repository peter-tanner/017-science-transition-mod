
local function disable_silo_script()
	if remote.interfaces["silo_script"] then
		remote.call("silo_script","set_finish_on_launch", false)
		remote.call("silo_script","set_show_launched_without_satellite", false)
	end
end
local function generate_axes()
	-- game.print("gen_ax")
	global.axe_techs = {}
	for _, axe in pairs(game.item_prototypes) do
		if axe.attack_range then
			global.axe_techs[#global.axe_techs+1] = {axe.name,axe.speed}
		end
	end
end

if settings.startup["017-axe"].value then
	local function ax_gen()
		if global.axe_techs == nil then
			generate_axes()
		else
			-- game.print("ax_gen")
			for f, force in pairs(game.forces) do
				for _, technology in pairs(force.technologies) do
					local name = force.name
					if highest_speed == nil then
						highest_speed = {}
					end
					if highest_speed[name] == nil then
						highest_speed[name] = {"iron-axe",2.5}
					end
					if technology.researched then
						for _=1, #global.axe_techs do
							for i=1, #technology.effects do
								if technology.effects[i].recipe == global.axe_techs[_][1] then
									if highest_speed[name][2] < global.axe_techs[_][2] then
										highest_speed[name] = global.axe_techs[_]
									end
								end
							end
						end
					end
				end
			end
		end
	end	

	local function give_ax(event)
		local player = game.players[event.player_index]
		-- game.print("give_ax")
		if highest_speed == nil then
			ax_gen()
		end
		if highest_speed[player.force.name] == nil then
			ax_gen()
		else
			axe_name = highest_speed[player.force.name][1]
			for _=1, #global.axe_techs do
				local item = global.axe_techs[_][1]
				if item ~= axe_name then
					player.remove_item(item)
				end
			end
			if axe_name == nil then
				player.insert{name="iron-axe", count = 1}
			else
				player.insert{name=axe_name, count = 1}
			end
		end
	end

	local function ax_research(event)
		local technology = event.research
		ax_gen()
		for _, player in pairs(technology.force.players) do
			event.player_index = player.index
			for _=1, #global.axe_techs do
				player.remove_item(global.axe_techs[_][1])
			end
			give_ax(event)
		end
	end

	-- init_game
	-- script.on_configuration_changed(function() configuration_changed = 1 game.print("changed") end)

	-- script.on_event(defines.events.on_player_created, generate_axes)
	script.on_event(defines.events.on_player_created, function(event) give_ax(event) end)
	script.on_event(defines.events.on_force_created, function(event) ax_gen(event) end)
	script.on_event(defines.events.on_forces_merged, function(event) ax_gen(event) end)

	script.on_configuration_changed(function(event)
			generate_axes()
			ax_gen()
	end)

	-- game
	script.on_event(defines.events.on_research_finished, ax_gen)
	script.on_event(defines.events.on_research_finished, ax_research)

	script.on_event(defines.events.on_player_tool_inventory_changed, give_ax)
	-- script.on_event(defines.events.on_player_trash_inventory_changed, give_ax)
	-- script.on_event(defines.events.on_player_main_inventory_changed, give_ax)
	script.on_event(defines.events.on_player_main_inventory_changed, function(event) game.players[event.player_index].remove_item("017-mine") end)
	script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
		local player = game.players[event.player_index]
		if player.cursor_stack.valid_for_read then
			-- game.print(axe)
			-- game.print(player.cursor_stack.name)
			if highest_speed == nil then
				ax_gen()
			else
				if player.cursor_stack.name == highest_speed[player.force.name][1] then 
					player.clean_cursor()
				end
			end
		end
	end)

	script.on_event(defines.events.on_player_dropped_item, function(event)
		for _=1, #global.axe_techs do
			if event.entity.valid then
				if event.entity.stack.name == global.axe_techs[_][1] then
					give_ax(event)
					event.entity.destroy()
				end
			end
		end
	end)

	script.on_event(defines.events.on_player_crafted_item, function(event)
		if event.item_stack.name == "017-mine" then
			give_ax(event)
			game.players[event.player_index].print("Updated mining tool!")
		end
	end)
	--debug
	-- commands.add_command("axe_techs", "debug: regenerate list of axes", function(command)
		-- generate_axes()
		-- for _=1, #global.axe_techs do game.player.print(global.axe_techs[_][1] .. " | " .. global.axe_techs[_][2]) end
	-- end)

	-- commands.add_command("list_axes", "debug: list all valid axes", function(command)
		-- if global.axe_techs == nil then
			-- game.player.print("ERROR: not generated")
		-- else
			-- for _=1, #global.axe_techs do
				-- game.player.print(global.axe_techs[_][1] .. " | " .. global.axe_techs[_][2])
			-- end
			-- for _, h in pairs(highest_speed) do
				-- game.player.print("highest speed: " .. h[1] .. " | " .. h[2] .. " (force" .. _ .. ")")
			-- end
		-- end
	-- end)
	
end

if settings.startup["017-rocket-victory"].value then
	script.on_event(defines.events.on_rocket_launched, function(event)
		if game.active_game.active_mods["SpaceMod"] then
		--	game.print("SpaceMod installed: not enabling victory")
		else
			game.set_game_state{game_finished = true, player_won = true, can_continue = true}
		end
	end)
end


local function initialize()
	if settings.startup["017-axe"].value then
		global.axe_techs = {}
		generate_axes()
	end
	if settings.startup["017-rocket-victory"].value then
		disable_silo_script()
	end
end

script.on_configuration_changed(function()
	initialize()
	local old_science = settings.startup["017-old-science"].value
	game.print("Configuration change detected for this save. Determining technology and recipe availablilty...")
	if not settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do
			local f_recipes = force.recipes
			local f_technologies = force.technologies
			local f_print = force.print
			
			f_print("0.17 techtree disabled.")
			f_recipes["science-pack-2"].enabled = true
			
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
				f_recipes["17-military-science-pack"].enabled = true
				if old_science then
					f_recipes["military-science-pack"].enabled = true
				end				
				f_print("military-2 researched for this force: military-science-pack recipe auto-unlocked")
			else
				f_print("military-2 not researched: military-science-pack recipe not auto-unlocking")
			end
			
			if f_technologies["advanced-electronics"].researched == true then
				f_recipes["17-chemical-science-pack"].enabled = true
				if old_science then
					f_recipes["science-pack-3"].enabled = true
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
				f_recipes["17-low-density-structure"].enabled = true
				f_recipes["17-utility-science-pack"].enabled = true
				if old_science then
					if not game.active_mods["bobrevamp"] then
						f_recipes["low-density-structure"].enabled = true
					end
					f_recipes["high-tech-science-pack"].enabled = true
				end
				f_print("advanced-electronics-2 researched for this force: utility-science-pack & low-density-structure & rocket-control-unit recipes auto-unlocked")
			else
				f_print("advanced-electronics-2 not researched: recipes not auto-unlocking")
			end
			
			if f_technologies["advanced-material-processing-2"].researched == true then
				if not game.active_mods["angelspetrochem"] then
					f_recipes["rocket-fuel"].enabled = true
				end
				f_recipes["17-production-science-pack"].enabled = true
				if old_science then
					f_recipes["production-science-pack"].enabled = true
				end
				f_print("advanced-material-processing-2 researched for this force: rocket-fuel & production-science-pack recipes auto-unlocked")
			else
				f_print("advanced-material-processing-2 not researched: recipes not auto-unlocking")
			end
		end
	end
	if settings.startup["017-rocket-victory"].value and settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do 
			local get_input_count = force.item_production_statistics.get_input_count
			if not force.technologies["space-science-pack"].researched == true then		
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
	end
	if settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do
			local f_recipes = force.recipes
			local f_technologies = force.technologies
			local f_print = force.print
			local get_input_count = force.item_production_statistics.get_input_count
			local get_fluid_input_count = force.fluid_production_statistics.get_input_count
			
			f_print("0.17 techtree enabled.")
			
			if not f_technologies["logistics-science-pack"].researched == true then
				if get_input_count("science-pack-2") > 0 then
					f_recipes["science-pack-2"].enabled = true
					f_technologies["logistics-science-pack"].researched = true
					f_print("force: " .. force.name .. " | logistics-science-pack recipe unlocked | total produced by force: " .. get_input_count("science-pack-2"))
				else
					f_recipes["science-pack-2"].enabled = false
					f_technologies["logistics-science-pack"].researched = false
					f_print("No logistics science produced by this force: technology won't be auto-researched.")
				end
			end			
			
			if not f_technologies["military-science-pack"].researched == true then
				if get_input_count("military-science-pack") > 0 then
					f_recipes["military-science-pack"].enabled = true
					f_recipes["17-military-science-pack"].enabled = true
					f_technologies["military-science-pack"].researched = true
					f_print("force: " .. force.name .. " | military-science-pack recipe unlocked | total produced by force: " .. get_input_count("military-science-pack"))
				else
					f_recipes["military-science-pack"].enabled = false
					f_recipes["17-military-science-pack"].enabled = false
					f_technologies["military-science-pack"].researched = false
					f_print("No military science produced by this force: technology won't be auto-researched.")
				end
			end
			
			if not f_technologies["chemical-science-pack"].researched == true then
				if get_input_count("science-pack-3") > 0 then
					f_recipes["science-pack-3"].enabled = true
					f_recipes["17-chemical-science-pack"].enabled = true
					f_technologies["chemical-science-pack"].researched = true
					f_print("force: " .. force.name .. " | chemical-science-pack recipe unlocked | total produced by force: " .. get_input_count("science-pack-3"))
				else
					f_recipes["science-pack-3"].enabled = false
					f_recipes["17-chemical-science-pack"].enabled = false
					f_technologies["chemical-science-pack"].researched = false
					f_print("No chemical science produced by this force: technology won't be auto-researched.")
				end
			end
			
			if not f_technologies["production-science-pack"].researched == true then
				if get_input_count("production-science-pack") > 0 then
					f_recipes["production-science-pack"].enabled = true
					f_recipes["17-production-science-pack"].enabled = true
					f_technologies["production-science-pack"].researched = true
					f_print("force: " .. force.name .. " | production-science-pack recipe unlocked | total produced by force: " .. get_input_count("production-science-pack"))
				else
					f_recipes["production-science-pack"].enabled = false
					f_recipes["17-production-science-pack"].enabled = false
					f_technologies["production-science-pack"].researched = false
					f_print("No production science produced by this force: technology won't be auto-researched.")				
				end
			end
			
			if not f_technologies["utility-science-pack"].researched == true then
				if get_input_count("high-tech-science-pack") > 0 then
					f_recipes["high-tech-science-pack"].enabled = true
					f_recipes["17-utility-science-pack"].enabled = true
					f_technologies["utility-science-pack"].researched = true
					f_print("force: " .. force.name .. " | high-tech-science-pack recipe unlocked | total produced by force: " .. get_input_count("high-tech-science-pack"))
				else
					f_recipes["high-tech-science-pack"].enabled = false
					f_recipes["17-utility-science-pack"].enabled = false
					f_technologies["utility-science-pack"].researched = false
					f_print("No utility science produced by this force: technology won't be auto-researched.")
				end			
			end			
			
			if not f_technologies["lubricant"].researched == true then
				if get_fluid_input_count("lubricant") > 0 then
					f_recipes["lubricant"].enabled = true
					f_technologies["lubricant"].researched = true
					f_print("force: " .. force.name .. " | lubricant recipe unlocked | total produced by force: " .. get_fluid_input_count("lubricant"))
				else
					f_recipes["lubricant"].enabled = false
					f_technologies["lubricant"].researched = false
					f_print("No lubricant produced by this force: technology won't be auto-researched.")
				end			
			end	

			if not f_technologies["rocket-fuel"].researched == true and not game.active_mods["angelspetrochem"] then
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
			
			if not f_technologies["low-density-structure"].researched == true and not game.active_mods["bobrevamp"] then
				if get_input_count("low-density-structure") > 0 then
					f_recipes["low-density-structure"].enabled = true
					f_recipes["17-low-density-structure"].enabled = true
					f_technologies["low-density-structure"].researched = true
					f_print("force: " .. force.name .. " | low-density-structure recipe unlocked | total produced by force: " .. get_input_count("low-density-structure"))
				else
					f_recipes["low-density-structure"].enabled = false
					f_recipes["17-low-density-structure"].enabled = false
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
			
			if not f_technologies["rocket-control-unit"].researched == true then
				if get_input_count("rocket-control-unit") > 0 then
					f_recipes["rocket-control-unit"].enabled = true
					f_technologies["rocket-control-unit"].researched = true
					f_print("force: " .. force.name .. " | rocket-control-unit recipe unlocked | total produced by force: " .. get_input_count("rocket-control-unit"))
				else
					f_recipes["rocket-control-unit"].enabled = false
					f_technologies["rocket-control-unit"].researched = false
					f_print("No rocket-control-unit produced by this force: technology won't be auto-researched.")
				end
			end
			
			if not f_technologies["uranium-enrichment"].researched == true then
				if get_input_count("centrifuge") > 0 or f_technologies["nuclear-power"].researched == true then
					f_recipes["centrifuge"].enabled = true
					f_recipes["uranium-processing"].enabled = true
					f_technologies["uranium-enrichment"].researched = true
					f_print("force: " .. force.name .. " | uranium-enrichment recipe unlocked | total centrifuges produced by force: " .. get_input_count("centrifuge"))
				else
					f_recipes["centrifuge"].enabled = false
					f_recipes["uranium-processing"].enabled = false
					f_technologies["uranium-enrichment"].researched = false
					f_print("No centrifuges produced by this force AND nuclear-power not researched: technology won't be auto-researched.")
				end
			end
		end
	end
	for i, force in pairs(game.forces) do 
		force.reset_recipes()
	end
	for i, force in pairs(game.forces) do 
		force.reset_technologies()
	end
end)
script.on_init(initialize)