indexing

	description:
		"Cursors for compact trees";

	copyright: "See notice at end of class";
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

	before: BOOLEAN;

	below: BOOLEAN;

	above: BOOLEAN;

end -- class COMPACT_TREE_CURSOR


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
