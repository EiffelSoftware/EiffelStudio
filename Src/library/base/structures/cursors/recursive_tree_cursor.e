indexing

	description:
		"Cursors for recursive trees";

	status: "See notice at end of class";
	names: recursive_tree_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class RECURSIVE_TREE_CURSOR [G] inherit

	CURSOR

creation {RECURSIVE_CURSOR_TREE}

	make

feature {RECURSIVE_CURSOR_TREE} -- Initialization

	make (active_node, parent_of_active: like active;
			aft, bef, bel: BOOLEAN) is
			-- Create a cursor and set it up on `active_node'.
		do
			active := active_node;
			active_parent := parent_of_active;
			after := aft;
			before := bef;
			below := bel
		end;

feature {RECURSIVE_CURSOR_TREE} -- Access

	active: DYNAMIC_TREE [G];
			-- Current node

	active_parent: like active;
			-- Parent of current node

feature {RECURSIVE_CURSOR_TREE} -- Status report

	after: BOOLEAN;
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN;
			-- Is there no valid cursor position to the left of cursor?

	below: BOOLEAN;
			-- Is there no valid cursor position below cursor?

end -- class RECURSIVE_TREE_CURSOR


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

