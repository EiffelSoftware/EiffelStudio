indexing

	description:
		"Information given by EiffelVision when a key is pressed. %
		%X event associated: `KeyPress'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	KYPRESS_DATA 

inherit

	KEY_DATA
		rename
			make as key_data_make
		end

creation

	make

feature -- Initialization

	make (a_widget: WIDGET; a_keycode: INTEGER; a_string: STRING; a_keyboard: KEYBOARD) is
			-- Create a context_data for `KeyPress' event.
		do
			widget := a_widget;
			keycode := a_keycode;
			string := a_string;
			keyboard := a_keyboard
		end

end -- class KYPRESS_DATA

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

