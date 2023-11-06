return {
	on_click = function(player, object)
		local gui = player.gui.center
		if gui["uc"]["uc-daytime-combinator"]["minutes"].elem_value and gui["uc"]["uc-daytime-combinator"]["minutes"].elem_value.name then
			object.meta.minutes = gui["uc"]["uc-daytime-combinator"]["minutes"].elem_value
		else
			object.meta.minutes = {type = "virtual", name = "signal-M"}
		end
		if gui["uc"]["uc-daytime-combinator"]["hours"].elem_value and gui["uc"]["uc-daytime-combinator"]["hours"].elem_value.name then
			object.meta.hours = gui["uc"]["uc-daytime-combinator"]["hours"].elem_value
		else
			object.meta.hours = {type = "virtual", name = "signal-H"}
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local meta = object.meta
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Daytime Combinator"}
			local layout = uc.add{type = "table", name = "uc-daytime-combinator", column_count = 2}
			layout.add{type = "label", caption = "Minutes: (?)", tooltip = {"uc-daytime-combinator.minutes"}}
			if meta.minutes and meta.minutes.name then
				layout.add{type = "choose-elem-button", name = "minutes", elem_type = "signal", signal = meta.minutes}
			else
				layout.add{type = "choose-elem-button", name = "minutes", elem_type = "signal"}
			end
			layout.add{type = "label", caption = "Hours: (?)", tooltip = {"uc-daytime-combinator.hours"}}
			if meta.hours and meta.hours.name then
				layout.add{type = "choose-elem-button", name = "hours", elem_type = "signal", signal = meta.hours}
			else
				layout.add{type = "choose-elem-button", name = "hours", elem_type = "signal"}
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
				minutes = {type = "virtual", name = "signal-M"},
				hours = {type = "virtual", name = "signal-H"}
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
				local daytime = (meta.entity.surface.daytime * 24 + 12) % 24
				if meta.minutes and meta.minutes.name then
					table.insert(slots, {signal = meta.minutes, count = math.floor((daytime - math.floor(daytime)) * 60), index = 1})
				end
				if meta.hours and meta.hours.name then
					table.insert(slots, {signal = meta.hours, count = math.floor(daytime), index = 2})
				end
				control.parameters = slots
			end
		else
			control.parameters = {
				{signal = {type = "virtual", name = "signal-M"}, count = 0, index = 1},
				{signal = {type = "virtual", name = "signal-H"}, count = 0, index = 2}
			}
		end
	end
}