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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

