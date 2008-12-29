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

feature -- Access

	make (a_direction: INTEGER; a_source: SD_RESIZE_SOURCE)
			-- Creation method.
		require
			a_source_not_void: a_source /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_background_color: EV_GRID
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

			resize_source := a_source
			expose_actions.extend (agent on_expose_action)
			create l_background_color
			set_background_color (l_background_color.non_focused_selection_color)
		ensure
			a_source_set: resize_source = a_source
			a_direction_set: a_direction = direction
		end

feature {NONE} -- Agents

	on_pointer_button_press (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle pointer button press.
		do
			if a_button = 1 then
				if not resizing then
					resizing := True
					create screen_boundary
					resize_source.start_resize_operation (Current, screen_boundary)
					debug ("docking")
						io.put_string ("%N start position: " + a_screen_x.out + ", " + a_screen_y.out)
					end
					internal_shared.feedback.draw_line_area (screen_x, screen_y, width, height)
					if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right  then
						last_screen_pointer_position := screen_x
					else
						last_screen_pointer_position := screen_y
					end
					setter.before_enable_capture
					enable_capture
					old_screen_x := screen_x;
					old_screen_y := a_screen_y;
				end

			end
		end

	on_expose_action (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle expose action.
		local
			l_stock_colors: EV_STOCK_COLORS
		do
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
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle the resize window action.
		local
			l_scr_boundary: like screen_boundary
			l_left, l_right, l_top, l_bottom: INTEGER
		do
			if resizing then
				-- Clear the graph last drawn.

				clear_graph_last_drawn

				l_scr_boundary := screen_boundary
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
			-- Handle pointer release action.
		do
			if resizing then
				clear_graph_last_drawn

				resizing := False
				disable_capture
				setter.after_disable_capture

				if direction = {SD_ENUMERATION}.left then
					resize_source.end_resize_operation (Current, last_screen_pointer_position  - old_screen_x)
				elseif direction = {SD_ENUMERATION}.right then
					resize_source.end_resize_operation (Current, old_screen_x - last_screen_pointer_position)
				elseif direction = {SD_ENUMERATION}.top then
					resize_source.end_resize_operation (Current, last_screen_pointer_position - old_screen_y)
				elseif direction = {SD_ENUMERATION}.bottom then
					resize_source.end_resize_operation (Current, old_screen_y - last_screen_pointer_position)
				end
			end
		end

feature -- Properties

	direction: INTEGER
			-- Direction.

feature {NONE}  -- Implemenetation

	clear_graph_last_drawn
			-- Clear the graph last drawn on the screen.
		do
			if direction = {SD_ENUMERATION}.left or direction = {SD_ENUMERATION}.right then
				internal_shared.feedback.draw_line_area (last_screen_pointer_position, screen_y, width, height)
			else
				internal_shared.feedback.draw_line_area (screen_x, last_screen_pointer_position, width, height)
			end
		end

	setter: SD_SYSTEM_SETTER
			-- System setter
		once
			create {SD_SYSTEM_SETTER_IMP} Result
		end

	internal_shared: SD_SHARED
			-- All singletons.

	internal_pixmap: EV_PIXMAP
			-- Pixmap.

	last_screen_pointer_position: INTEGER
			-- Screen position last drawn.

	screen_boundary: EV_RECTANGLE
			-- The screen rectangle which allow to resize.

	old_screen_x, old_screen_y: INTEGER
			-- The screen pointer position when user press.

	resizing: BOOLEAN
			-- Is user press pointer button and then we resizing?

	resize_source: SD_RESIZE_SOURCE
			-- The resizable window.

invariant

	internal_shared_not_void: internal_shared /= Void

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
