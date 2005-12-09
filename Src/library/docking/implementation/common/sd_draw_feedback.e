indexing
	description: "Objects that draw feedback when user dragging a window."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_DRAWER

feature -- Basic operations

	draw_pixmap (a_screen_x, a_screen_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw a pixmap at desktop.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			screen.set_copy_mode
			screen.draw_pixmap (a_screen_x, a_screen_y, a_pixmap)
		end

	draw_pixmap_by_colors (a_screen_x, a_screen_y: INTEGER; a_colors: SPECIAL [TUPLE]) is
			-- Draw a pixmap on desktop by colors, black is discarded.
		require
			a_pixmap_not_void: a_colors /= Void
		local
			i, j, j_count, t_count: INTEGER
			l_item: TUPLE
			r, g, b: INTEGER
			l_pixmap: EV_PIXMAP
			l_width: INTEGER
			l_color: EV_COLOR
			l_edge_found, l_white_found: BOOLEAN
			first_draw_stop_point: ARRAYED_LIST [INTEGER]
		do
			if a_colors.count /= 0 then
				l_width := a_colors.item (0).count // 3
				screen.set_copy_mode
				l_pixmap := screen.sub_pixmap (create {EV_RECTANGLE}.make (a_screen_x, a_screen_y, l_width, a_colors.count))
				from
					j := 0
					j_count := a_colors.count
				until
					j >= j_count
				loop
					l_item := a_colors.item (j)
					if l_item /= Void then
							-- Draw forwards
						from
							i := 1
							t_count := l_item.count // 3
							l_edge_found := false
							create first_draw_stop_point.make (10)
						until
							i > t_count
						loop
							r := l_item.integer_32_item (3 * (i - 1) + 1)
							g := l_item.integer_32_item (3 * (i - 1) + 2)
							b := l_item.integer_32_item (3 * (i - 1) + 3)
							if r /= 255 or g /= 255 or b /= 255 then
								create l_color.make_with_8_bit_rgb (r, g, b)
								if not l_edge_found then
									if l_color.lightness <= edge_lightness then
										l_pixmap.set_copy_mode
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i - 1, j)
										l_edge_found := true
										first_draw_stop_point.extend (i)
									else
										l_pixmap.set_and_mode
	--										r := (r * color_percentage + l_pixmap.implementation.raw_image_data.pixel (i - 1, j - 1).red_8_bit * (1 - color_percentage)).floor
	--										g := (g * color_percentage + l_pixmap.implementation.raw_image_data.pixel (i - 1, j - 1).green_8_bit * (1 - color_percentage)).floor
	--										b := (b * color_percentage + l_pixmap.implementation.raw_image_data.pixel (i - 1, j - 1).blue_8_bit * (1 - color_percentage)).floor
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i - 1, j)
									end
								end
							else
								l_edge_found := false
							end
							i := i + 1
						end
							-- Draw backwards
						from
							i := t_count
							l_white_found := true
							first_draw_stop_point.finish
							l_edge_found := false
						until
							i < 1 or first_draw_stop_point.is_empty
						loop
							r := l_item.integer_32_item (3 * (i - 1) + 1)
							g := l_item.integer_32_item (3 * (i - 1) + 2)
							b := l_item.integer_32_item (3 * (i - 1) + 3)
							if r /= 255 or g /= 255 or b /= 255 then
								if first_draw_stop_point.off or first_draw_stop_point.item.is_equal (i) then
									l_white_found := false
									l_edge_found := false
									if not first_draw_stop_point.off then
										first_draw_stop_point.back
									end
								end
								if l_white_found then
									create l_color.make_with_8_bit_rgb (r, g, b)
									if l_color.lightness <= edge_lightness or l_edge_found then
										l_pixmap.set_copy_mode
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i - 1, j)
										l_edge_found := true
									else
										l_pixmap.set_and_mode
--											r := (r * color_percentage + l_pixmap.implementation.raw_image_data.pixel (i - 1, j - 1).red_8_bit * (1 - color_percentage)).floor
--											g := (g * color_percentage + l_pixmap.implementation.raw_image_data.pixel (i - 1, j - 1).green_8_bit * (1 - color_percentage)).floor
--											b := (b * color_percentage + l_pixmap.implementation.raw_image_data.pixel (i - 1, j - 1).blue_8_bit * (1 - color_percentage)).floor
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i - 1, j)
									end
								end
							else
								l_white_found := true
							end
							i := i - 1
						end
					end
					j := j + 1
				end
				screen.draw_pixmap (a_screen_x, a_screen_y, l_pixmap)
			end
		end

	draw_shadow_rectangle (a_start_x, a_start_y, a_width, a_height: INTEGER) is
			-- Draw a vertical line on the screen.
		do
			if last_half_tone_pixmap = Void or
				last_half_tone_pixmap.width /= a_width or last_half_tone_pixmap.height /= a_height then
				last_half_tone_pixmap := half_tone_pixmap (a_width, a_height)
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, last_half_tone_pixmap)
		end

	draw_line (a_x_1, a_y_1, a_x_2, a_y_2: INTEGER) is
			-- Draw a line on screen.
		do
			screen.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			screen.draw_segment (a_x_1, a_y_1, a_x_2, a_y_2)
		end

	clear_screen is
			-- Maximum amount of bytes the run-time can allocate.
		do
		end

	draw_red_rectangle (left, top, width, height: INTEGER) is
			-- Draw red rectangle.
		do
			screen.set_foreground_color ((create {EV_STOCK_COLORS}).red)
			screen.draw_rectangle (left, top, width, height)
		end

	draw_rectangle (left, top, width, height, line_width: INTEGER) is
			-- Draw a rectangle on the screen which center is blank.
		require
			line_width_valid: line_width > 0
		do
			-- Draw window area, top one.
			draw_shadow_rectangle (left, top, width, line_width)
			-- Draw window area, bottom one.
			draw_shadow_rectangle (left, top + height - line_width, width, line_width)
			-- Draw window area, left one.
			draw_shadow_rectangle (left, top, line_width, height)
			-- Draw window area, right one.
			draw_shadow_rectangle (left + width - line_width, top, line_width, height)
		end

	draw_transparency_rectangle (a_left, a_top, a_width, a_height: INTEGER) is
			-- Draw transparency rectangle.
		local
			l_pixmap: EV_PIXMAP
		do
			l_pixmap := internal_blue_pixmap
			l_pixmap.stretch (a_width, a_height)

			debug ("larry")
				io.put_string ("SD_FEEDBACK_DRAWER: draw_transparency_rectangle " + a_width.out + " " + a_height.out)
			end
			screen.set_and_mode
			screen.draw_pixmap (a_left, a_top, l_pixmap)
		end

	internal_blue_pixmap: EV_PIXMAP is
			-- Feedback pixmap when user dragging a SD_ZONE.
		local
--			l_grid: EV_GRID
--			l_file: FILE_NAME
		do
			if internal_blue_pixmap_cell.item = Void then
				create Result
				Result.set_with_named_file ("D:\Projects\NewDocking\images\blue.png")
--				create l_grid
--				Result.set_foreground_color (l_grid.focused_selection_color)
--				Result.fill_rectangle (0, 0, Result.width, Result.height)
--				create l_file.make_from_string ("temp.png")
--				Result.save_to_named_file (create {EV_PNG_FORMAT}, l_file)
--
--				create Result
--				Result.set_with_named_file ("temp.png")
				internal_blue_pixmap_cell.put (Result)
			else
				Result := internal_blue_pixmap_cell.item
			end
		ensure
			not_void: Result /= Void
		end

	internal_blue_pixmap_cell: CELL [EV_PIXMAP] is
			-- Singleton cell of internal blue pixmap
		once
			create Result
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	edge_lightness: REAL is 0.65
			-- Lightness to to identify edge of icon.

	screen: EV_SCREEN is
			-- Utility to draw things on screen.
			-- FIXIT: should use once, but it not work when relogin to Windows.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	half_tone_pixmap (a_width, a_height: INTEGER): EV_PIXMAP is
			-- Get a dot line pixmap.
		local
			l_pixmap: EV_PIXMAP
			l_x,l_y: INTEGER
			l_white, l_black: EV_COLOR
			l_black_or_white: BOOLEAN
		do
			create l_white.make_with_rgb (1, 1, 1)
			create l_black.make_with_rgb (0, 0, 0)
			create l_pixmap.make_with_size (a_width, a_height)
			from
				l_x := 0
			until
				l_x > a_width
			loop
				from
					l_y := 0
				until
					l_y > a_height
				loop
					if l_black_or_white then
						l_pixmap.set_foreground_color (l_white)
					else
						l_pixmap.set_foreground_color (l_black)
					end
					l_pixmap.draw_point (l_x, l_y)
					l_y := l_y + 1
					l_black_or_white := not l_black_or_white
				end
				l_x := l_x + 1
				if a_height \\ 2 /= 0 then
					l_black_or_white := not l_black_or_white
				end
			end
			Result := l_pixmap
		ensure
			not_void: Result /= Void
		end

	last_half_tone_pixmap: EV_PIXMAP
			-- Half tone pixmap last time drawn.
invariant


end
