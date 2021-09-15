note
	description: "Class representing a locked column or row in an EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GRID_LOCKED_I

feature {NONE} -- Initialization

	initialize (a_grid: EV_GRID_I; an_offset: INTEGER)
			-- Create `Current' associated to grid `a_grid', locked at position `an_offset'.
		require
			grid_not_void: a_grid /= Void
		do
			grid := a_grid
			offset := an_offset

			create window
			create fixed
			create drawing_area
			drawing_area.set_minimum_size (grid.buffered_drawable_width, grid.buffered_drawable_height)
			create viewport
			create fixed
			viewport.extend (fixed)
			widget := viewport
			fixed.extend (drawing_area)
			drawing_area.expose_actions.extend (agent (grid.drawer).redraw_area_in_drawable_coordinates (?, ?, ?, ?, drawing_area, viewport, Current))--simple_redraw)

				-- Connect events to `drawable' which should simply propagate the adjusted values directly
				-- to the grid for handling.
			drawing_area.pointer_motion_actions.extend (agent pointer_motion_received (?, ?, ?, ?, ?, ?, ?))
			drawing_area.pointer_button_press_actions.extend (agent pointer_button_press_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawing_area.pointer_double_press_actions.extend (agent pointer_double_press_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawing_area.pointer_button_release_actions.extend (agent pointer_button_release_received (?, ?, ?, ?, ?, ?, ?, ?))
			drawing_area.pointer_enter_actions.extend (agent pointer_enter_received)
			drawing_area.pointer_leave_actions.extend (agent pointer_leave_received)
			drawing_area.key_press_actions.extend (agent key_press_received (?))
			drawing_area.key_press_string_actions.extend (agent key_press_string_received (?))
			drawing_area.key_release_actions.extend (agent key_release_received (?))
			drawing_area.focus_in_actions.extend (agent focus_in_received)
			drawing_area.focus_out_actions.extend (agent focus_out_received)
			drawing_area.mouse_wheel_actions.extend (agent mouse_wheel_received)
		end

feature -- Access

	widget: EV_WIDGET
		-- Main widget for `Current' which must be displayed.

	offset: INTEGER
		-- Locked offset from edge of viewable area.
		-- Left edge for columns and top edge for rows.

	window: EV_POPUP_WINDOW
		-- Window in which `Current' is parented.

	fixed: EV_FIXED
		-- Fixed which widgets may be parented within.

	drawing_area: EV_DRAWING_AREA
		-- Drawable into which all drawing is performed.

	viewport: EV_VIEWPORT
		-- Viewport to enable scrolling.

	grid: EV_GRID_I

	locked_index: INTEGER
		-- Index of `Current' in the locked Z order, with 1 being the lowest (therefore obscured by all others)

feature {NONE} -- Event handling

	pointer_button_press_received (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
		do
			grid.pointer_button_press_received (x_to_drawable_x (a_x), y_to_drawable_y (a_y), a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	pointer_motion_received (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_motion_actions' of `drawable'.
		do
			grid.pointer_motion_received (x_to_drawable_x (a_x), y_to_drawable_y (a_y), a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	pointer_double_press_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_double_press_actions' of `drawable'.
		do
			grid.pointer_double_press_received (x_to_drawable_x (a_x), y_to_drawable_y (a_y), a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	pointer_button_release_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_button_release_actions' of `drawable'.
		do
			grid.pointer_button_release_received (x_to_drawable_x (a_x), y_to_drawable_y (a_y), a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	pointer_enter_received
			-- Called by `pointer_enter_actions' of widgets comprising `Current'.
		do
			--| FIXME
		end

	pointer_leave_received
			-- Called by `pointer_leave_actions' of widgets comprising `Current'.
		do
			--| FIXME
		end

	key_press_received (a_key: EV_KEY)
			-- Called by `key_press_actions' of `drawable'.
		do
			grid.key_press_received (a_key)
		end

	key_press_string_received (a_keystring: STRING_32)
			-- Called by `key_press_string_actions' of `drawable'.
		do
			grid.key_press_string_received (a_keystring)
		end

	key_release_received (a_key: EV_KEY)
			-- Called by `key_release_actions' of `drawable'.
		do
			grid.key_release_received (a_key)
		end

	focus_in_received
			-- Called by `focus_in_actions' of `drawable'.
		do
			grid.enable_drawables_have_focus
			--| FIXME
		end

	focus_out_received
			-- Called by `focus_out_actions' of `drawable'.
		do
			grid.disable_drawables_have_focus
			--| FIXME
		end

	mouse_wheel_received (a_value: INTEGER)
			-- Called by `mouse_wheel_actions' of `drawable'.
		do
			grid.mouse_wheel_received (a_value)
		end

feature {EV_GRID_I} -- Implementation

	x_to_drawable_x (an_x: INTEGER): INTEGER
			-- Result is a relative x coordinate for the drawable of the grid
			-- given a relative x coordinate to `drawing_area'.
		do
			Result := an_x
		end

	y_to_drawable_y (a_y: INTEGER): INTEGER
			-- Result is a relative y coordinate for the drawable of the grid
			-- given a relative y coordinate to `drawing_area'.
		do
			Result := a_y
		end

feature {EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I, EV_GRID_COLUMN_I} -- Implementation

	simple_redraw (an_x, a_y, a_width, a_height: INTEGER)
			--
		do
			drawing_area.set_foreground_color ((create {EV_STOCK_COLORS}).red)
			drawing_area.fill_rectangle (an_x, a_y, a_width, a_height)
		end

	internal_set_virtual_y_position (a_y_position: INTEGER)
			-- Set virtual y position of `Current' to `a_y_position'.
		require
			a_y_position_non_negative: a_y_position >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			if grid.is_full_redraw_on_virtual_position_change_enabled then
				redraw_client_area
			end
			internal_client_y := a_y_position
				-- Store the virtual client y position internally.

			buffer_space := (grid.buffered_drawable_height - grid.viewable_height)
			current_buffer_position := viewport_y_offset

				-- Calculate if the buffer must be flipped. If so, redraw the complete client area,
				-- otherwise, simply move the position in `viewport'.
			if (internal_client_y > last_vertical_scroll_bar_value) and ((internal_client_y - last_vertical_scroll_bar_value) + (current_buffer_position)) >= buffer_space then
				viewport_y_offset := 0
				viewport.set_y_offset (viewport_y_offset)
				redraw_client_area
			elseif (internal_client_y < last_vertical_scroll_bar_value) and ((internal_client_y - last_vertical_scroll_bar_value) + (current_buffer_position)) < 0 then
				viewport_y_offset := buffer_space
				viewport.set_y_offset (viewport_y_offset)
				redraw_client_area
			else
				viewport_y_offset := current_buffer_position + internal_client_y - last_vertical_scroll_bar_value
				viewport.set_y_offset (viewport_y_offset)
			end

				-- Store the last scrolled to position.
			last_vertical_scroll_bar_value := internal_client_y
		ensure
			internal_position_set: internal_client_y = a_y_position
		end

	internal_set_virtual_x_position (a_x_position: INTEGER)
			-- Set virtual x position of `Current' to `a_x_position'.
		require
			a_x_position_non_negative: a_x_position >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			if grid.is_full_redraw_on_virtual_position_change_enabled then
				redraw_client_area
			end
			internal_client_x := a_x_position
				-- Store the virtual client x position internally.

			buffer_space := (grid.buffered_drawable_width - grid.viewable_width)
			current_buffer_position := viewport_x_offset

				-- Calculate if the buffer must be flipped. If so, redraw the complete client area,
				-- otherwise, simply move the position in `viewport'.
			if (internal_client_x > last_horizontal_scroll_bar_value) and ((internal_client_x - last_horizontal_scroll_bar_value) + (current_buffer_position)) >= buffer_space then
				viewport_x_offset := 0
				viewport.set_x_offset (viewport_x_offset)
				redraw_client_area
			elseif (internal_client_x < last_horizontal_scroll_bar_value) and ((internal_client_x - last_horizontal_scroll_bar_value) + (current_buffer_position)) < 0 then
				viewport_x_offset := buffer_space
				viewport.set_x_offset (viewport_x_offset)
				redraw_client_area
			else
				viewport_x_offset := current_buffer_position + internal_client_x - last_horizontal_scroll_bar_value
				viewport.set_x_offset (viewport_x_offset)
			end

				-- Store the last scrolled to position.
			last_horizontal_scroll_bar_value := internal_client_x
		ensure
			internal_position_set: internal_client_x = a_x_position
		end

	redraw_client_area
			-- Redraw complete visible client area of `Current'.
		do
			drawing_area.redraw
		end

	set_locked_index (an_index: INTEGER)
			-- Assign `an_index' to `locked_index'.
		require
			an_index_positive: an_index > 0
		do
			locked_index := an_index
		ensure
			index_set: locked_index = an_index
		end

	internal_client_y, internal_client_x: INTEGER

	viewport_y_offset, viewport_x_offset: INTEGER

	last_horizontal_scroll_bar_value, last_vertical_scroll_bar_value: INTEGER;

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
