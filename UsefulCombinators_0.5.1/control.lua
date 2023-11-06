local data = {}
local classes = {}
local selected = {}
function save()
	global["uc_data"] = data
end

for _,name in pairs(require("combinators.list")) do
	classes[name] = require("combinators." .. name)
end

function get_count(control, signal)
	if not signal then return 0 end
	local red = control.get_circuit_network(defines.wire_type.red)
	local green = control.get_circuit_network(defines.wire_type.green)
	local val = 0
	if red then
		val = red.get_signal(signal) or 0
	end
	if green then 
		val = val + (green.get_signal(signal) or 0)
	end
	return val
end

function get_signals(control)
	local red = control.get_circuit_network(defines.wire_type.red)
	local green = control.get_circuit_network(defines.wire_type.green)
	local network = {}
	if red and red.signals then
		for _,v in pairs(red.signals) do
			if v.signal.name then
				network[v.signal.name] = v
			end
		end
	end
	if green and green.signals then
		for _,v in pairs(green.signals) do
			if v.signal.name then
				network[v.signal.name] = v
			end
		end
	end
	return network
end

function entity_built(event)
	if classes[event.created_entity.name] ~= nil then
		local tab = data[event.created_entity.name] or {}
		table.insert(tab, classes[event.created_entity.name].on_place(event.created_entity, event.stack))
		data[event.created_entity.name] = tab
		save()
	end
end

function pre_entity_removed(event)
	if classes[event.entity.name] ~= nil then
		for k,v in ipairs(data[event.entity.name]) do
			if v.meta.entity == event.entity then
				local tab = data[event.entity.name]
				table.remove(tab, k)
				classes[event.entity.name].on_destroy(v, event.buffer[1])
				data[event.entity.name] = tab
				for i,j in pairs(selected) do
					if j.entity == v.meta.entity then
						j.player.gui.center["uc"].destroy()
						table.remove(selected, i)
					end
				end
				save()
				break
			end
		end
	end
end

function tick()
	for k,v in pairs(classes) do
		if data ~= nil and data[k] ~= nil then
			for q,i in pairs(data[k]) do
				if i.meta and i.meta.entity.valid then
					v.on_tick(i, q)
				end
			end
		end
	end
end

function uc_load()
	data = global["uc_data"] or {}
end

function init()
	data = global["uc_data"] or {}
	for k,v in pairs(classes) do
		data[k] = data[k] or {}
	end
end

function configuration_changed(cfg)
	if cfg.mod_changes then
		local changes = cfg.mod_changes["UsefulCombinators"]
		if changes then
			init()
			if global["uc_data"] then
				for k,v in pairs(classes) do
					local tab = {}
					for _,s in pairs(game.surfaces) do
						for i,j in pairs(s.find_entities_filtered({name = k})) do
							table.insert(tab, classes[k].on_place(j))
							data[k] = tab
						end
					end
					save()
				end
			end
		end
	end 
end

function on_key(event)
	local player = game.players[event.player_index]
	local entity = player.selected
	if entity and player.can_reach_entity(entity) then
		for k,v in pairs(classes) do
			if data ~= nil and data[k] ~= nil then
				if entity.name == k then
					for h,i in pairs(data[k]) do
						if i.meta.entity.valid then
							if i.meta.entity == entity then
								if not (player.gui.center["uc"]) and not player.cursor_stack.valid_for_read then
									table.insert(selected, { player = player, entity = entity})
									if entity.operable then
                    entity.operable = false
                  end
									v.on_key(player, i)
									break
								end
							end
						end
					end
				end
			end
		end
	end
end

function on_click_ok(event)
	local player = game.players[event.player_index]
	local element = event.element
	if element.name and element.name == "uc-exit" then
		for k,v in pairs(classes) do
			if data and data[k] then
				for h,i in pairs(data[k]) do
					for l,m in pairs(selected) do
						if i.meta.entity == m.entity then
							v.on_click(player, i)
							table.remove(selected, l)
							if not i.meta.entity.operable then
								i.meta.entity.operable = true
							end
							break
						end
					end
				end
			end
		end
		player.gui.center["uc"].destroy()
	end
end

script.on_init(init)
script.on_load(uc_load)
script.on_event(defines.events.on_built_entity, entity_built)
script.on_event(defines.events.on_robot_built_entity, entity_built)
script.on_event(defines.events.on_player_mined_entity, pre_entity_removed)
script.on_event(defines.events.on_robot_mined_entity, pre_entity_removed)
script.on_event(defines.events.on_entity_died, entity_removed)
script.on_event(defines.events.on_tick, tick)
script.on_event(defines.events.on_gui_click, on_click_ok)
script.on_event("uc-edit", on_key)
script.on_configuration_changed(configuration_changed)