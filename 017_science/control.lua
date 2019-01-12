
if settings.startup["017-axe"].value then
	local function generate_axes()
		-- game.print("gen_ax")
		global.axe_techs = {}
		for _, axe in pairs(game.item_prototypes) do
			if axe.attack_range then
				global.axe_techs[#global.axe_techs+1] = {axe.name,axe.speed}
			end
		end
	end

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

	script.on_init(function()
			global.axe_techs = {}
			generate_axes()
	end)

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
