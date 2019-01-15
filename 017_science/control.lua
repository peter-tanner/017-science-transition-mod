
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
		if game.active_mods["SpaceMod"] then
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
	if settings.startup["017-rocket-victory"].value and not settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do
			if force.technologies["rocket-silo"].researched == true then
				force.recipes["satellite"].enabled = true
			end
		end
	end
	if settings.startup["017-rocket-victory"].value and settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do 
			local get_input_count = force.item_production_statistics.get_input_count
			if get_input_count("space-science-pack") > 0 then
				force.recipes["satellite"].enabled = true
				force.technologies["space-science-pack"].researched = true
				force.print("force: " .. force.name .. " | space-science-pack tech unlocked | total produced for force: " .. get_input_count("space-science-pack"))
			else
				force.recipes["satellite"].enabled = false
				force.technologies["space-science-pack"].researched = false
				force.print("No space science produced by this force: keeping technology locked.")
			end
		end
	end
	if settings.startup["017-techtree"].value then
		for i, force in pairs(game.forces) do
			local get_input_count = force.item_production_statistics.get_input_count
			if get_input_count("science-pack-2") > 0 then
				force.recipes["science-pack-2"].enabled = true
				force.technologies["logistics-science-pack"].researched = true
				force.print("force: " .. force.name .. " | logistics-science-pack tech unlocked | total produced for force: " .. get_input_count("science-pack-2"))
			else
				force.recipes["science-pack-2"].enabled = false
				force.technologies["logistics-science-pack"].researched = false
				force.print("No logistics science produced by this force: keeping technology locked.")
			end
			
			if get_input_count("science-pack-3") > 0 then
				force.recipes["science-pack-3"].enabled = true
				force.recipes["17-chemical-science-pack"].enabled = true
				force.technologies["chemical-science-pack"].researched = true
				force.print("force: " .. force.name .. " | chemical-science-pack tech unlocked | total produced for force: " .. get_input_count("science-pack-3"))
			else
				force.recipes["science-pack-3"].enabled = false
				force.recipes["17-chemical-science-pack"].enabled = false
				force.technologies["chemical-science-pack"].researched = false
				force.print("No chemical science produced by this force: keeping technology locked.")
			end
			
			if get_input_count("production-science-pack") > 0 then
				force.recipes["production-science-pack"].enabled = true
				force.recipes["17-production-science-pack"].enabled = true
				force.technologies["production-science-pack"].researched = true
				force.print("force: " .. force.name .. " | production-science-pack tech unlocked | total produced for force: " .. get_input_count("production-science-pack"))
			else
				force.recipes["production-science-pack"].enabled = false
				force.recipes["17-production-science-pack"].enabled = false
				force.technologies["production-science-pack"].researched = false
				force.print("No production science produced by this force: keeping technology locked.")				
			end
			
			if get_input_count("high-tech-science-pack") > 0 then
				force.recipes["high-tech-science-pack"].enabled = true
				force.recipes["17-utility-science-pack"].enabled = true
				force.technologies["utility-science-pack"].researched = true
				force.print("force: " .. force.name .. " | high-tech-science-pack tech unlocked | total produced for force: " .. get_input_count("high-tech-science-pack"))
			else
				force.recipes["high-tech-science-pack"].enabled = false
				force.recipes["17-utility-science-pack"].enabled = false
				force.technologies["utility-science-pack"].researched = false
				force.print("No utility science produced by this force: keeping technology locked.")
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