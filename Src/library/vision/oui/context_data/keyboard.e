indexing

	description:
		"State of the keyboard: Key and modifiers. %
		%(Shift, Control, Lock and five others)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	KEYBOARD 

creation

	make

feature -- Initialization

	make (nb_modifiers: INTEGER) is
			-- Create a database to specify 
			-- the state of modifier keys.
		do
			if nb_modifiers >= 1 then
				!!modifiers.make (1, nb_modifiers)
			end;
		end;

feature -- Access

	modifiers: ARRAY [BOOLEAN];
			-- Array of boolean representing the state (is pressed ?) of
			-- the other logical modifiers

feature -- Status report

	control_pressed: BOOLEAN;
			-- Is the CONTROL (CTRL) key pressed ?

	lock_pressed: BOOLEAN;
			-- Is the LOCK (CAPS LOCK) key pressed ?

	shift_pressed: BOOLEAN
			-- Is the key SHIFT pressed ?

feature -- Status setting

	set_control_pressed (a_state: BOOLEAN) is
			-- Set `control_pressed' to `a_state'.
		do
			control_pressed := a_state
		ensure
			control_pressed = a_state
		end;

	set_lock_pressed (a_state: BOOLEAN) is
			-- Set `lock_pressed' to `a_state'.
		do
			lock_pressed := a_state
		ensure
			lock_pressed = a_state
		end;

	set_shift_pressed (a_state: BOOLEAN) is
			-- Set `shift_pressed' to `a_state'.
		do
			shift_pressed := a_state
		ensure
			shift_pressed = a_state
		end;

end -- class KEYBOARD



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

