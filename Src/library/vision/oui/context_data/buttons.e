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

create

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

