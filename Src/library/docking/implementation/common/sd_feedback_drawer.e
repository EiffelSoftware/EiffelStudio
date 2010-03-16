note
	description: "Objects that draw feedback when user dragging a window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_DRAWER

create
	make

feature
	make
			-- Creation method
		do
			create internal_shared
			create feedback_rect.make
			create line_drawer.make
		end

feature -- Basic operations

	draw_pixmap (a_screen_x, a_screen_y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw a pixmap at desktop
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			line_drawer.screen.set_copy_mode
			line_drawer.screen.draw_pixmap (a_screen_x, a_screen_y, a_pixmap)
		end

	draw_pixmap_with_mask (a_screen_x, a_screen_y: INTEGER; a_target_pixmap, a_mask, orignal_screen: EV_PIXMAP)
			-- Draw `a_target_pixmap' with mask which is `a_mask'
		local
			l_buffer: EV_PIXMAP
			l_rect: EV_RECTANGLE
		do
			create l_rect.make (a_screen_x, a_screen_y, a_target_pixmap.width, a_target_pixmap.height)
			l_buffer := orignal_screen.sub_pixmap (l_rect)

			l_buffer.set_invert_mode
			l_buffer.draw_pixmap (0, 0, a_target_pixmap)
			l_buffer.set_and_mode
			l_buffer.draw_pixmap (0, 0, a_mask)
			l_buffer.set_invert_mode
			l_buffer.draw_pixmap (0, 0, a_target_pixmap)

			line_drawer.screen.set_copy_mode
			line_drawer.screen.draw_pixmap (a_screen_x, a_screen_y, l_buffer)
		end

	draw_pixmap_by_colors (a_screen_x, a_screen_y: INTEGER; a_colors: SPECIAL [SPECIAL [INTEGER]])
			-- Draw a pixmap on desktop by colors, black is discarded
		require
			a_pixmap_not_void: a_colors /= Void
		local
			i, j, j_count, t_count: INTEGER
			l_item: SPECIAL [INTEGER]
			r, g, b: INTEGER
			l_pixmap: EV_PIXMAP
			l_width: INTEGER
			l_color: EV_COLOR
			l_edge_found, l_white_found: BOOLEAN
			first_draw_stop_point: ARRAYED_LIST [INTEGER]
		do
			if a_colors.count /= 0 then
				l_width := a_colors.item (0).count // 3
				line_drawer.screen.set_copy_mode
				l_pixmap := line_drawer.screen.sub_pixmap (create {EV_RECTANGLE}.make (a_screen_x, a_screen_y, l_width, a_colors.count))
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
							i := 0
							t_count := l_item.count // 3
							l_edge_found := false
							create first_draw_stop_point.make (10)
						until
							i >= t_count
						loop
							r := l_item.item (3 * i)
							g := l_item.item (3 * i + 1)
							b := l_item.item (3 * i + 2)
							if r /= 255 or g /= 255 or b /= 255 then
								create l_color.make_with_8_bit_rgb (r, g, b)
								if not l_edge_found then
									if l_color.lightness <= edge_lightness then
										l_pixmap.set_copy_mode
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i, j)
										l_edge_found := true
										first_draw_stop_point.extend (i)
									else
										l_pixmap.set_and_mode
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i, j)
									end
								end
							else
								l_edge_found := false
							end
							i := i + 1
						end
							-- Draw backwards
						from
							i := t_count - 1
							l_white_found := true
							first_draw_stop_point.finish
							l_edge_found := false
						until
							i <= 0 or first_draw_stop_point.is_empty
						loop
							r := l_item.item (3 * i)
							g := l_item.item (3 * i + 1)
							b := l_item.item (3 * i + 2)
							if r /= 255 or g /= 255 or b /= 255 then
								if first_draw_stop_point.off or first_draw_stop_point.item = i then
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
										l_pixmap.draw_point (i, j)
										l_edge_found := true
									else
										l_pixmap.set_and_mode
										l_pixmap.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
										l_pixmap.draw_point (i, j)
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
				line_drawer.screen.draw_pixmap (a_screen_x, a_screen_y, l_pixmap)
			end
		end

	draw_line_area (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a vertical line on the screen
		do
			line_drawer.draw_line_area (a_start_x, a_start_y, a_width, a_height)
		end

	reset_feedback_clearing
			-- Clear feedback
		do
			line_drawer.reset_feedback_clearing
		end

	clear
			-- Clear feedback rectangle
		do
			feedback_rect.clear
			line_drawer.reset_feedback_clearing
		end

	draw_red_rectangle (left, top, width, height: INTEGER)
			-- Draw red rectangle
		do
			line_drawer.screen.set_foreground_color ((create {EV_STOCK_COLORS}).red)
			line_drawer.screen.draw_rectangle (left, top, width, height)
		end

	draw_rectangle (a_left, a_top, a_width, a_height, a_line_width: INTEGER)
			-- Draw a rectangle on the screen which center is blank
		require
			line_width_valid: a_line_width > 0
		do
			line_drawer.draw_rectangle (a_left, a_top, a_width, a_height, a_line_width)
		end

	draw_transparency_rectangle (a_left, a_top, a_width, a_height: INTEGER)
			-- Draw transparency rectangle
		do
			feedback_rect.show

			feedback_rect.set_area (create {EV_RECTANGLE}.make (a_left, a_top, a_width, a_height))
		end

	draw_transparency_rectangle_for_tab (a_top_rect, a_bottom_rect: EV_RECTANGLE)
			-- Draw transparency rectangle for tab indicator
		do
			feedback_rect.show
			feedback_rect.set_tab_area (a_top_rect, a_bottom_rect)
		end

feature -- Query

	feedback_rect: SD_FEEDBACK_RECT
			-- Feedback rectangle window

	line_drawer: SD_LINE_DRAWER
			-- Drawer to draw lines

feature {NONE} -- Implementation

	edge_lightness: REAL = 0.65
			-- Lightness to to identify edge of icon

	internal_shared: SD_SHARED;
			-- All singletons

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
