indexing
	description: "EiffelVision key event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_KEY_EVENT_DATA_I

inherit
	EV_EVENT_DATA_I	

	EV_BIT_OPERATIONS_I
		export
			{NONE} all
		end

feature -- Access

	keycode: INTEGER
			-- Platform dependent code corresponding to the keystroke
			-- For values, see class EV_KEY_CODE.

	length: INTEGER is
			-- length of the string returned by the system
		do
			Result := string.count
		end

	string: STRING
			-- String given the char equivalent of the key

--	repeat: INTEGER
--			-- Number of times the action is repeat
-- XX	To implement.

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

	caps_lock_key_pressed: BOOLEAN is
			-- Is the caps-lock key locked during the event?
		do
			Result := bit_set (state, 4)
		end

	num_lock_key_pressed: BOOLEAN is
			-- Is the num-lock key locked during the event?
		do
			Result := bit_set (state, 8)
		end

	scroll_lock_key_pressed: BOOLEAN is
			-- Is the scroll-lock key locked during the event?
		do
			Result := bit_set (state, 16)
		end

feature -- Element change

	set_all (wid: EV_WIDGET; a_keycode: INTEGER; str: STRING;
				shift, control,	caps_lock, num_lock,
				scroll_lock: BOOLEAN) is
			-- Fill all the values of the data.
		do
			set_widget (wid)
			set_keycode (a_keycode)
			set_string (str)
			set_shift_key (shift)
			set_control_key (control)
			set_caps_lock_key (caps_lock)
			set_num_lock_key (num_lock)
			set_scroll_lock_key (scroll_lock)
		end

	set_keycode (value: INTEGER) is
			-- Make `value' the new keyval.
		do
			keycode := value
		end

	set_string (str: STRING) is
			-- Make `str' the new string.
		do
			string := str
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

	set_caps_lock_key (flag: BOOLEAN) is
			-- Make `flag' the new `control_key_pressed' value.
		do
			state := set_bit (state, 4, flag)
		end

	set_num_lock_key (flag: BOOLEAN) is
			-- Make `flag' the new `num_lock' value.
		do
			state := set_bit (state, 8, flag)
		end

	set_scroll_lock_key (flag: BOOLEAN) is
			-- Make `flag' the new `scroll_lock' value.
		do
			state := set_bit (state, 16, flag)
		end

feature {NONE} -- Implementation

	state: INTEGER
			-- Current state of the complementary keys and buttons.
			-- Correspond to a binary number with :
			--   bit 0 : shift_key_pressed
			--	 bit 1 : control_key_pressed
			--	 bit 2 : caps-lock key
			--	 bit 3 : num-lock key
			--	 bit 4 : alt -- XX don't work yet on windows

end -- class EV_KEY_EVENT_DATA_I

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
