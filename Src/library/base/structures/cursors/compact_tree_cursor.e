indexing

	description:
		"Cursors for compact trees";

	status: "See notice at end of class";
	names: compact_tree_cursor, cursor;
	date: "$Date$";
	revision: "$Revision$"

class COMPACT_TREE_CURSOR inherit

	CURSOR

creation

	make

feature {COMPACT_CURSOR_TREE} -- Initialization

	make (i: INTEGER; aft, bef, bel, abv: BOOLEAN) is
			-- Create a cursor and set it up on `i'.
		do
			active := i;
			after := aft;
			below := bel;
			before := bef;
			above := abv
		end;

feature {COMPACT_CURSOR_TREE} -- Access

	active: INTEGER;
			-- Index of current item



feature {COMPACT_CURSOR_TREE} -- Status report

	after: BOOLEAN;
		-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN;
		-- Is there no valid cursor position to the left of cursor?

	below: BOOLEAN;
		-- Is there no valid cursor position below cursor?

	above: BOOLEAN;
		-- Is there no valid cursor position above cursor?

end -- class COMPACT_TREE_CURSOR


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

