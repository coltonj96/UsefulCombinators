return {
	on_click = function(player, object)
		local gui = player.gui.center
		if gui["uc"]["uc-detector-combinator"]["signal"].elem_value and gui["uc"]["uc-detector-combinator"]["signal"].elem_value.name then
			object.meta.signal = gui["uc"]["uc-detector-combinator"]["signal"].elem_value
		else
			object.meta.signal = {type = "virtual"}
		end
		object.meta.radius = tonumber(gui["uc"]["uc-detector-combinator"]["radius"].text) or object.meta.radius
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local meta = object.meta
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Detector Combinator"}
			local layout = uc.add{type = "table", name = "uc-detector-combinator", column_count = 4}
			layout.add{type = "label", caption = "Radius: (?)", tooltip = {"uc-detector-combinator.radius"}}
			layout.add{type = "textfield", name = "radius", style = "uc_text", text = meta.radius}
			layout.add{type = "label", caption = "Signal: (?)", tooltip = {"uc-detector-combinator.signal"}}
			if meta.signal and meta.signal.name then
				layout.add{type = "choose-elem-button", name = "signal", elem_type = "signal", signal = meta.signal}
			else
				layout.add{type = "choose-elem-button", name = "signal", elem_type = "signal"}
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
				radius = 24,
				signal = {type = "virtual", name = "uc-output-signal"}
			}
		}
	end,
	on_destroy = function(meta, item)
		item.set_tag("uc_meta", meta)
	end,
	on_tick = function(object)
		local control = object.meta.entity.get_or_create_control_behavior()
		if control then
			local signal = object.meta.signal
			if signal then
				if control.enabled then
					local r = object.meta.radius
					if r > 24 then
						r = 24
						object.meta.radius = 24
					end
					if r < 1 then
						r = 1
						object.meta.radius = 1
					end
					local slots = {}
					local pos = object.meta.entity.position
					local units = object.meta.entity.surface.count_entities_filtered({position = pos, radius = r + 0.5, force = "enemy"})
					if signal.name then
						table.insert(slots, {signal = signal, count = units, index = 1})
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