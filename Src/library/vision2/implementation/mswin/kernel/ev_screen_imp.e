indexing 
	description: "EiffelVision screen, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface, destroy
		end

	WEL_INPUT_EVENT
		export
			{NONE} all
		end

creation
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
			wel_point: WEL_POINT
			widget_imp: EV_WIDGET_IMP
		do
				-- Assign the cursor position to `wel_point'.
			create wel_point.make (x, y)
				-- Retrieve WEL_WINDOW at `wel_point'.
			widget_imp ?= wel_point.window_at
				-- If there is a window at `wel_point'.
			if widget_imp /= Void then
					-- Result is interface of `widget_imp'.
				Result := widget_imp.interface
			end
		end

feature -- Basic operation

	set_pointer_position (x, y: INTEGER) is
			-- Set `pointer_position' to (`x',`y`).
		local
			abs_x: INTEGER
			abs_y: INTEGER
		do
			abs_x := (65535 * x) // System_metrics_constants.screen_width
			abs_y := (65535 * y) // System_metrics_constants.screen_height
			check
				width_ok: width = System_metrics_constants.screen_width
				height_ok: height = System_metrics_constants.screen_height
			end
			
			send_mouse_absolute_move (abs_x, abs_y)
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

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			dc.release
			{EV_DRAWABLE_IMP} Precursor
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

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

