indexing

	description:
		"Cursors for linked lists";

	copyright: "See notice at end of class";
	names: linked_list_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_LIST_CURSOR [G] inherit

	CURSOR

creation 
	
	make

feature {LINKED_LIST} -- Initialization

	make (active_element: like active; aft, bef: BOOLEAN) is
			-- Create a cursor and set it up on `active_element'.
		do
			active := active_element;
			after := aft;
			before := bef
		end;

feature {LINKED_LIST} -- Implementation

	active: LINKABLE [G];
			-- Current element in linked list

	after: BOOLEAN;
			-- Is cursor after the end of the list?

	before: BOOLEAN;
			-- Is cursor before the start of the list?

end -- class LINKED_LIST_CURSOR


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
