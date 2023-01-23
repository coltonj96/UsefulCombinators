return {
	on_click = function(player, object)
		local gui = player.gui.center
		if gui["uc"]["uc-receiver-combinator"]["signal"].elem_value then
			object.meta.signal = gui["uc"]["uc-receiver-combinator"]["signal"].elem_value
		else
			object.meta.signal = { type = "virtual" }
		end
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Receiver Combinator"}
			local layout = uc.add{type = "table", name = "uc-receiver-combinator", column_count = 2}
			layout.add{type = "label", caption = "Signal: (?)", tooltip = {"uc-receiver-combinator.signal"}}
			layout.add{type = "choose-elem-button", name = "signal", elem_type = "signal", signal = object.meta.signal}
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
				signal = { type = "virtual", name = "signal-0"}
			}
		}
	end,
	on_destroy = function(meta, item)
		item.set_tag("uc_meta", meta)
	end,
	on_tick = function(object)
		local control = object.meta.entity.get_or_create_control_behavior()
		if control then
			local params = control.parameters.parameters
			if object.meta.signal.name then
				local slots = {}
				local p1 = object.meta.signal
				if control.enabled then
					local sender
					for k,v in pairs(global["uc_data"]["uc-emitter-combinator"]) do
						if v.meta.params[1] and (p1.name == v.meta.params[1].signal.name) then
							sender = v.meta
							break
						end
					end
					if sender then
						local sender_control = sender.entity.get_control_behavior()
						for i = 2,6 do
							if sender.params[i].signal and sender.params[i].signal.name then
								table.insert(slots, {signal = sender.params[i].signal, count = sender.params[i].count, index = (i - 1)})
							end
						end
					end
					control.parameters = slots
				end
			else
				control.parameters = nil
			end
		end
	end
}