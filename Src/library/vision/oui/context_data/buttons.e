indexing

	description:
		"State of the mouse buttons. %
		%The number of buttons is five, %
		%by convention";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	BUTTONS 

inherit

	ARRAY [BOOLEAN]
		rename
			make as make_array
		export
			{NONE} all;
			{ANY} item, put
		end

creation

	make

feature -- Initialization

	make (nb_buttons: INTEGER) is
			-- Create an array of five logical 
			-- mouse buttons.
		require
			at_least_one_button: nb_buttons >= 1
		do
			make_array (1, nb_buttons)
		end

end -- class BUTTONS

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

