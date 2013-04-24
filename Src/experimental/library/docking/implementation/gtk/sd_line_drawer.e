note
	description: "Draw normal lines (include rectangles) on gtk."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_LINE_DRAWER

create
	make

feature {NONE}  -- Initlization

	make
			-- Creation method
		do
			create internal_shared
--			screen := internal_shared.feedback.screen
			create screen
		end

feature -- Command

	draw_line_area (a_start_x, a_start_y, a_width, a_height: INTEGER)
			-- Draw a half-tone line on screen.
		do
			screen.set_invert_mode
			screen.fill_rectangle (a_start_x, a_start_y, a_width, a_height)
		end

	draw_rectangle (left, top, width, height, line_width: INTEGER)
			-- Draw a rectangle on screen which center is blank.
		require
			line_width_valid: line_width > 0
		do
			clear_last_feedback
			internal_last_feedback_left := left
			internal_last_feedback_top := top
			internal_last_feedback_width := width
			internal_last_feedback_height := height

			screen.set_invert_mode
			screen.draw_rectangle (left, top, width, height)
		end

	reset_feedback_clearing
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

feature {SD_FEEDBACK_DRAWER} -- Implementation

	clear_last_feedback
			-- Clear last drawn rectangle.
		do
				screen.set_invert_mode
				screen.draw_rectangle (internal_last_feedback_left, internal_last_feedback_top, internal_last_feedback_width, internal_last_feedback_height)
		end

	internal_last_feedback_top, internal_last_feedback_left, internal_last_feedback_width, internal_last_feedback_height: INTEGER
			-- Last drawing postion which are used by `reset_feedback_clearing'.

	internal_shared: SD_SHARED
			-- All sigletons.

	screen: EV_SCREEN
			-- Screen to draw.

invariant

	internal_shared_not_void: internal_shared /= Void
	screen_not_void: screen /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
