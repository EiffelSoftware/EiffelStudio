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

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.20  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.19  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.18  2001/06/14 18:25:50  rogers
--| Renamed EV_COORDINATES to EV_COORDINATE.
--|
--| Revision 1.17  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.8.8  2000/11/06 19:37:12  king
--| Accounted for default to stock name change
--|
--| Revision 1.3.8.7  2000/10/27 02:44:03  manus
--| Defined `set_default_colors' to have a sensible correct value.
--|
--| Revision 1.3.8.6  2000/10/16 14:43:53  pichery
--| Improved `destroy'
--|
--| Revision 1.3.8.5  2000/10/06 22:57:23  raphaels
--| Cosmetics.
--|
--| Revision 1.3.8.4  2000/10/06 22:30:05  rogers
--| Implemented widget_at_position.
--|
--| Revision 1.3.8.3  2000/08/11 18:26:43  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.3.8.2  2000/05/30 16:07:46  rogers
--| Removed unreferenced variables.
--|
--| Revision 1.3.8.1  2000/05/03 19:09:53  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/05/02 22:43:55  rogers
--| Removed FIXME NOT_REVIEWED. Comments. Formatting.
--|
--| Revision 1.14  2000/04/26 22:34:39  pichery
--| Implemented features "not yet implemented"
--| features.
--|
--| Revision 1.13  2000/04/13 00:24:18  pichery
--| - Removed useless features
--|
--| Revision 1.12  2000/04/11 22:44:11  brendel
--| Fixed get_cursor_position.
--|
--| Revision 1.11  2000/04/11 21:40:24  pichery
--| implemented set_pointer_position & pointer_position.
--|
--| Revision 1.10  2000/04/11 21:16:41  king
--| Made <= 80 columns
--|
--| Revision 1.9  2000/04/11 21:11:22  brendel
--| IEK -- Added unimplemented pointer manipulation stubs.
--|
--| Revision 1.8  2000/04/06 23:26:59  oconnor
--| added implementation comments and new fake event features
--|
--| Revision 1.7  2000/04/06 20:12:30  oconnor
--| added pointer position features
--|
--| Revision 1.6  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.5  2000/02/14 22:26:34  oconnor
--| merged from HACK-O-RAMA
--|
--| Revision 1.3.10.5  2000/02/14 20:48:59  rogers
--| Added 'is_destroyed := True' and 'destroy_just_called := True' to destroy.
--|
--| Revision 1.3.10.4  2000/01/27 19:30:32  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.3  2000/01/21 23:20:44  brendel
--| Rearranged initialization.
--|
--| Revision 1.3.10.2  1999/12/17 00:18:51  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
