
local data = {}
local classes = {}

local function save()
  global.data = data
end

classes["timer-combinator"] = {
  on_place = function(entity) return { entity = entity } end,
  on_destroy = function() end,
  on_tick = function(object)
    local control = object.entity.get_control_behavior()
    if control then
      local params = control.parameters.parameters
      if params[1] and params[1]["count"] then
        local count,interval,mod,reset = params[1]["count"] or 1, params[2]["count"] or 1, params[3]["count"] or 1, params[4]["count"] or -1
        if count and control.enabled then
          if (mod < 1) then mod = 1 end
          if (mod > 15) then mod = 15 end
          if (interval < 1) then interval = 1 end
          if (interval > 15) then interval = 15 end
          local t = math.floor(60 * (interval / mod))
          if t < 1 then t = 1 end
          if (game.tick % t) == 1 then
            local out = -1
            if count >= reset then
              count = 0
              out = 1
            end
            control.parameters = {
              parameters = {
                {signal = {type = "virtual", name = "counting-signal"}, count = (count + 1), index = 1},
                {signal = {type = "virtual", name = "interval-signal"}, count = interval, index = 2},
                {signal = {type = "virtual", name = "time-mod-signal"}, count = mod, index = 3},
                {signal = {type = "virtual", name = "reset-signal"}, count = reset, index = 4},
                {signal = {type = "virtual", name = "output-signal"}, count = out, index = 5}
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
            {signal = {type = "virtual", name = "output-signal"}, count = -1, index = 5}
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
      if params[1] and params[1]["count"] then
        local count,reset = params[1]["count"] or 1, params[2]["count"] or -1
        if count and control.enabled then
          if (reset <= 0) then reset = -1 end
            local out = -1
            if reset > 0 and count >= reset then
              count = 0
              out = 1
            end
            control.parameters = {
              parameters = {
                {signal = {type = "virtual", name = "counting-signal"}, count = count + get_count(control), index = 1},
                {signal = {type = "virtual", name = "reset-signal"}, count = reset, index = 2},
                {signal = {type = "virtual", name = "output-signal"}, count = out, index = 3}
              }
            }
        end
      else
        control.parameters = {
          parameters = {
            {signal = {type = "virtual", name = "counting-signal"}, count = 1, index = 1},
            {signal = {type = "virtual", name = "reset-signal"}, count = -1, index = 2},
            {signal = {type = "virtual", name = "output-signal"}, count = -1, index = 3}
          }
        }
      end
    end
  end
}

--[[classes["pulse-decider-combinator"] = {
  on_place = function(entity)
    local control = entity.get_control_behavior()
    if control then
      --do something
    end
    return { entity = entity }
  end,
  on_destroy = function() end,
  on_tick = function(object) return end
}]]

function get_count(control)
  local red = control.get_circuit_network(defines.wire_type.red)
  local green = control.get_circuit_network(defines.wire_type.green)
  local val = 0
  if red then
    val = red.get_signal({type = "virtual", name = "plus-one-signal"}) or 0
  end
  if green then 
    val = val + (green.get_signal({type = "virtual", name = "plus-one-signal"}) or 0)
  end
  return val
end

local function entity_built(event)
  if classes[event.created_entity.name] ~= nil then
    local tab = data[event.created_entity.name]
    table.insert(tab, classes[event.created_entity.name].on_place(event.created_entity))
    data[event.created_entity.name] = tab
    save()
  end
end

local function entity_removed(event)
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

local function tick()
  for k,v in pairs(classes) do
    for q,i in pairs(data[k]) do
      if i.entity.valid then
        v.on_tick(i, q)
      end
    end
  end
end

local function init()
  data = global.data or {}
  for k, v in pairs(classes) do
    data[k] = data[k] or {}
  end
end

script.on_init(init)
script.on_load(init)
script.on_event(defines.events.on_tick, tick)
script.on_event(defines.events.on_built_entity, entity_built)
script.on_event(defines.events.on_robot_built_entity, entity_built)
script.on_event(defines.events.on_preplayer_mined_item, entity_removed)
script.on_event(defines.events.on_robot_pre_mined, entity_removed)
script.on_event(defines.events.on_entity_died, entity_removed)
