require ("util")
function make_4way_animation_from_spritesheet(animation)
	local function make_animation_layer(idx, anim)
		local start_frame = (anim.frame_count or 1) * idx
		local x = 0
		local y = 0
		if anim.line_length then
			y = anim.height * math.floor(start_frame / (anim.line_length or 1))
		else
			x = idx * anim.width
		end
		return
		{
			filename = anim.filename,
			priority = anim.priority or "high",
			x = x,
			y = y,
			width = anim.width,
			height = anim.height,
			frame_count = anim.frame_count or 1,
			line_length = anim.line_length,
			repeat_count = anim.repeat_count,
			shift = anim.shift,
			draw_as_shadow = anim.draw_as_shadow,
			force_hr_shadow = anim.force_hr_shadow,
			apply_runtime_tint = anim.apply_runtime_tint,
			scale = anim.scale or 1,
			tint = anim.tint
		}
	end

	local function make_animation_layer_with_hr_version(idx, anim)
		local anim_parameters = make_animation_layer(idx, anim)
		if anim.hr_version and anim.hr_version.filename then
			anim_parameters.hr_version = make_animation_layer(idx, anim.hr_version)
		end
		return anim_parameters
	end

	local function make_animation(idx)
		if animation.layers then
			local tab = { layers = {} }
			for k,v in ipairs(animation.layers) do
				table.insert(tab.layers, make_animation_layer_with_hr_version(idx, v))
			end
			return tab
		else
			return make_animation_layer_with_hr_version(idx, animation)
		end
	end
	
	return
	{
		north = make_animation(0),
		east = make_animation(1),
		south = make_animation(2),
		west = make_animation(3)
	}
end

function custom(name, count)
	local path = "__UsefulCombinators__/graphics/entity/combinator/"
	local combinator = {
		type = "constant-combinator",
		name = name,
		icon = "__UsefulCombinators__/graphics/icons/" .. name .. ".png",
		icon_size = 32,
		flags = {"placeable-neutral", "player-creation"},
		minable = {mining_time = 0.1, result = name},
		max_health = 120,
		corpse = "constant-combinator-remnants",
		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		item_slot_count = count or 1,
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		activity_led_light =
		{
			intensity = 0.8,
			size = 1,
			color = {r = 1.0, g = 1.0, b = 1.0}
		},
		activity_led_light_offsets =
		{
			{0.296875, -0.40625},
			{0.25, -0.03125},
			{-0.296875, -0.078125},
			{-0.21875, -0.46875}
		},
		circuit_wire_max_distance = 9,
		sprites = make_4way_animation_from_spritesheet(
		{ layers =
			{
				{
					filename = path .. name .. ".png",
					width = 58,
					height = 52,
					frame_count = 1,
					shift = util.by_pixel(0, 5),
					hr_version =
					{
						scale = 0.5,
						filename = path .. "hr-" .. name .. ".png",
						width = 114,
						height = 102,
						frame_count = 1,
						shift = util.by_pixel(0, 5)
					}
				},
				{
					filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
					width = 50,
					height = 34,
					frame_count = 1,
					shift = util.by_pixel(9, 6),
					draw_as_shadow = true,
					hr_version =
					{
						scale = 0.5,
						filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
						width = 98,
						height = 66,
						frame_count = 1,
						shift = util.by_pixel(8.5, 5.5),
						draw_as_shadow = true
					}
				}
			}
		}),
		activity_led_sprites =
		{
			north =
			{
				filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
				width = 8,
				height = 6,
				frame_count = 1,
				shift = util.by_pixel(9, -12),
				hr_version =
				{
					scale = 0.5,
					filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-N.png",
					width = 14,
					height = 12,
					frame_count = 1,
					shift = util.by_pixel(9, -11.5)
				}
			},
			east =
			{
				filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
				width = 8,
				height = 8,
				frame_count = 1,
				shift = util.by_pixel(8, 0),
				hr_version =
				{
					scale = 0.5,
					filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-E.png",
					width = 14,
					height = 14,
					frame_count = 1,
					shift = util.by_pixel(7.5, -0.5)
				}
			},
			south =
			{
				filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
				width = 8,
				height = 8,
				frame_count = 1,
				shift = util.by_pixel(-9, 2),
				hr_version =
				{
					scale = 0.5,
					filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-S.png",
					width = 14,
					height = 16,
					frame_count = 1,
					shift = util.by_pixel(-9, 2.5)
				}
			},
			west =
			{
				filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
				width = 8,
				height = 8,
				frame_count = 1,
				shift = util.by_pixel(-7, -15),
				hr_version =
				{
					scale = 0.5,
					filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-W.png",
					width = 14,
					height = 16,
					frame_count = 1,
					shift = util.by_pixel(-7, -15)
				}
			}
		},
		circuit_wire_connection_points =
		{
			{
				shadow =
				{
					red = util.by_pixel(7, -6),
					green = util.by_pixel(23, -6)
				},
				wire =
				{
					red = util.by_pixel(-8.5, -17.5),
					green = util.by_pixel(7, -17.5)
				}
			},
			{
				shadow =
				{
					red = util.by_pixel(32, -5),
					green = util.by_pixel(32, 8)
				},
				wire =
				{
					red = util.by_pixel(16, -16.5),
					green = util.by_pixel(16, -3.5)
				}
			},
			{
				shadow =
				{
					red = util.by_pixel(25, 20),
					green = util.by_pixel(9, 20)
				},
				wire =
				{
					red = util.by_pixel(9, 7.5),
					green = util.by_pixel(-6.5, 7.5)
				}
			},
			{
				shadow =
				{
					red = util.by_pixel(1, 11),
					green = util.by_pixel(1, -2)
				},
				wire =
				{
					red = util.by_pixel(-15, -0.5),
					green = util.by_pixel(-15, -13.5)
				}
			}
		}
	}
	return combinator
end

data:extend({
	custom("uc-timer-combinator"),
	custom("uc-counting-combinator"),
	custom("uc-random-combinator"),
	custom("uc-converter-combinator", 5),
	custom("uc-min-combinator"),
	custom("uc-max-combinator"),
  custom("uc-and-gate-combinator"),
  custom("uc-or-gate-combinator"),
	custom("uc-not-gate-combinator"),
	custom("uc-nand-gate-combinator"),
  custom("uc-nor-gate-combinator"),
  custom("uc-xor-gate-combinator"),
  custom("uc-xnor-gate-combinator"),
  custom("uc-detector-combinator"),
  custom("uc-sensor-combinator"),
  custom("uc-railway-combinator"),
  custom("uc-color-combinator", 6),
  custom("uc-emitter-combinator", 0),
  custom("uc-receiver-combinator", 5),
  custom("uc-power-combinator", 4),
  custom("uc-daytime-combinator", 3),
  custom("uc-pollution-combinator"),
  custom("uc-statistic-combinator", 5)
})