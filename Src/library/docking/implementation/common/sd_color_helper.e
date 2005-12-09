indexing
	description: "Algorithm of color calculating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_COLOR_HELPER

feature -- Saturation

	build_color_with_lightness (a_color: EV_COLOR; a_lightness_increase: REAL): EV_COLOR is
			-- Make a color from `a_color' with `a_lightness_increase'.
		require
			a_lightness_valid: a_lightness_increase <= 1 and a_lightness_increase >= -1
			a_color_attached: a_color /= Void
		local
			new_r, new_g, new_b: INTEGER
		do
			if a_lightness_increase > 0 then
				new_r := light_increase (a_color.red_8_bit, a_lightness_increase)
				new_g := light_increase (a_color.green_8_bit, a_lightness_increase)
				new_b := light_increase (a_color.blue_8_bit, a_lightness_increase)
			else
				new_r := light_decrease (a_color.red_8_bit, a_lightness_increase)
				new_g := light_decrease (a_color.green_8_bit, a_lightness_increase)
				new_b := light_decrease (a_color.blue_8_bit, a_lightness_increase)
			end
			create Result.make_with_8_bit_rgb (new_r, new_g, new_b)
		end

	draw_round_before (a_drawing_area: EV_DRAWING_AREA; a_color: EV_COLOR) is
			-- Draw round ellipse before.
		do
			a_drawing_area.clear
			a_drawing_area.set_foreground_color (a_color)
			a_drawing_area.fill_ellipse (0, 0, a_drawing_area.width * 2, a_drawing_area.height * 2)
		end

	draw_round_after (a_drawing_area: EV_DRAWING_AREA; a_color: EV_COLOR) is
			-- Draw round ellipse after.
		do
			a_drawing_area.clear
			a_drawing_area.set_foreground_color (a_color)
			a_drawing_area.fill_ellipse (- a_drawing_area.width, 0, a_drawing_area.width * 2, a_drawing_area.height * 2)
		end

	draw_color_change_gradually (a_drawing_area: EV_DRAWING_AREA; a_color: EV_COLOR) is
			-- Draw color changed gradually on `a_drawing_area'.
		local
			l_count: INTEGER
			l_pixmap: EV_PIXMAP
			l_color: EV_COLOR
		do
			if a_drawing_area.width >0 and a_drawing_area.height > 0 then
				from
					create l_pixmap.make_with_size (a_drawing_area.width, a_drawing_area.height)
					l_color := a_drawing_area.background_color
					a_drawing_area.clear
				until
					l_count > a_drawing_area.width
				loop
					l_pixmap.set_foreground_color (color_mix (a_color, l_color, (1 - l_count / l_pixmap.width)))
					l_pixmap.draw_segment (l_count, 0, l_count, l_pixmap.height)
					l_count := l_count + 1
				end
				a_drawing_area.draw_pixmap (0, 0, l_pixmap)				
			end
		end

feature {NONE} -- Implementation

	color_mix (a_first_color, a_second_color: EV_COLOR; a_percent: REAL): EV_COLOR is
			-- Color mix with `a_first_color' and `a_second_color'.
		require
			a_first_color_not_void: a_first_color /= Void
			a_second_color_not_void: a_second_color /= Void
			a_percent_valid: a_percent >= 0 and a_percent <= 1
		local
			l_r, l_g, l_b: REAL
		do
			l_r := a_first_color.red * a_percent + a_second_color.red * (1 - a_percent)
			l_g := a_first_color.green * a_percent + a_second_color.green * (1 - a_percent)
			l_b := a_first_color.blue * a_percent + a_second_color.blue * (1 - a_percent)
			create Result.make_with_rgb (l_r, l_g, l_b)
		ensure
			not_void: Result /= Void
		end

	light_increase (a_color: INTEGER; a_lightness_increase: REAL): INTEGER is
			-- Increas light.
		do
			Result := (a_color * (1 - a_lightness_increase) + 255 * a_lightness_increase).rounded
		end

	light_decrease (a_color: INTEGER; a_lightness_increase: REAL): INTEGER is
			-- Decrease light.
		do
			Result := (a_color * (1 + a_lightness_increase)).rounded
		end
end
