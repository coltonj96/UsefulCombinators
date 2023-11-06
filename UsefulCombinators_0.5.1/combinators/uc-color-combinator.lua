return {
	on_click = function(player, object)
		local gui = player.gui.center
		for i = 1,6 do
			if gui["uc"]["uc-color-combinator"]["signal"..i].elem_value and gui["uc"]["uc-color-combinator"]["signal"..i].elem_value.name then
				object.meta.params[i] = {signal = gui["uc"]["uc-color-combinator"]["signal"..i].elem_value, count = tonumber(gui["uc"]["uc-color-combinator"]["count"..i].text) or object.meta.params[i].count}
			else
				object.meta.params[i] = {signal = {type = "virtual"}, count = 0}
			end
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local gui = player.gui.center
			local params = object.meta.params
			local uc = gui.add{type = "frame", name = "uc", caption = "Color Combinator"}
			local layout = uc.add{type = "table", name = "uc-color-combinator", column_count = 4}
			for i = 1,6 do
				if i == 1 then
					layout.add{type = "label", caption = "Red: (?)", tooltip = {"uc-color-combinator.red"}}
					if params[i].signal and params[i].signal.name then	
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
					else
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
					end
					layout.add{type = "label", caption = " = "}
					layout.add{type = "textfield", name = "count"..i, style = "uc_text", text = params[i].count or 0}
				elseif i == 2 then
					layout.add{type = "label", caption = "Green: (?)", tooltip = {"uc-color-combinator.green"}}
					if params[i].signal and params[i].signal.name then	
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
					else
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
					end
					layout.add{type = "label", caption = " = "}
					layout.add{type = "textfield", name = "count"..i, style = "uc_text", text = params[i].count or i}
				elseif i == 3 then
					layout.add{type = "label", caption = "Blue: (?)", tooltip = {"uc-color-combinator.blue"}}
					if params[i].signal and params[i].signal.name then	
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
					else
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
					end
					layout.add{type = "label", caption = " = "}
					layout.add{type = "textfield", name = "count"..i, style = "uc_text", text = params[i].count or i}
				elseif i == 4 then
					layout.add{type = "label", caption = "Yellow: (?)", tooltip = {"uc-color-combinator.yellow"}}
					if params[i].signal and params[i].signal.name then	
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
					else
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
					end
					layout.add{type = "label", caption = " = "}
					layout.add{type = "textfield", name = "count"..i, style = "uc_text", text = params[i].count or i}
				elseif i == 5 then
					layout.add{type = "label", caption = "Magenta: (?)", tooltip = {"uc-color-combinator.magenta"}}
					if params[i].signal and params[i].signal.name then	
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
					else
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
					end
					layout.add{type = "label", caption = " = "}
					layout.add{type = "textfield", name = "count"..i, style = "uc_text", text = params[i].count or i}
				elseif i == 6 then
					layout.add{type = "label", caption = "Cyan: (?)", tooltip = {"uc-color-combinator.cyan"}}
					if params[i].signal and params[i].signal.name then	
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
					else
						layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
					end
					layout.add{type = "label", caption = " = "}
					layout.add{type = "textfield", name = "count"..i, style = "uc_text", text = params[i].count or i}
				end
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
					{signal = {type = "virtual", name = "uc-red-signal"}, count = 1},
					{signal = {type = "virtual", name = "uc-green-signal"}, count = 2},
					{signal = {type = "virtual", name = "uc-blue-signal"}, count = 3},
					{signal = {type = "virtual", name = "uc-yellow-signal"}, count = 4},
					{signal = {type = "virtual", name = "uc-magenta-signal"}, count = 5},
					{signal = {type = "virtual", name = "uc-cyan-signal"}, count = 6}
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
			if control.enabled then
				local slots = {
					{signal = {type = "virtual", name = "signal-red"}, count = 0, index = 1},
					{signal = {type = "virtual", name = "signal-green"}, count = 0, index = 2},
					{signal = {type = "virtual", name = "signal-blue"}, count = 0, index = 3},
					{signal = {type = "virtual", name = "signal-yellow"}, count = 0, index = 4},
					{signal = {type = "virtual", name = "signal-pink"}, count = 0, index = 5},
					{signal = {type = "virtual", name = "signal-cyan"}, count = 0, index = 6}
				}
				for i = 1,6 do
					if params[i].signal and params[i].signal.name then
						local color = ""
						if i == 1 then
							color = "signal-red"
						elseif i == 2 then
							color = "signal-green"
						elseif i == 3 then
							color = "signal-blue"
						elseif i == 4 then
							color = "signal-yellow"
						elseif i == 5 then
							color = "signal-pink"
						elseif i == 6 then
							color = "signal-cyan"
						end
						if get_count(control, params[i].signal) == params[i].count then
							table.insert(slots, {signal = {type = "virtual", name = color}, count = 1, index = i})
						else
							table.insert(slots, {signal = {type = "virtual", name = color}, count = 0, index = i})
						end
					end
				end
				control.parameters = slots
			else
				control.parameters = {
						{signal = {type = "virtual", name = "signal-red"}, count = 0, index = 1},
						{signal = {type = "virtual", name = "signal-green"}, count = 0, index = 2},
						{signal = {type = "virtual", name = "signal-blue"}, count = 0, index = 3},
						{signal = {type = "virtual", name = "signal-yellow"}, count = 0, index = 4},
						{signal = {type = "virtual", name = "signal-pink"}, count = 0, index = 5},
						{signal = {type = "virtual", name = "signal-cyan"}, count = 0, index = 6}
				}
			end
		end
	end
}