--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision button event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_BUTTON_EVENT_DATA_I

inherit
	EV_EVENT_DATA_I

	EV_BIT_OPERATIONS_I
		export
			{NONE} all
		end

feature -- Access	

	source: EV_PICK_AND_DROPABLE
			-- The mouse pointer was over this event-source 
			-- when event happened

	x: INTEGER
			-- x coordinate of mouse pointer relative to widget

	y: INTEGER
			-- y coordinate of mouse pointer relative to widget

	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
		deferred
		end

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
		deferred
		end

	button: INTEGER
			-- Button that triggered event

	shift_key_pressed: BOOLEAN is
			-- Is the shift key pressed during the event?
		do
			Result := bit_set (state, 1)
		end

	control_key_pressed: BOOLEAN is
			-- Is the control key pressed during the event?
		do
			Result := bit_set (state, 2)
		end

	first_button_pressed: BOOLEAN is
			-- Is the first button of the mouse pressed during the
			-- event?
		do
			Result := bit_set (state, 4)
		end

	second_button_pressed: BOOLEAN is
			-- Is the second button of the mouse pressed during the
			-- event?
		do
			Result := bit_set (state, 8)
		end

	third_button_pressed: BOOLEAN is
			-- Is the third button of the mouse pressed during the
			-- event?
		do
			Result := bit_set (state, 16)
		end

feature -- Element change

	set_all (src: EV_PICK_AND_DROPABLE; a_x, a_y, a_button: INTEGER;
			shift, control, first, second, third: BOOLEAN) is
				-- Set all the parameters of the data.
		do
			set_source (src)
			set_x (a_x)
			set_y (a_y)
			set_button (a_button)
			set_shift_key (shift)
			set_control_key (control)
			set_first_button (first)
			set_second_button (second)
			set_third_button (third)
		end

	set_source (src: EV_PICK_AND_DROPABLE) is
			-- Make `wid' the new widget.
		do
			source := src
		end

	set_x (value: INTEGER) is
			-- Make `value' the new x.
		do
			x := value
		end
	
	set_y (value: INTEGER) is
			-- Make `value' the new y.
		do
			y := value
		end
	
	set_button (value: INTEGER) is
			-- Make `value' the new button.
		do
			button := value
		end

	set_shift_key (flag: BOOLEAN) is
			-- Make `flag' the new `shift_key_pressed' value.
		do
			state := set_bit (state, 1, flag)
		end

	set_control_key (flag: BOOLEAN) is
			-- Make `flag' the new `control_key_pressed' value.
		do
			state := set_bit (state, 2, flag)
		end

	set_first_button (flag: BOOLEAN) is
			-- Make `flag' the new `first_button_pressed' value.
		do
			state := set_bit (state, 4, flag)
		end

	set_second_button (flag: BOOLEAN) is
			-- Make `flag' the new `second_button_pressed' value.
		do
			state := set_bit (state, 8, flag)
		end

	set_third_button (flag: BOOLEAN) is
			-- Make `flag' the new `third_button_pressed' value.
		do
			state := set_bit (state, 16, flag)
		end

feature {NONE} -- Implementation

	state: INTEGER
			-- Current state of the complementary keys and buttons.
			-- Correspond to a binary number with :
			--	bit 0 : shift_key_pressed
			--	bit 1 : control_key_pressed
			--	bit 2 : first_button_pressed
			--	bit 3 : second_button_pressed
			--	bit 4 : third_button_pressed

end -- class EV_BUTTON_EVENT_DATA_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.4  2000/01/27 19:29:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.3  1999/12/17 18:52:32  rogers
--| EV_PICK_AND_DROPABLE replaces EV_PND_SOURCE.
--|
--| Revision 1.6.6.2  1999/12/09 01:26:24  oconnor
--| king: changed widget: EV_WIDGET to source: EV_PND_SOURCE
--|
--| Revision 1.6.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
