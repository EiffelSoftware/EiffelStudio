indexing

	description:
		"Cursors for linked trees";

	status: "See notice at end of class";
	names: linked_tree_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_TREE_CURSOR [G] inherit

	RECURSIVE_TREE_CURSOR [G]
		export
			{LINKED_CURSOR_TREE} make
		redefine
			active
		end

feature {LINKED_CURSOR_TREE} -- Access

	active: LINKED_TREE [G]
			-- Current node

end -- class LINKED_TREE_CURSOR


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
