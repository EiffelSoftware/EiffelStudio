--| FIXME NOT_REVIEWED this file has not been reviewed
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
			interface
		end

	WEL_INPUT_EVENT
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a screen object.
		local
			color: EV_COLOR
		do
			base_make (an_interface)
			create dc
			dc.get
		end

feature -- Access

	dc: WEL_SCREEN_DC
			-- DC for drawing

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not dc.exists
		end

	pointer_position: EV_COORDINATES is
			-- Position of the screen pointer.
		local
			wel_point: WEL_POINT
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			create Result.set (wel_point.x, wel_point.y)
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
			-- Simulate the user pressing a `key'.
		local
			vk_code: INTEGER
		do
			vk_code := Key_conversion.key_code_to_wel(a_key.code)
			send_keyboard_key_down (vk_code)
		end

	fake_key_release (a_key: EV_KEY) is
			-- Simulate the user releasing a `key'.
		local
			vk_code: INTEGER
		do
			vk_code := Key_conversion.key_code_to_wel(a_key.code)
			send_keyboard_key_up (vk_code)
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the widget
		do
			Result := dc.width
		end

	height: INTEGER is
			-- Height of the widget
		do
			Result := dc.height
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			dc.release
			is_destroyed := True
			destroy_just_called := True
		end

feature -- Implementation
	
	interface: EV_SCREEN


feature {NONE} -- Constants

	System_metrics_constants: WEL_SYSTEM_METRICS is
			-- System metrics constants
		once
			create Result
		end
	
	Key_conversion: EV_WEL_KEY_CONVERSION is
		once
			create Result
		end

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
