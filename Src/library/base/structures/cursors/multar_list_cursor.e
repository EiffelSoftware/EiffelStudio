indexing

	description:
		"Cursors for multi-array trees";

	status: "See notice at end of class";
	names: cursor;
	date: "$Date$";
	revision: "$Revision$"

class MULTAR_LIST_CURSOR [G] inherit

	CURSOR

creation

	make

feature {MULTI_ARRAY_LIST} -- Initialization

	make (active_element: like active; current_active_index, current_index: INTEGER) is
			-- Create a cursor and set it up on `active_element'.
		do
			active := active_element;
			active_index := current_active_index
			index := current_index
		end;

feature {MULTI_ARRAY_LIST} -- Implementation

	active: BI_LINKABLE [ARRAYED_LIST [G]];
		-- Current element in array_sequence list

	active_index: INTEGER;
		-- Index relative to `active.item'

	index: INTEGER
		-- Index in array_sequence list

end -- class MULTAR_LIST_CURSOR


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
