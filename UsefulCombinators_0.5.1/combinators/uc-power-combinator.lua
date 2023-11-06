return {
	on_click = function(player, object)
		local gui = player.gui.center
		object.meta.ticks = tonumber(gui["uc"]["uc-power-combinator"]["ticks"].text) or 1
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local gui = player.gui.center
			local uc = gui.add{type = "frame", name = "uc", caption = "Power Combinator"}
			local layout = uc.add{type = "table", name = "uc-power-combinator", column_count = 2}
			layout.add{type = "label", caption = "Ticks: (?)", tooltip = {"uc-power-combinator.ticks"}}
			layout.add{type = "textfield", name = "ticks", style = "uc_text", text = object.meta.ticks}
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
				ticks = 1,
				prev = 0,
				params = {
					{signal = {type = "virtual", name = "uc-watts-signal"}, count = 0, index = 4},
					{signal = {type = "virtual", name = "uc-kilo-watts-signal"}, count = 0, index = 3},
					{signal = {type = "virtual", name = "uc-mega-watts-signal"}, count = 0, index = 2},
					{signal = {type = "virtual", name = "uc-giga-watts-signal"}, count = 0, index = 1}
				}
			}
		}
	end,
	on_destroy = function(object) end,
	on_tick = function(object)
		local control = object.meta.entity.get_or_create_control_behavior()
		if control then
			local params = object.meta.params
			if params[1].signal.name then 
				local ticks = object.meta.ticks
				if ticks < 1 then
					ticks = 1
					object.meta.ticks = 1
				end
				if ticks > 3600 then
					ticks = 3600
					object.meta.ticks = 3600
				end
				if control.enabled then
					local slots = {
						{signal = params[4].signal, count = params[4].count, index = 4},
						{signal = params[3].signal, count = params[3].count, index = 3},
						{signal = params[2].signal, count = params[2].count, index = 2},
						{signal = params[1].signal, count = params[1].count, index = 1}
					}
					local pos = object.meta.entity.position
					local poles = object.meta.entity.surface.find_entities_filtered(
						{
							area = {{pos.x - 1, pos.y - 1}, {pos.x + 1, pos.y + 1}},
							type = "electric-pole"
						})
					local power = 0
					local watts = 0
					if #poles > 0 then
						for _,p in pairs(poles) do
							for k,v in pairs(p.electric_network_statistics.output_counts) do
								power = power + (p.electric_network_statistics.get_output_count(k) or 0)
							end
							if power > 0 then
								break
							end
						end
						watts = (power - object.meta.prev) * 60
						object.meta.prev = power
					end
					if ((game.tick % ticks) == 0) then
						slots = {}
						local w = watts % 1000
						local kw = ((watts - w) / 1000) % 1000
						local mw = ((watts - (w + (kw * 1000))) / (10 ^ 6)) % 1000
						local gw = ((watts - (w + (kw * 1000) + (mw * 10 ^ 6))) / (10 ^ 9))
						table.insert(slots, {signal = {type = "virtual", name = "uc-giga-watts-signal"}, count = gw, index = 1})
						table.insert(slots, {signal = {type = "virtual", name = "uc-mega-watts-signal"}, count = mw, index = 2})
						table.insert(slots, {signal = {type = "virtual", name = "uc-kilo-watts-signal"}, count = kw, index = 3})
						table.insert(slots, {signal = {type = "virtual", name = "uc-watts-signal"}, count = w, index = 4})
						object.meta.params = slots
					end
					control.parameters = slots
				end
			else
				control.parameters = {
					{signal = {type = "virtual", name = "uc-watts-signal"}, count = 0, index = 4},
					{signal = {type = "virtual", name = "uc-kilo-watts-signal"}, count = 0, index = 3},
					{signal = {type = "virtual", name = "uc-mega-watts-signal"}, count = 0, index = 2},
					{signal = {type = "virtual", name = "uc-giga-watts-signal"}, count = 0, index = 1},
				}
			end
		end
	end
}