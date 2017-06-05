local data = {}
local classes = {}

function save()
  global.uc_data = data
end

classes["timer-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1] and params[1].count then
        local count,interval,mod,reset,output = params[1].count or 1, params[2].count or 1, params[3].count or 1, params[4].count or 0, params[5].signal
        if control.enabled then
          if (mod < 1) then mod = 1 end
          if (mod > 60) then mod = 60 end
          if (interval < 1) then interval = 1 end
          if (interval > 15) then interval = 15 end
          local t = math.floor(60 * (interval / mod))
          if t < 1 then t = 1 end
          if (game.tick % t) == 0 then
            local out = 0
            if count >= reset then
              count = 0
              out = 1
            end
            local sig = {type = "virtual", name = "output-signal"}
            if output.name then
              sig = output
            end
            control.parameters = {
              parameters = {
                {signal = {type = "virtual", name = "counting-signal"}, count = (count + 1), index = 1},
                {signal = {type = "virtual", name = "interval-signal"}, count = interval, index = 2},
                {signal = {type = "virtual", name = "time-mod-signal"}, count = mod, index = 3},
                {signal = {type = "virtual", name = "reset-signal"}, count = reset, index = 4},
                {signal = sig, count = out, index = 5}
              }
            }
          end
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "counting-signal"}, count = 1, index = 1},
            {signal = {type = "virtual", name = "interval-signal"}, count = 1, index = 2},
            {signal = {type = "virtual", name = "time-mod-signal"}, count = 1, index = 3},
            {signal = {type = "virtual", name = "reset-signal"}, count = 60, index = 4},
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 5}
          }
        }
      end
    end
  end
}

classes["counting-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1] and params[1].count then
        local count,reset,output = params[1].count or 1, params[2].count or 0, params[3].signal
        if control.enabled then
        if (reset <= 0) then reset = 0 end
        if count < 0 then count = 0 end
        local out = 0
        if reset > 0 and count > reset then
          count = 0
          out = 1
        end
        count = count - get_count(control, {type = "virtual", name = "minus-one-signal"})
        count = count + get_count(control, {type = "virtual", name = "plus-one-signal"})
        if reset > 0 and count == -1 then
          count = reset
          out = 1
        end
        local sig = {type = "virtual", name = "output-signal"}
        if output.name then
          sig = output
        end
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "counting-signal"}, count = count, index = 1},
            {signal = {type = "virtual", name = "reset-signal"}, count = reset, index = 2},
            {signal = sig, count = out, index = 3}
          }
        }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "counting-signal"}, count = 1, index = 1},
            {signal = {type = "virtual", name = "reset-signal"}, count = 0, index = 2},
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["random-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1] and params[1].count then
        local count,minimum,maximum,ticks = params[1].count or 0, params[2].count or 1, params[3].count or 10, params[4].count or 1
        if control.enabled then
          if minimum < 1 then minimum = 1 end
          if maximum <= minimum then maximum = minimum + 1 end
          if ticks < 1 then ticks = 1 end
          if ticks > 60 then ticks = 60 end
          if get_count(control, {name = "output-signal", type = "virtual"}) >= 1 then
            count = math.random(minimum,maximum)
          end
          if (game.tick % ticks) == 0 then
            control.parameters = {
              parameters = {
                {signal = {type = "virtual", name = "counting-signal"}, count = count, index = 1},
                {signal = {type = "virtual", name = "lower-signal"}, count = minimum, index = 2},
                {signal = {type = "virtual", name = "upper-signal"}, count = maximum, index = 3},
                {signal = {type = "virtual", name = "ticks-signal"}, count = ticks, index = 4}
              }
            }
          end
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "counting-signal"}, count = 0, index = 1},
            {signal = {type = "virtual", name = "lower-signal"}, count = 1, index = 2},
            {signal = {type = "virtual", name = "upper-signal"}, count = 10, index = 3},
            {signal = {type = "virtual", name = "ticks-signal"}, count = 1, index = 4}
          }
        }
      end
    end
  end
}

classes["comparator-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[2].signal.name and params[5].signal.name then
        local p1,p2,p3,p4,p5 = params[1], params[2], params[3], params[4], params[5]
        if control.enabled then
          local slots = {}
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
          end
          if p2.signal.name then
            local name = p2.signal.name
            if (name == "lt-signal") or (name == "lte-signal") or (name == "eq-signal") or (name == "gte-signal") or (name == "gt-signal") then
              table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            else
              table.insert(slots, {signal = {type = "virtual", name = "lt-signal"}, count = 0, index = 2})
            end
          end
          if p3.signal.name then
            table.insert(slots, {signal = p3.signal, count = 0, index = 3})
          end
          if p4.signal.name then
            if p1.signal.name and p3.signal.name then
              if parse(get_count(control, p1.signal), p2.signal.name, get_count(control, p3.signal)) then
                table.insert(slots, {signal = p4.signal, count = p5.count or 0, index = 4})
              else
                table.insert(slots, {signal = p4.signal, count = 0, index = 4})
              end
            else
              table.insert(slots, {signal = p4.signal, count = 0, index = 4})
            end
          end
          table.insert(slots, {signal = {type = "virtual", name = "counting-signal"}, count = p5.count, index = 5})
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "lt-signal"}, count = 0, index = 2},
            {signal = {type = "virtual", name = "counting-signal"}, count = 0, index = 5}
          }
        }
      end
    end
  end
}

classes["min-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1].signal.name then
        local p1 = params[1]
        if control.enabled then
          local slots = {}
          if p1.signal.name then
            local signals = get_signals(control)
            local signal = {type = "virtual", name = "blank"}
            local count = math.huge
            for k,v in pairs(signals) do
              count = math.min(count, v.count)
              if count == v.count then
                signal = v.signal
              end
            end
            count = 1
            if signal.name == "blank" then
              count = 0
            end
            table.insert(slots, {signal = signal, count = count, index = 1})
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "blank"}, count = 0, index = 1}
          }
        }
      end
    end
  end
}

classes["max-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1].signal.name then
        local p1 = params[1]
        if control.enabled then
          local slots = {}
          if p1.signal.name then
            local signals = get_signals(control)
            local signal = {type = "virtual", name = "blank"}
            local count = -math.huge
            for k,v in pairs(signals) do
              count = math.max(count, v.count)
              if count == v.count then
                signal = v.signal
              end
            end
            count = 1
            if signal.name == "blank" then
              count = 0
            end
            table.insert(slots, {signal = signal, count = count, index = 1})
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "blank"}, count = 0, index = 1}
          }
        }
      end
    end
  end
}

classes["and-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[3].signal.name then
        local p1,p2,p3 = params[1], params[2], params[3]
        if control.enabled then
          local slots = {}
          local c1,c2 = 0,0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            c2 = get_count(control, p2.signal)
          end
          if p3.signal.name then
            if (c1 > 0) and (c2 > 0) and (c1 == c2) then
              table.insert(slots, {signal = p3.signal, count = 1, index = 3})
            else
              table.insert(slots, {signal = p3.signal, count = 0, index = 3})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["nand-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[3].signal.name then
        local p1,p2,p3 = params[1], params[2], params[3]
        if control.enabled then
          local slots = {}
          local c1,c2 = 0,0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            c2 = get_count(control, p2.signal)
          end
          if p3.signal.name then
            if (c1 > 0) and (c2 > 0) and (c1 == c2) then
              table.insert(slots, {signal = p3.signal, count = 0, index = 3})
            else
              table.insert(slots, {signal = p3.signal, count = 1, index = 3})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["nor-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[3].signal.name then
        local p1,p2,p3 = params[1], params[2], params[3]
        if control.enabled then
          local slots = {}
          local c1,c2 = 0,0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            c2 = get_count(control, p2.signal)
          end
          if p3.signal.name then
            if (c1 >= 1) or (c2 >= 1) then
              table.insert(slots, {signal = p3.signal, count = 0, index = 3})
            else
              table.insert(slots, {signal = p3.signal, count = 1, index = 3})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["not-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[2].signal.name then
        local p1,p2 = params[1], params[2]
        if control.enabled then
          local slots = {}
          local c1 = 0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            if (c1 > 0) then
              table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            else
              table.insert(slots, {signal = p2.signal, count = 1, index = 2})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 2}
          }
        }
      end
    end
  end
}

classes["or-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[3].signal.name then
        local p1,p2,p3 = params[1], params[2], params[3]
        if control.enabled then
          local slots = {}
          local c1,c2 = 0,0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            c2 = get_count(control, p2.signal)
          end
          if p3.signal then
            if (c1 >= 1) or (c2 >= 1) then
              table.insert(slots, {signal = p3.signal, count = 1, index = 3})
            else
              table.insert(slots, {signal = p3.signal, count = 0, index = 3})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["xnor-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[3].signal.name then
        local p1,p2,p3 = params[1], params[2], params[3]
        if control.enabled then
          local slots = {}
          local c1,c2 = 0,0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            c2 = get_count(control, p2.signal)
          end
          if p3.signal.name then
            if (c1 == c2) then
              table.insert(slots, {signal = p3.signal, count = 1, index = 3})
            else
              table.insert(slots, {signal = p3.signal, count = 0, index = 3})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["xor-gate-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[3].signal.name then
        local p1,p2,p3 = params[1], params[2], params[3]
        if control.enabled then
          local slots = {}
          local c1,c2 = 0,0
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
            c1 = get_count(control, p1.signal)
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = 0, index = 2})
            c2 = get_count(control, p2.signal)
          end
          if p3.signal.name then
            if (c1 == c2) then
              table.insert(slots, {signal = p3.signal, count = 0, index = 3})
            else
              table.insert(slots, {signal = p3.signal, count = 1, index = 3})
            end
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 3}
          }
        }
      end
    end
  end
}

classes["converter-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1].signal.name then
        local p1,p2 = params[1], params[2]
        if control.enabled then
          local slots = {}
          if p1.signal.name then
            table.insert(slots, {signal = p1.signal, count = 0, index = 1})
          end
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = get_count(control, p1.signal), index = 2})
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {}
        }
      end
    end
  end
}

classes["detector-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1].signal.name then
        local p1,p2 = params[1], params[2]
        if control.enabled then
          local r = p1.count
          if r > 8 then r = 8 end
          if r < 1 then r = 1 end
          local slots = {
            {signal = {type = "virtual", name = "radius-signal"}, count = r, index = 1}
          }
          local units = #object.entity.surface.find_enemy_units(object.entity.position, r + 0.5)
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = units, index = 2})
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "radius-signal"}, count = 8, index = 1},
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 2}
          }
        }
      end
    end
  end
}

classes["sensor-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1].signal.name then
        local p1,p2 = params[1],params[2]
        if control.enabled then
          local r = p1.count
          if r > 8 then r = 8 end
          if r < 1 then r = 1 end
          local slots = {
            {signal = {type = "virtual", name = "radius-signal"}, count = r, index = 1}
          }
          local pos = object.entity.position
          local units = object.entity.surface.count_entities_filtered(
          {
            area = {{pos.x - (r + 0.5), pos.y - (r + 0.5)}, {pos.x + (r + 0.5), pos.y + (r + 0.5)}},
            type = "player"
          })
          if p2.signal.name then
            table.insert(slots, {signal = p2.signal, count = units, index = 2})
          end
          control.parameters = {
            parameters = slots
          }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "radius-signal"}, count = 8, index = 1},
            {signal = {type = "virtual", name = "output-signal"}, count = 0, index = 2}
          }
        }
      end
    end
  end
}

function parse(a, op, b)
  if op == "lt-signal" then
    if a < b then
      return true
    else
      return false
    end
  elseif op == "lte-signal" then
    if a <= b then
      return true
    else
      return false
    end
  elseif op == "eq-signal" then
    if a == b then
      return true
    else
      return false
    end
  elseif op == "gte-signal" then
    if a >= b then
      return true
    else
      return false
    end
  elseif op == "gt-signal" then
    if a > b then
      return true
    else
      return false
    end
  else
    return false
  end
end

function get_count(control, signal)
  if not signal then return 0 end
  local red = control.get_circuit_network(defines.wire_type.red)
  local green = control.get_circuit_network(defines.wire_type.green)
  local val = 0
  if red then
    val = red.get_signal(signal) or 0
  end
  if green then 
    val = val + (green.get_signal(signal) or 0)
  end
  return val
end

function get_signals(control)
  local red = control.get_circuit_network(defines.wire_type.red)
  local green = control.get_circuit_network(defines.wire_type.green)
  local network = {}
  if red and red.signals then
    for _,v in pairs(red.signals) do
      if v.signal.name then
        network[v.signal.name] = v
      end
    end
  end
  if green and green.signals then
    for _,v in pairs(green.signals) do
      if v.signal.name then
        network[v.signal.name] = v
      end
    end
  end
  return network
end

function entity_built(event)
  if classes[event.created_entity.name] ~= nil then
      local tab = data[event.created_entity.name]
      table.insert(tab, classes[event.created_entity.name].on_place(event.created_entity))
      data[event.created_entity.name] = tab
      save()
  end
end

function entity_removed(event)
  if classes[event.entity.name] ~= nil then
    for k,v in ipairs(data[event.entity.name]) do
      if v.entity == event.entity then
        local tab = data[event.entity.name]
        table.remove(tab, k)
        classes[event.entity.name].on_destroy(v)
        data[event.entity.name] = tab
        save()
        break
      end
    end
  end
end

function tick()
  for k,v in pairs(classes) do
    for q,i in pairs(data[k]) do
      if i.entity.valid then
        v.on_tick(i, q)
      end
    end
  end
end

function init()
  data = global.uc_data or {}
  for k, v in pairs(classes) do
    data[k] = data[k] or {}
  end
end

function configuration_changed(cfg)
  if cfg.mod_changes then
    local changes = cfg.mod_changes["UsefulCombinators"]
    if changes then
      init()
    end
  end
end

script.on_init(init)
script.on_load(init)
script.on_configuration_changed(configuration_changed)
script.on_event(defines.events.on_tick, tick)
script.on_event(defines.events.on_built_entity, entity_built)
script.on_event(defines.events.on_robot_built_entity, entity_built)
script.on_event(defines.events.on_preplayer_mined_item, entity_removed)
script.on_event(defines.events.on_robot_pre_mined, entity_removed)
script.on_event(defines.events.on_entity_died, entity_removed)