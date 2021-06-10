note
	description: "Resize bar at side of SD_AUTO_HIDE_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_RESIZE_BAR

inherit
	EV_DRAWING_AREA

create
	make

feature {NONE} -- Initialization

	make (a_direction: INTEGER)
			-- Creation method
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			create internal_shared

			default_create

			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				set_minimum_size (internal_shared.resize_bar_width_height, internal_shared.resize_bar_width_height)
			else
				set_minimum_size (internal_shared.resize_bar_width_height, internal_shared.resize_bar_width_height)
			end

			direction := a_direction
			pointer_button_release_actions.extend (agent on_pointer_button_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_press_actions.extend (agent on_pointer_button_press)

			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				set_pointer_style (default_pixmaps.sizewe_cursor)
			elseif a_direction = {SD_ENUMERATION}.bottom or a_direction = {SD_ENUMERATION}.top then
				set_pointer_style (default_pixmaps.sizens_cursor)
			end

			expose_actions.extend (agent on_expose_action)
			set_background_color ((create {SD_SYSTEM_COLOR_IMP}.make).non_focused_selection_color)
		ensure
			a_direction_set: a_direction = direction
		end

feature -- Command

	set_resize_source (a_source: SD_RESIZE_SOURCE)
			-- Set `resize_source' with `a_source'
		require
			a_source_not_void: a_source /= Void
		do
			resize_source := a_source
		ensure
			a_source_set: resize_source = a_source
		end

feature -- Query

	resize_source: detachable SD_RESIZE_SOURCE
			-- The resizable window.

feature {NONE} -- Agents

	on_pointer_button_press (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle pointer button press
		local
			l_screen_boundary: like screen_boundary
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				if not resizing then
					resizing := True
					create l_screen_boundary
					screen_boundary := l_screen_boundary
					if attached resize_source as s then
						s.start_resize_operation (Current, l_screen_boundary)
					end
					debug ("docking")
						io.put_string ("%N start position: " + a_screen_x.out + ", " + a_screen_y.out)
					end
					internal_shared.feedback.draw_line_area (screen_x, screen_y, width, height)
					if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right  then
						last_screen_pointer_position := screen_x
					else
						last_screen_pointer_position := screen_y
					end
					internal_shared.setter.before_enable_capture
					enable_capture
					old_screen_x := screen_x;
					old_screen_y := a_screen_y;
				end

			end
		end

	on_expose_action (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle expose action
		local
			l_stock_colors: EV_STOCK_COLORS
		do
			start_drawing_session
			clear
			create l_stock_colors
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				set_foreground_color (l_stock_colors.white)
				draw_segment (0, 0, 0, height)
				set_foreground_color (l_stock_colors.black)
				draw_segment (width - 1, 0, width - 1, height - 1)
			else
				set_foreground_color (l_stock_colors.white)
				draw_segment (0, 0, width - 1, 0)
				set_foreground_color (l_stock_colors.black)
				draw_segment (0, height - 1, width - 1, height - 1)
			end
			end_drawing_session
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle the resize window action
		local
			l_left, l_right, l_top, l_bottom: INTEGER
		do
			if resizing and then attached screen_boundary as l_scr_boundary then
				-- Clear the graph last drawn

				clear_graph_last_drawn

				if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
					l_left := l_scr_boundary.left
					l_right := l_scr_boundary.right
					if a_screen_x > l_left and a_screen_x < l_right then
						last_screen_pointer_position := a_screen_x
					elseif a_screen_x <= l_left then
						last_screen_pointer_position := l_left
					else
						last_screen_pointer_position := l_right
					end
					internal_shared.feedback.draw_line_area (last_screen_pointer_position, screen_y, width, height)
				else
					l_top := l_scr_boundary.top
					l_bottom := l_scr_boundary.bottom
					if a_screen_y > l_top and a_screen_y < l_bottom then
						last_screen_pointer_position := a_screen_y
					elseif a_screen_y <= l_top then
						last_screen_pointer_position := l_top
					elseif a_screen_y >= l_bottom then
						last_screen_pointer_position := l_bottom
					end
					internal_shared.feedback.draw_line_area (screen_x, last_screen_pointer_position, width, height)
				end
			end
		end

	on_pointer_button_release (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle pointer release action
		do
			if resizing then
				clear_graph_last_drawn

				resizing := False
				disable_capture
				internal_shared.setter.after_disable_capture

				if attached resize_source as s then
					if direction = {SD_ENUMERATION}.left then
						s.end_resize_operation (Current, last_screen_pointer_position  - old_screen_x)
					elseif direction = {SD_ENUMERATION}.right then
						s.end_resize_operation (Current, old_screen_x - last_screen_pointer_position)
					elseif direction = {SD_ENUMERATION}.top then
						s.end_resize_operation (Current, last_screen_pointer_position - old_screen_y)
					elseif direction = {SD_ENUMERATION}.bottom then
						s.end_resize_operation (Current, old_screen_y - last_screen_pointer_position)
					end
				end
			end
		end

feature -- Properties

	direction: INTEGER
			-- Direction

feature {NONE}  -- Implemenetation

	clear_graph_last_drawn
			-- Clear the graph last drawn on the screen
		do
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				internal_shared.feedback.draw_line_area (last_screen_pointer_position, screen_y, width, height)
			else
				internal_shared.feedback.draw_line_area (screen_x, last_screen_pointer_position, width, height)
			end
		end

	internal_shared: SD_SHARED
			-- All singletons

	last_screen_pointer_position: INTEGER
			-- Screen position last drawn

	screen_boundary: detachable EV_RECTANGLE
			-- The screen rectangle which allow to resize

	old_screen_x, old_screen_y: INTEGER
			-- The screen pointer position when user press

	resizing: BOOLEAN
			-- Is user press pointer button and then we resizing?

invariant

	internal_shared_not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
