indexing

	description:
		"Informations given by EiffelVision when a key is pressed or released. %
		%Parent of KYPRESS_DATA and KEYREL_DATA";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	KEY_DATA 

inherit

	CONTEXT_DATA

feature -- Access

	keyboard: KEYBOARD;
			-- State of modifiers key (Shift, control...)

	keycode: INTEGER;
			-- Server-dependent code corresponding to the keystroke

	string: STRING;
			-- String stroked on keyboard

end -- class KEY_DATA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

