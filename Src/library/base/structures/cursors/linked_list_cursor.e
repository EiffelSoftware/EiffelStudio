indexing

	description:
		"Cursors for linked lists";

	status: "See notice at end of class";
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
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN;
			-- Is there no valid cursor position to the right of cursor?

invariant
	not_both: not (before and after);
	no_active_not_on: active = Void implies (before or after)

end -- class LINKED_LIST_CURSOR


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

