--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursor for compact cursor trees

indexing

	names: compact_tree_cursor, cursor;
	date: "$Date$";
	revision: "$Revision$"

class COMPACT_TREE_CURSOR inherit

	CURSOR

creation

	make

feature  {COMPACT_CURSOR_TREE} -- Initialization

	make (i: INTEGER; aft, bef, bel: BOOLEAN) is
			-- Create a cursor and set it up on `i'.
		do
			active := i;
			after := aft;
			below := bel;
			before := bef;
		end;

feature  {COMPACT_CURSOR_TREE} -- Access

	active: INTEGER;
			-- Index of current item



feature  {COMPACT_CURSOR_TREE} -- Status report

	after: BOOLEAN;

	before: BOOLEAN;

	below: BOOLEAN;

end -- class COMPACT_TREE_CURSOR
