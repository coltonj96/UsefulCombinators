return {
	on_click = function(player, object)
		local params = object.meta.params
		local gui = player.gui.center.uc["uc-min-combinator"]
		for i = 1,5 do
			if gui["signal"..i].elem_value and gui["signal"..i].elem_value.name then
				object.meta.params[i] = {signal = gui["signal"..i].elem_value}
			else
				object.meta.params[i] = {signal = {type = "virtual"}}
			end
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local params = object.meta.params
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Min Combinator"}
			local layout = uc.add{type = "table", name = "uc-min-combinator", column_count = 6}
			layout.add{type = "label", caption = "Filter: (?)", tooltip = {"uc-min-combinator.filter"}}
			for i = 1,5 do
				if params[i].signal and params[i].signal.name then
					layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal", signal = params[i].signal}
				else
					layout.add{type = "choose-elem-button", name = "signal"..i, elem_type = "signal"}
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
					{signal = {type = "virtual"}},
					{signal = {type = "virtual"}},
					{signal = {type = "virtual"}},
					{signal = {type = "virtual"}},
					{signal = {type = "virtual"}}
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
				local slots = {}
				local signals = get_signals(control)
				local signal = {type = "virtual"}
				local count = math.huge
				for k,v in pairs(signals) do
					count = math.min(count, v.count)
					if count == v.count then
						signal = v.signal
					end
				end
				count = 1
				if count == math.huge then
					count = 0
				end
				for i = 1,5 do
					if params[i].signal and params[i].signal.name then
						if signal.name == params[i].signal.name then
							table.insert(slots, {signal = signal, count = count, index = 1})
							break
						end
					end
				end
				control.parameters = slots
			else
				control.parameters = nil
			end
		end
	end
}