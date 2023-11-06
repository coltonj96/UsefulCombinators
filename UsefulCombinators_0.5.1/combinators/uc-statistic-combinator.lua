return {
	on_click = function(player, object)
		local gui = player.gui.center
		local params = {}
		for i = 1,5 do
			if gui["uc"]["uc-statistic-combinator"]["signal"..i].elem_value then
				params[i] = {signal = {name = gui["uc"]["uc-statistic-combinator"]["signal"..i].elem_value, type = "item"}}
			else
				params[i] = {signal = {type = "item"}}
			end
		end
		object.meta.params = params
		object.meta.index = gui["uc"]["uc-statistic-combinator"]["stat"].selected_index
		--object.meta.ticks = tonumber(gui["uc"]["statistic-combinator"]["ticks"].text) or 1
	end,
	on_key = function(player, object)
		if not (player.gui.center["uc"]) then
			local gui = player.gui.center
			local params = object.meta.params
			local uc = gui.add{type = "frame", name = "uc", caption = "Statistic Combinator"}
			local layout = uc.add{type = "table", name = "uc-statistic-combinator", column_count = 8}
			layout.add{type = "label", caption = "Type: (?)", tooltip = {"uc-statistic-combinator.stat"}}
			layout.add{type = "drop-down", name = "stat", items = {{"uc-statistic-combinator.production"}, {"uc-statistic-combinator.consumption"}}, selected_index = object.meta.index}
			--layout.add{type = "label", caption = "Ticks: (?)", tooltip = {"statistic-combinator.ticks"}}
			--layout.add{type = "textfield", name = "ticks", style = "uc_text", text = object.meta.ticks}
			layout.add{type = "label", caption = "Filter: (?)", tooltip = {"uc-statistic-combinator.filter"}}
			for i= 1,5 do
				if params[i] and params[i].signal and params[i].signal.name then
					layout.add{type = "choose-elem-button", name = "signal" .. i, elem_type = "item", item = params[i].signal.name}
				else
					layout.add{type = "choose-elem-button", name = "signal" .. i, elem_type = "item"}
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
					{signal = {type = "item"}, count = 0, index = 1},
					{signal = {type = "item"}, count = 0, index = 2},
					{signal = {type = "item"}, count = 0, index = 3},
					{signal = {type = "item"}, count = 0, index = 4},
					{signal = {type = "item"}, count = 0, index = 5}
				},
				--ticks = 300,
				prev = {0, 0, 0, 0, 0},
				index = 1
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
				local slots = {
					{signal = params[1].signal, count = params[1].count or 0, index = 1},
					{signal = params[2].signal, count = params[2].count or 0, index = 2},
					{signal = params[3].signal, count = params[3].count or 0, index = 3},
					{signal = params[4].signal, count = params[4].count or 0, index = 4},
					{signal = params[5].signal, count = params[5].count or 0, index = 5}
				}
				--[[local ticks = object.meta.ticks
				if ticks < 1 then
					ticks = 1
					object.meta.ticks = 1
				end
				if ticks > 3600 then
					ticks = 3600
					object.meta.ticks = 3600
				end]]
				if ((game.tick % 60) == 0) then
					for i = 1,5 do
						if params[i] and params[i].signal and params[i].signal.name then
							local stats
							local flow
							if game.item_prototypes[params[i].signal.name] and game.item_prototypes[params[i].signal.name].type == "fluid" then
								stats = object.meta.entity.force.fluid_production_statistics
							else
								stats = object.meta.entity.force.item_production_statistics
							end
							if object.meta.index == 1 then
								flow = stats.get_input_count(params[i].signal.name) or 0
							elseif object.meta.index == 2 then
								flow = stats.get_output_count(params[i].signal.name) or 0
							end
							local old = object.meta.prev[i]
							object.meta.params[i].count = flow - old
							table.insert(slots, {signal = params[i].signal, count = object.meta.params[i].count, index = i})
							object.meta.prev[i] = flow
						end
					end
				end
				control.parameters = slots
			end
		else
			control.parameters = {
				{signal = {type = "item", name = "coal"}, count = 1, index = 1},
				{signal = {type = "item"}, count = 0, index = 2},
				{signal = {type = "item"}, count = 0, index = 3},
				{signal = {type = "item"}, count = 0, index = 4},
				{signal = {type = "item"}, count = 0, index = 5}
			}
		end
	end
}