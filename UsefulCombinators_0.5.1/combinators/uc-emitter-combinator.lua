return {
	on_click = function(player, object)
		local gui = player.gui.center
		local params = {}
		for i = 1,6 do
			if gui["uc"]["uc-emitter-combinator"]["signal"..i].elem_value then
				params[i] = {signal = gui["uc"]["uc-emitter-combinator"]["signal"..i].elem_value}
			else
				params[i] = {signal = {type = "virtual"}}
			end
		end
		object.meta.params = params
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local gui = player.gui.center
			local params = object.meta.params
			local uc = gui.add{type = "frame", name = "uc", caption = "Emitter Combinator"}
			local layout = uc.add{type = "table", name = "uc-emitter-combinator", column_count = 8}
			layout.add{type = "label", caption = "Signal: (?)", tooltip = {"uc-emitter-combinator.signal"}}
			if params[1] and params[1].signal then	
				layout.add{type = "choose-elem-button", name = "signal1", elem_type = "signal", signal = params[1].signal}
			else
				layout.add{type = "choose-elem-button", name = "signal1", elem_type = "signal"}
			end
			layout.add{type = "label", caption = "Filter: (?)", tooltip = {"uc-emitter-combinator.filter"}}
			for i= 2,6 do
				if params[i] and params[i].signal then
					layout.add{type = "choose-elem-button", name = "signal" .. i, elem_type = "signal", signal = params[i].signal}
				else
					layout.add{type = "choose-elem-button", name = "signal" .. i, elem_type = "signal"}
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
				params = {}
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
				for i = 2,6 do
					if params[i] and params[i].signal and params[i].signal.name then
						object.meta.params[i].count = get_count(control, params[i].signal)
					end
				end
			end
		end
	end
}