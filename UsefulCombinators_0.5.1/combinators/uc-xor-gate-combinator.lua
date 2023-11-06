return {
	on_click = function(player, object)
		local gui = player.gui.center.uc["uc-xor-gate-combinator"]
		local params = object.meta.params
		if gui["signal_a"].elem_value and gui["signal_a"].elem_value.name then
			params[1] = {signal = gui["signal_a"].elem_value}
		else
			params[1] = {signal = {type = "virtual"}}
		end
		if gui["signal_b"].elem_value and gui["signal_b"].elem_value.name then
			params[2] = {signal = gui["signal_b"].elem_value}
		else
			params[2] = {signal = {type = "virtual"}}
		end
		if gui["signal_c"].elem_value and gui["signal_c"].elem_value.name then
			params[3] = {signal = gui["signal_c"].elem_value}
		else
			params[3] = {signal = {type = "virtual"}}
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local params = object.meta.params
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "XOR Gate Combinator"}
			local layout = uc.add{type = "table", name = "uc-xor-gate-combinator", column_count = 5}
			if params[1].signal and params[1].signal.name then
				layout.add{type = "choose-elem-button", name = "signal_a", elem_type = "signal", signal = params[1].signal}
			else
				layout.add{type = "choose-elem-button", name = "signal_a", elem_type = "signal"}
			end
			layout.add{type = "label", caption = "XOR"}
			if params[2].signal and params[2].signal.name then
				layout.add{type = "choose-elem-button", name = "signal_b", elem_type = "signal", signal = params[2].signal}
			else
				layout.add{type = "choose-elem-button", name = "signal_b", elem_type = "signal"}
			end
			layout.add{type = "label", caption = " = "}
			if params[3].signal and params[3].signal.name then
				layout.add{type = "choose-elem-button", name = "signal_c", elem_type = "signal", signal = params[3].signal}
			else
				layout.add{type = "choose-elem-button", name = "signal_c", elem_type = "signal"}
			end
			layout.add{type = "button", name = "uc-exit", caption = "Ok"}
		end
	end,
	on_place = function(entity, item)
		if item ~= nil and item.get_tag("uc_meta") ~= nil then
			local tag = item.get_tag("uc_meta")
			tag.meta.entity = entity
			return { meta = tag.meta }
		end
		return {
			meta = {
				entity = entity,
				params = {
					{signal = {type = "virtual"}},
					{signal = {type = "virtual"}},
					{signal = {type = "virtual", name = "uc-output-signal"}}
				}
			}
		}
	end,
	on_destroy = function(meta, item)
		item.set_tag("uc_meta", meta)
	end,
	on_tick = function(object)
		local control = object.meta.entity.get_or_create_control_behavior()
		if control then
			local params = object.meta.params
			if params[3].signal then
				if control.enabled then
					local slots = {}
					local c1,c2 = 0,0
					if params[1].signal.name then
						c1 = get_count(control, params[1].signal)
					end
					if params[2].signal.name then
						c2 = get_count(control, params[2].signal)
					end
					if params[3].signal.name then
						if (c1 == c2) then
							table.insert(slots, {signal = params[3].signal, count = 0, index = 1})
						else
							table.insert(slots, {signal = params[3].signal, count = 1, index = 1})
						end
					end
					control.parameters = slots
				end
			else
				control.parameters = {
					{signal = {type = "virtual", name = "uc-output-signal"}, count = 0, index = 1}
				}
			end
		end
	end
}