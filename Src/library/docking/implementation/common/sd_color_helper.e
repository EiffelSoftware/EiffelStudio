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
			-- Draw color changed gradually on `a_drawing_area' from start x position.
		do
			draw_color_change_gradually_from (a_drawing_area, 0, a_color, a_drawing_area.background_color)
		end

	draw_color_change_gradually_from (a_drawing_area: EV_DRAWING_AREA; a_start_x: INTEGER; a_start_color, a_to_color: EV_COLOR) is
			-- Draw color changed gradually on `a_drawing_area' from a_start_x.
		local
			l_rect: EV_RECTANGLE
		do
			create l_rect.make (a_start_x, 0, a_drawing_area.width - a_start_x, a_drawing_area.height)
			draw_color_change_gradually_in_area (a_drawing_area, l_rect, a_start_color, a_to_color)
		end

	draw_color_change_gradually_in_area (a_drawing_area: EV_DRAWING_AREA; a_area: EV_RECTANGLE; a_start_color, a_to_color: EV_COLOR) is
			--
		require
			not_void: a_area /= Void
		local
			l_count: INTEGER
			l_pixmap: EV_PIXMAP
		do
			if a_area.width >0 and a_area.height > 0 then
				from
					create l_pixmap.make_with_size (a_area.width, a_area.height)
				until
					l_count >= l_pixmap.width
				loop
					l_pixmap.set_foreground_color (color_mix (a_start_color, a_to_color, (1 - l_count / l_pixmap.width)))
					l_pixmap.draw_segment (l_count, a_area.top, l_count, a_area.bottom)
					l_count := l_count + 1
				end
				a_drawing_area.draw_pixmap (a_area.left, a_area.top, l_pixmap)
			end
		end

	colorize_with (a_color: EV_COLOR a_colors: SPECIAL [SPECIAL [INTEGER]]) is
			-- Draw a pixmap on desktop by colors, black is discarded.
		require
			a_pixmap_not_void: a_colors /= Void
			a_color_not_void: a_color /= Void
		local
			i, j, j_count, t_count: INTEGER
			l_item: SPECIAL [INTEGER]
			r, g, b: INTEGER
			l_color: EV_COLOR
			l_lightness: REAL
			l_color_helper: SD_COLOR_HELPER
			l_light_diff: REAL
		do
			create l_color_helper
			l_lightness := a_color.lightness
			from
				j := 0
				j_count := a_colors.count
			until
				j >= j_count
			loop
				l_item := a_colors.item (j)
				if l_item /= Void then
					from
						i := 0
						t_count := l_item.count // 3
					until
						i >= t_count
					loop
						r := l_item.item (3 * i)
						g := l_item.item (3 * i + 1)
						b := l_item.item (3 * i + 2)
						if r /= 255 or g /= 255 or b /= 255 then
							create l_color.make_with_8_bit_rgb (r, g, b)
							l_light_diff := l_color.lightness - l_lightness
							if l_lightness = 0 or l_lightness = 1 then
								if l_lightness = 0 then
									create l_color.make_with_8_bit_rgb (0, 0, 0)
								else
									create l_color.make_with_8_bit_rgb (255, 255, 255)
								end
							else
								if l_light_diff > 0 then
									l_color := l_color_helper.build_color_with_lightness (a_color ,l_light_diff / (1 - l_lightness))
								else
									l_color := l_color_helper.build_color_with_lightness (a_color ,l_light_diff / l_lightness)
								end
							end
							l_item.put (l_color.red_8_bit, 3 * i)
							l_item.put (l_color.green_8_bit, 3 * i + 1)
							l_item.put (l_color.blue_8_bit, 3 * i + 2)
						end
						i := i + 1
					end
				end
				j := j + 1
			end
		end

	text_color_by (a_background_color: EV_COLOR): EV_COLOR is
			-- Text color calculated base on a_background_color.
		do
			if a_background_color.lightness > 0.5 then
				Result := (create {EV_STOCK_COLORS}).black
			else
				Result := (create {EV_STOCK_COLORS}).white
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
