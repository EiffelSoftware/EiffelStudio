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

create

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

