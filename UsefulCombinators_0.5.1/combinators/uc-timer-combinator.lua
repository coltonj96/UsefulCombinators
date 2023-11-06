return {
	on_click = function(player, object)
		local gui = player.gui.center.uc["uc-timer-combinator"]
		object.meta.reset = tonumber(gui["reset"].text) or object.meta.reset
		object.meta.ticks = tonumber(gui["ticks"].text) or object.meta.ticks
		if object.meta.running then
			object.meta.running = false
		end
		object.meta.count = 0
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Timer Combinator"}
			local layout = uc.add{type = "table", name = "uc-timer-combinator", column_count = 2}
			layout.add{type = "label", caption = "Reset Count: (?)", tooltip = {"uc-timer-combinator.reset"}}
			layout.add{type = "textfield", name = "reset", style = "uc_text", text = object.meta.reset}
			layout.add{type = "label", caption = "Update Interval: (?)", tooltip = {"uc-timer-combinator.ticks"}}
			layout.add{type = "textfield", name = "ticks", style = "uc_text", text = object.meta.ticks}
			layout.add{type = "button", name = "uc-exit", caption = "Ok"}
			layout.add{type = "label", caption = "(extra info)", tooltip = {"uc-timer-combinator.extra"}}
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
				count = 0,
				reset = 10,
				running = false,
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
			if control.enabled then
				if get_count(control, {type = "virtual", name = "uc-start-signal"}) > 0 then
					object.meta.running = true
				end
				if get_count(control, {type = "virtual", name = "uc-stop-signal"}) > 0 then
					object.meta.running = false
				end
				if object.meta.running then
					if (object.meta.ticks < 1) then object.meta.ticks = 1 end
					if (object.meta.ticks > 3600) then object.meta.ticks = 3600 end
					if (game.tick % object.meta.ticks) == 0 then
						object.meta.count = object.meta.count + 1
						if object.meta.count > object.meta.reset then
							object.meta.count = 0
						end
						control.parameters = {
							{signal = {type = "virtual", name = "uc-counting-signal"}, count = object.meta.count, index = 1}
						}
					end
				end
			else
				control.parameters = {
					{signal = {type = "virtual", name = "uc-counting-signal"}, count = 0, index = 1}
				}
			end
		end
	end
}