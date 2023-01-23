return {
	on_click = function(player, object)
		local gui = player.gui.center.uc["uc-counting-combinator"]
		object.meta.reset = tonumber(gui["reset"].text) or object.meta.reset
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local params = object.meta.params
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Counting Combinator"}
			local layout = uc.add{type = "table", name = "uc-counting-combinator", column_count = 2}
			layout.add{type = "label", caption = "Reset: (?)", tooltip = {"uc-counting-combinator.reset"}}
			layout.add{type = "textfield", name = "reset", style = "uc_text", text = object.meta.reset}
			layout.add{type = "button", name = "uc-exit", caption = "Ok"}
			layout.add{type = "label", caption = "(extra info)", tooltip = {"uc-counting-combinator.extra"}}
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
				reset = -1
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
				if (object.meta.reset < -1) then object.meta.reset = -1 end
				if (object.meta.count < 0) then object.meta.count = 0 end
				if object.meta.reset > -1 and object.meta.count > object.meta.reset then
					object.meta.count = 0
				end
				object.meta.count = object.meta.count - get_count(control, {type = "virtual", name = "uc-minus-one-signal"})
				object.meta.count = object.meta.count + get_count(control, {type = "virtual", name = "uc-plus-one-signal"})
				if object.meta.reset > -1 and object.meta.count == -1 then
					object.meta.count = object.meta.reset
				end
				control.parameters = {
					{signal = {type = "virtual", name = "uc-counting-signal"}, count = object.meta.count, index = 1}
				}
			end
		else
			control.parameters = {
				{signal = {type = "virtual", name = "uc-counting-signal"}, count = 0, index = 1}
			}
		end
	end
}