indexing
	description: "Draw half-tone lines (include rectangles) on windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_LINE_DRAWER

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method
		do
			create internal_shared
--			screen := internal_shared.feedback.screen
			create screen
		end

feature -- Command

	draw_line_area (a_start_x, a_start_y, a_width, a_height: INTEGER) is
			-- Draw a half-tone line on screen.
		do
			if last_half_tone_pixmap = Void or
				last_half_tone_pixmap.width /= a_width or last_half_tone_pixmap.height /= a_height then
				last_half_tone_pixmap := half_tone_pixmap (a_width, a_height)
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, last_half_tone_pixmap)
		end

	draw_rectangle (left, top, width, height, line_width: INTEGER) is
			-- Draw a rectangle on screen which center is blank.
		require
			line_width_valid: line_width > 0
		do
			if internal_last_feedback_left /= 0 and internal_last_feedback_top /= 0
				and internal_last_feedback_width /= 0 and internal_last_feedback_height /= 0 then
				clear_last_feedback
			end
			internal_last_feedback_left := left
			internal_last_feedback_top := top
			internal_last_feedback_width := width
			internal_last_feedback_height := height

			draw_rectangle_internal (left, top, width, height, line_width)
		end

	reset_feedback_clearing is
			-- Redefine
		do
			if internal_last_feedback_top /= 0 and internal_last_feedback_left /=0
				and internal_last_feedback_width /= 0 and internal_last_feedback_height /= 0 then
				clear_last_feedback
				internal_last_feedback_top := 0
				internal_last_feedback_left := 0
				internal_last_feedback_width := 0
				internal_last_feedback_height := 0
			end
		end

feature {NONE} -- Implementation for draw_rectangle

	draw_rectangle_internal_top (a_start_x, a_start_y, a_width, a_height: INTEGER) is
			-- Draw a vertical line on the screen.
		do
			if last_half_tone_pixmap_top = Void or
				last_half_tone_pixmap_top.width /= a_width or last_half_tone_pixmap_top.height /= a_height then
				last_half_tone_pixmap_top := half_tone_pixmap (a_width, a_height)
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, last_half_tone_pixmap_top)
		end

	draw_rectangle_internal_bottom (a_start_x, a_start_y, a_width, a_height: INTEGER) is
			-- Draw a vertical line on the screen.
		do
			if last_half_tone_pixmap_bottom = Void or
				last_half_tone_pixmap_bottom.width /= a_width or last_half_tone_pixmap_bottom.height /= a_height then
				last_half_tone_pixmap_bottom := half_tone_pixmap (a_width, a_height)
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, last_half_tone_pixmap_bottom)
		end

	draw_rectangle_internal_left (a_start_x, a_start_y, a_width, a_height: INTEGER) is
			-- Draw a vertical line on the screen.
		do
			if last_half_tone_pixmap_left = Void or
				last_half_tone_pixmap_left.width /= a_width or last_half_tone_pixmap_left.height /= a_height then
				last_half_tone_pixmap_left := half_tone_pixmap (a_width, a_height)
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, last_half_tone_pixmap_left)
		end

	draw_rectangle_internal_right (a_start_x, a_start_y, a_width, a_height: INTEGER) is
			-- Draw a vertical line on the screen.
		do
			if last_half_tone_pixmap_right = Void or
				last_half_tone_pixmap_right.width /= a_width or last_half_tone_pixmap_right.height /= a_height then
				last_half_tone_pixmap_right := half_tone_pixmap (a_width, a_height)
			end
			screen.set_invert_mode
			screen.draw_pixmap (a_start_x, a_start_y, last_half_tone_pixmap_right)
		end

	last_half_tone_pixmap_top, last_half_tone_pixmap_bottom, last_half_tone_pixmap_left, last_half_tone_pixmap_right: EV_PIXMAP
			-- Pixmap last dran for `draw_rectangle'.

feature {NONE} -- Implementation

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

	internal_last_feedback_left, internal_last_feedback_top, internal_last_feedback_width, internal_last_feedback_height: INTEGER

	clear_last_feedback is
			-- Clear last drawn feedback rectangle.
		do
			draw_rectangle_internal (internal_last_feedback_left, internal_last_feedback_top, internal_last_feedback_width, internal_last_feedback_height, internal_shared.line_width)

		end

	draw_rectangle_internal (left, top, width, height, line_width: INTEGER) is
		do
			-- Draw window area, top one.
			draw_rectangle_internal_top (left, top, width, line_width)
			-- Draw window area, bottom one.
			draw_rectangle_internal_bottom (left, top + height - line_width, width, line_width)
			-- Draw window area, left one.
			draw_rectangle_internal_left (left, top + line_width, line_width, height - 2 * line_width)
			-- Draw window area, right one.
			draw_rectangle_internal_right (left + width - line_width, top + line_width, line_width, height - 2 * line_width)
		end

feature {NONE}  -- Implementation

	last_half_tone_pixmap: EV_PIXMAP
			-- Half tone pixmap last time drawn.

	screen: EV_SCREEN
			-- Screen to draw.

	internal_shared: SD_SHARED;
			-- All singletons.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
