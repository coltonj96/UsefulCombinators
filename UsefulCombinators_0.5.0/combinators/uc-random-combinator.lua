return {
	on_click = function(player, object)
		local params = object.meta.params
		local gui = player.gui.center.uc["uc-random-combinator"]
		if gui["signal1"].elem_value and gui["signal1"].elem_value.name then
			object.meta.params[1] = {signal = gui["signal1"].elem_value}
		else
			object.meta.params[1] = {signal = {type = "virtual"}}
		end
		if gui["signal2"].elem_value and gui["signal2"].elem_value.name then
			object.meta.params[2] = {signal = gui["signal2"].elem_value}
		else
			object.meta.params[2] = {signal = {type = "virtual"}}
		end
		object.meta.range.minimum = tonumber(gui["lower"].text) or object.meta.range.minimum
		object.meta.range.maximum = tonumber(gui["upper"].text) or object.meta.range.maximum
		object.meta.ticks = tonumber(gui["ticks"].text) or object.meta.ticks
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local params = object.meta.params
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Random Combinator"}
			local layout = uc.add{type = "table", name = "uc-random-combinator", column_count = 2}
			layout.add{type = "label", caption = "Trigger: (?)", tooltip = {"uc-random-combinator.trigger"}}
			if params[1].signal and params[1].signal.name then
				layout.add{type = "choose-elem-button", name = "signal1", elem_type = "signal", signal = params[1].signal}
			else
				layout.add{type = "choose-elem-button", name = "signal1", elem_type = "signal"}
			end
			layout.add{type = "label", caption = "Output: (?)", tooltip = {"uc-random-combinator.output"}}
			if params[2].signal and params[2].signal.name then
				layout.add{type = "choose-elem-button", name = "signal2", elem_type = "signal", signal = params[2].signal}
			else
				layout.add{type = "choose-elem-button", name = "signal2", elem_type = "signal"}
			end
			layout.add{type = "label", caption = "Lower Limit: (?)", tooltip = {"uc-random-combinator.lower"}}
			layout.add{type = "textfield", name = "lower", style = "uc_text", text = object.meta.range.minimum}
			layout.add{type = "label", caption = "Upper	Limit: (?)", tooltip = {"uc-random-combinator.upper"}}
			layout.add{type = "textfield", name = "upper", style = "uc_text", text = object.meta.range.maximum}
			layout.add{type = "label", caption = "Ticks: (?)", tooltip = {"uc-random-combinator.ticks"}}
			layout.add{type = "textfield", name = "ticks", style = "uc_text", text = object.meta.ticks}
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
					{signal = {type = "virtual", name = "uc-input-signal"}},
					{signal = {type = "virtual", name = "uc-output-signal"}, count = 0},
				},
				range = {
					minimum = 1,
					maximum = 10
				},
				ticks = 60
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
			if params[1].signal and params[1].signal.name then
				if control.enabled then
					if object.meta.range.minimum < 1 then object.meta.range.minimum = 1 end
					if object.meta.range.maximum <= object.meta.range.minimum then object.meta.range.maximum = object.meta.range.minimum + 1 end
					if object.meta.ticks < 1 then object.meta.ticks = 1 end
					if object.meta.ticks > 180 then object.meta.ticks = 180 end
					local count = control.parameters.parameters[1].count or 0
					if get_count(control, params[1].signal) >= 1 then
						count = math.random(object.meta.range.minimum,object.meta.range.maximum)
					end
					if (game.tick % object.meta.ticks) == 0 then
						control.parameters = {
							{signal = params[2].signal, count = count, index = 1}
						}
					end
				end
			else
				control.parameters = {
					{signal = {type = "virtual", name = "uc-output-signal"}, count = 0, index = 1}
				}
			end
		end
	end
}