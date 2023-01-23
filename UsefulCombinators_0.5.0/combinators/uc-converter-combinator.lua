return {
	on_click = function(player, object)
		local gui = player.gui.center
		for i = 1,5 do
			if gui["uc"]["uc-converter-combinator"]["from"..i].elem_value and gui["uc"]["uc-converter-combinator"]["from"..i].elem_value.name then
				object.meta.params["from"][i] = {signal = gui["uc"]["uc-converter-combinator"]["from"..i].elem_value}
			else
				object.meta.params["from"][i] = {type = "virtual"}
			end
			if gui["uc"]["uc-converter-combinator"]["to"..i].elem_value and gui["uc"]["uc-converter-combinator"]["to"..i].elem_value.name then
				object.meta.params["to"][i] = {signal = gui["uc"]["uc-converter-combinator"]["to"..i].elem_value}
			else
				object.meta.params["to"][i] = {type = "virtual"}
			end
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local params = object.meta.params
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Converter Combinator"}
			local layout = uc.add{type = "table", name = "uc-converter-combinator", column_count = 2}
			layout.add{type = "label", caption = "From: (?)", tooltip = {"uc-converter-combinator.from"}}
			layout.add{type = "label", caption = "To: (?)", tooltip = {"uc-converter-combinator.to"}}
			for i = 1,5 do
				if params["from"][i].signal and params["from"][i].signal.name then
					layout.add{type = "choose-elem-button", name = "from"..i, elem_type = "signal", signal = params["from"][i].signal}
				else
					layout.add{type = "choose-elem-button", name = "from"..i, elem_type = "signal"}
				end
				if params["to"][i].signal and params["to"][i].signal.name then
					layout.add{type = "choose-elem-button", name = "to"..i, elem_type = "signal", signal = params["to"][i].signal}
				else
					layout.add{type = "choose-elem-button", name = "to"..i, elem_type = "signal"}
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
					from = {
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}}
					},
					to = {
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}},
						{signal = {type = "virtual"}}
					}
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
			if control.enabled then
				local slots = {}
				local params = object.meta.params
				if not params["from"] and not params["to"] then
					object.meta.params = {
						from = {
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}}
						},
						to = {
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}},
							{signal = {type = "virtual"}}
						}
					}
					params = object.meta.params
				end
				for i = 1,5 do
					if params["to"][i].signal and params["to"][i].signal.name then
						table.insert(slots, {signal = params["to"][i].signal, count = get_count(control, params["from"][i].signal), index = i})
					end
				end
				control.parameters = slots
			else
				control.parameters = nil
			end
		end
	end
}