return {
	on_click = function(player, object)
		local gui = player.gui.center
		if gui["uc"]["uc-pollution-combinator"]["output"].elem_value and gui["uc"]["uc-pollution-combinator"]["output"].elem_value.name then
			object.meta.minutes = gui["uc"]["uc-pollution-combinator"]["output"].elem_value
		else
			object.meta.minutes = {type = "virtual"}
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local meta = object.meta
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Pollution Combinator"}
			local layout = uc.add{type = "table", name = "uc-pollution-combinator", column_count = 2}
			layout.add{type = "label", caption = "Output: (?)", tooltip = {"uc-pollution-combinator.output"}}
			if meta.output and meta.output.name then
				layout.add{type = "choose-elem-button", name = "output", elem_type = "signal", signal = meta.output}
			else
				layout.add{type = "choose-elem-button", name = "output", elem_type = "signal"}
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
				output = {type = "virtual", name = "uc-output-signal"}
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
				local meta = object.meta
				local pollution = meta.entity.surface.get_pollution(meta.entity.position)
				if meta.output and meta.output.name then
					table.insert(slots, {signal = meta.output, count = pollution, index = 1})
				end
				control.parameters = slots
			end
		else
			control.parameters = {
				{signal = {type = "virtual", name = "uc-output-signal"}, count = 0, index = 1}
			}
		end
	end
}