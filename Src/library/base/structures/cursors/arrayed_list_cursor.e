indexing

	description:
		"Cursors for arrayed lists";

	status: "See notice at end of class";
	names: fixed_list_cursor, cursor;
	date: "$Date$";
	revision: "$Revision$"

class ARRAYED_LIST_CURSOR inherit

	CURSOR

creation

	make

feature {ARRAYED_LIST, FIXED_LIST} -- Initialization

	make (current_index: INTEGER) is
			-- Create a cursor and set it up on `current_index'.
		do
			index := current_index
		end;

feature {ARRAYED_LIST, FIXED_LIST} -- Access

	index: INTEGER;
		-- Index of current item

end -- class ARRAYED_LIST_CURSOR


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
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
