note
	description: "EiffelVision screen, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface, virtual_width, virtual_height, virtual_x, virtual_y,
			monitor_count, monitor_area_from_position, monitor_area_from_window,
			working_area_from_position, working_area_from_window, refresh_graphics_context,
			widget_at_mouse_pointer
		end

	EV_DRAWABLE_IMP
		redefine
			interface, destroy,
			make
		end

	WEL_INPUT_EVENT
		export
			{NONE} all
		end

	WEL_UNIT_CONVERSION
		rename
			horizontal_resolution as wel_horizontal_resolution,
			vertical_resolution as wel_vertical_resolution
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current', a screen object.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		do
			create dc
			dc.get
			Precursor
		end

feature -- Access

	dc: WEL_SCREEN_DC
			-- DC for drawing.

feature -- Status report

	destroyed: BOOLEAN
			-- Is `Current' destroyed?
		do
			Result := not dc.exists
		end

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		local
			wel_point: WEL_POINT
		do
			wel_point := reusable_wel_point
			wel_point.set_cursor_position
			create Result.set (wel_point.x, wel_point.y)
		end

	widget_at_mouse_pointer: detachable EV_WIDGET
			-- <Precursor>
		local
			wel_point: WEL_POINT
		do
			wel_point := reusable_wel_point
			wel_point.set_cursor_position
			Result := widget_at_position (wel_point.x, wel_point.y)
		end

	widget_at_position (x, y: INTEGER): detachable EV_WIDGET
			-- Widget at position (`x', `y') if any.
		local
			l_window: detachable WEL_WINDOW
			wel_point: WEL_POINT
			widget_imp: detachable EV_WIDGET_IMP
			internal_combo_box: detachable EV_INTERNAL_COMBO_BOX_IMP
			internal_combo_field: detachable EV_INTERNAL_COMBO_FIELD_IMP
		do
				-- Assign the cursor position to `wel_point'.
			wel_point := reusable_wel_point
			wel_point.set_x_y (x, y)
				-- Retrieve WEL_WINDOW at `wel_point'.
			l_window := wel_point.window_at

				-- If there is a window at `wel_point'.
			widget_imp ?= l_window
			if widget_imp /= Void then
					-- Result is interface of `widget_imp'.
				Result := widget_imp.interface
			else
					-- Combo boxes must be handled as a special case, as
					-- they are comprised of two widgets.
				internal_combo_box ?= l_window
				if internal_combo_box /= Void then
					Result := internal_combo_box.parent.interface
				else
					internal_combo_field ?= l_window
					if internal_combo_field /= Void then
						Result := internal_combo_field.parent.interface
					end
				end
			end
		end

	monitor_area_from_position (a_x, a_y: INTEGER): EV_RECTANGLE
			-- <Precursor>
		local
			l_wel_mon: POINTER
			l_mon_info: WEL_MONITOR_INFO
			l_rect: WEL_RECT
			l_success: BOOLEAN
		do
			create l_rect.make (a_x, a_y, a_x, a_y)
			l_wel_mon := {WEL_API}.monitor_from_rect (l_rect.item, monitor_defaulttonearest)
			create l_mon_info.make
			l_success := {WEL_API}.get_monitor_info (l_wel_mon, l_mon_info.item)
			if l_success then
				l_rect := l_mon_info.monitor_area
				create Result.make (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
			else
					-- Use fallback implementation to return the primary monitor.
				Result := Precursor (a_x, a_y)
			end
		end

	monitor_area_from_window (a_window: EV_WINDOW): EV_RECTANGLE
			-- <Precursor>
		local
			l_wel_mon: POINTER
			l_mon_info: WEL_MONITOR_INFO
			l_window_imp: detachable EV_WINDOW_IMP
			l_rect: WEL_RECT
			l_success: BOOLEAN
		do
			l_window_imp ?= a_window.implementation
			check l_window_imp_attached: l_window_imp /= Void then end
				-- Use window handle if displayed, otherwise use coordinates from window.
			if a_window.is_displayed then
				l_wel_mon := {WEL_API}.monitor_from_window (l_window_imp.wel_item, monitor_defaulttonearest)
			else
				create l_rect.make (l_window_imp.x_position, l_window_imp.y_position,
					l_window_imp.x_position + l_window_imp.width,
					l_window_imp.y_position + l_window_imp.height)
				l_wel_mon := {WEL_API}.monitor_from_rect (l_rect.item, monitor_defaulttonearest)
			end

			create l_mon_info.make
			l_success := {WEL_API}.get_monitor_info (l_wel_mon, l_mon_info.item)
			if l_success then
				l_rect := l_mon_info.monitor_area
				create Result.make (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
			else
					-- Use fallback implementation to return the primary monitor.
				Result := Precursor (a_window)
			end
		end

	working_area_from_position (a_x, a_y: INTEGER): EV_RECTANGLE
			-- <Precursor>
		local
			l_wel_mon: POINTER
			l_mon_info: WEL_MONITOR_INFO
			l_rect: WEL_RECT
			l_success: BOOLEAN
		do
			create l_rect.make (a_x, a_y, a_x, a_y)
			l_wel_mon := {WEL_API}.monitor_from_rect (l_rect.item, monitor_defaulttonearest)
			create l_mon_info.make
			l_success := {WEL_API}.get_monitor_info (l_wel_mon, l_mon_info.item)
			if l_success then
				l_rect := l_mon_info.working_area
				create Result.make (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
			else
					-- Use fallback implementation to return the primary monitor.
				Result := Precursor (a_x, a_y)
			end
		end

	working_area_from_window (a_window: EV_WINDOW): EV_RECTANGLE
			-- <Precursor>
		local
			l_wel_mon: POINTER
			l_mon_info: WEL_MONITOR_INFO
			l_window_imp: detachable EV_WINDOW_IMP
			l_rect: WEL_RECT
			l_success: BOOLEAN
		do
			l_window_imp ?= a_window.implementation
			check l_window_imp_attached: l_window_imp /= Void then end
				-- Use window handle if displayed, otherwise use coordinates from window.
			if a_window.is_displayed then
				l_wel_mon := {WEL_API}.monitor_from_window (l_window_imp.wel_item, monitor_defaulttonearest)
			else
				create l_rect.make (l_window_imp.x_position, l_window_imp.y_position,
					l_window_imp.x_position + l_window_imp.width,
					l_window_imp.y_position + l_window_imp.height)
				l_wel_mon := {WEL_API}.monitor_from_rect (l_rect.item, monitor_defaulttonearest)
			end

			create l_mon_info.make
			l_success := {WEL_API}.get_monitor_info (l_wel_mon, l_mon_info.item)
			if l_success then
				l_rect := l_mon_info.working_area
				create Result.make (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
			else
					-- Use fallback implementation to return the primary monitor.
				Result := Precursor (a_window)
			end
		end

	monitor_defaulttonull: INTEGER = 0
	monitor_defaulttoprimary: INTEGER = 1
	monitor_defaulttonearest: INTEGER = 2
		-- Win32 API Monitor default return constant values.

feature -- Basic operation

	set_pointer_position (x, y: INTEGER)
			-- <Precursor>
		do
			cwin_set_cursor_position (x, y)
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Simulate the user pressing a `a_button'
			-- on the pointing device.
		do
			inspect a_button
			when 1 then
				send_mouse_left_button_down
			when 2 then
				send_mouse_right_button_down
			when 3 then
				send_mouse_middle_button_down
			end
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Simulate the user releasing a `a_button'
			-- on the pointing device.
		do
			inspect a_button
			when 1 then
				send_mouse_left_button_up
			when 2 then
				send_mouse_right_button_up
			when 3 then
				send_mouse_middle_button_up
			end
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		do
			send_mouse_wheel_up
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		do
			send_mouse_wheel_down
		end

	fake_key_press (a_key: EV_KEY)
			-- Simulate the user pressing `a_key'.
		local
			vk_code: INTEGER
		do
			vk_code := Key_conversion.key_code_to_wel(a_key.code)
			send_keyboard_key_down (vk_code)
		end

	fake_key_release (a_key: EV_KEY)
			-- Simulate the user releasing `a_key'.
		local
			vk_code: INTEGER
		do
			vk_code := Key_conversion.key_code_to_wel(a_key.code)
			send_keyboard_key_up (vk_code)
		end

feature -- Measurement

	width: INTEGER
			-- Width of `Current'.
		do
			Result := dc.width
		end

	height: INTEGER
			-- Height of `Current'.
		do
			Result := dc.height
		end

	virtual_width: INTEGER
			-- Virtual width of `Current'
		do
			Result := system_metrics_constants.virtual_screen_width
		end

	virtual_height: INTEGER
			-- Virtual height of `Current'
		do
			Result := system_metrics_constants.virtual_screen_height
		end

	virtual_x: INTEGER
			-- X position of virtual screen in main display coordinates
		do
			Result := system_metrics_constants.virtual_screen_x
		end

	virtual_y: INTEGER
			-- Y position of virtual screen in main display coordinates
		do
			Result := system_metrics_constants.virtual_screen_y
		end

	monitor_count: INTEGER
			-- Number of monitors used for displaying the screen.
		do
			Result := system_metrics_constants.monitor_count
		end

	vertical_resolution: INTEGER
			-- Number of pixels per inch along screen height.
		do
			Result := get_device_caps (dc.item, logical_pixels_y)
		end

	horizontal_resolution: INTEGER
			-- Number of pixels per inch along screen width.
		do
			Result := get_device_caps (dc.item, logical_pixels_x)
		end

	redraw
			-- Force screen to redraw itself.
		do
			{WEL_WINDOW}.cwin_invalidate_rect (default_pointer, default_pointer, False)
		end

feature -- Status setting

	destroy
			-- Destroy actual object.
		do
			dc.release
			Precursor {EV_DRAWABLE_IMP}
		end

feature -- Implementation

	refresh_graphics_context
			-- <Precursor>
		do
				-- Reacquire the dc and reset any set values.
			dc.release
			dc.get
			set_drawing_mode (drawing_mode)
			if dashed_line_style then
				enable_dashed_line_style
			else
				disable_dashed_line_style
			end
			if attached background_color_internal as bg then
				set_background_color (bg)
			end
			if attached foreground_color_internal as fg then
				set_foreground_color (fg)
			end
		end

	interface: detachable EV_SCREEN
		note
			option: stable
		attribute
		end

feature {NONE} -- Constants

	System_metrics_constants: WEL_SYSTEM_METRICS
			-- System metrics constants.
		once
			create Result
		end

	Key_conversion: EV_WEL_KEY_CONVERSION
			-- Key conversion routines.
		once
			create Result
		end

feature {NONE} -- Implementation

	reusable_wel_point: WEL_POINT
			-- Reusable wel point object to avoid creating a new object for temporary use.
		once
			create Result.make (0, 0)
		end

invariant
	dc_not_void: dc /= Void

note
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

