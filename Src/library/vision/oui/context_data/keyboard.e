--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- State of the keyboard: Key and modifiers.
-- (Shift, Control, Lock and five others).

indexing

	date: "$Date$";
	revision: "$Revision$"

class KEYBOARD 

creation

	make

feature 

	control_pressed: BOOLEAN;
			-- Is the CONTROL (CTRL) key pressed ?

	make (nb_modifiers: INTEGER) is
			-- Create a database to specify 
			-- the state of modifier keys.
		do
			if nb_modifiers >= 1 then
				!!modifiers.make (1, nb_modifiers)
			end;
		end;

	lock_pressed: BOOLEAN;
			-- Is the LOCK (CAPS LOCK) key pressed ?

	modifiers: ARRAY [BOOLEAN];
			-- Array of boolean representing the state (is pressed ?) of
			-- the other logical modifiers

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

	shift_pressed: BOOLEAN
			-- Is the key SHIFT pressed ?

end
