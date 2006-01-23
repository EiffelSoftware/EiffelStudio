indexing 
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
			interface, virtual_width, virtual_height, virtual_x, virtual_y
		end

	EV_DRAWABLE_IMP
		redefine
			interface, destroy
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

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current', a screen object.
		do
			base_make (an_interface)
			create dc
			dc.get
		end

feature -- Access

	dc: WEL_SCREEN_DC
			-- DC for drawing.

feature -- Status report

	destroyed: BOOLEAN is
			-- Is `Current' destroyed?
		do
			Result := not dc.exists
		end

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer.
		local
			wel_point: WEL_POINT
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			create Result.set (wel_point.x, wel_point.y)
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position (`x', `y') if any.
		local
			l_window: WEL_WINDOW
			wel_point: WEL_POINT
			widget_imp: EV_WIDGET_IMP
			internal_combo_box: EV_INTERNAL_COMBO_BOX_IMP
			internal_combo_field: EV_INTERNAL_COMBO_FIELD_IMP
		do
				-- Assign the cursor position to `wel_point'.
			create wel_point.make (x, y)
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

feature -- Basic operation

	set_pointer_position (x, y: INTEGER) is
			-- Set `pointer_position' to (`x',`y`).
		do
			cwin_set_cursor_position (x, y)
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end	

	fake_pointer_button_press (a_button: INTEGER) is
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

	fake_pointer_button_release (a_button: INTEGER) is
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

	fake_key_press (a_key: EV_KEY) is
			-- Simulate the user pressing `a_key'.
		local
			vk_code: INTEGER
		do
			vk_code := Key_conversion.key_code_to_wel(a_key.code)
			send_keyboard_key_down (vk_code)
		end

	fake_key_release (a_key: EV_KEY) is
			-- Simulate the user releasing `a_key'.
		local
			vk_code: INTEGER
		do
			vk_code := Key_conversion.key_code_to_wel(a_key.code)
			send_keyboard_key_up (vk_code)
		end

feature -- Measurement

	width: INTEGER is
			-- Width of `Current'.
		do
			Result := dc.width
		end

	height: INTEGER is
			-- Height of `Current'.
		do
			Result := dc.height
		end
		
	virtual_width: INTEGER is
			-- Virtual width of `Current'
		local
			l_metrics: WEL_SYSTEM_METRICS
		do
			create l_metrics
			Result := l_metrics.virtual_screen_width
		end
		
	virtual_height: INTEGER is
			-- Virtual height of `Current'
		local
			l_metrics: WEL_SYSTEM_METRICS
		do
			create l_metrics
			Result := l_metrics.virtual_screen_height
		end

	virtual_x: INTEGER is
			-- X position of virtual screen in main display coordinates
		local
			l_metrics: WEL_SYSTEM_METRICS
		do
			create l_metrics
			Result := l_metrics.virtual_screen_x
		end
		
	virtual_y: INTEGER is
			-- Y position of virtual screen in main display coordinates
		local
			l_metrics: WEL_SYSTEM_METRICS
		do
			create l_metrics
			Result := l_metrics.virtual_screen_y
		end
		
	vertical_resolution: INTEGER is
			-- Number of pixels per inch along screen height.
		do
			Result := get_device_caps (dc.item, logical_pixels_y)
		end
		
	horizontal_resolution: INTEGER is
			-- Number of pixels per inch along screen width.
		do
			Result := get_device_caps (dc.item, logical_pixels_x)
		end

	redraw is
			-- Force screen to redraw itself.
		external
			"C inline use %"wel.h%""
		alias
			"InvalidateRect(NULL, NULL, FALSE)"
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			dc.release
			Precursor {EV_DRAWABLE_IMP}
		end

feature -- Implementation
	
	interface: EV_SCREEN


feature {NONE} -- Constants

	System_metrics_constants: WEL_SYSTEM_METRICS is
			-- System metrics constants.
		once
			create Result
		end
	
	Key_conversion: EV_WEL_KEY_CONVERSION is
			-- Key conversion routines.
		once
			create Result
		end
		
invariant
	dc_not_void: dc /= Void

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




end -- class EV_SCREEN_IMP

