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
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
