--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursors for recursive cursor trees

indexing

	names: recursive_tree_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class RECURSIVE_TREE_CURSOR [G] inherit

	CURSOR

creation {RECURSIVE_CURSOR_TREE}

	make

feature {RECURSIVE_CURSOR_TREE} -- Creation

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

feature {RECURSIVE_CURSOR_TREE} -- Representation

	active: TREE [G];
			-- Current node

	active_parent: like active;
			-- Parent of current node

	after: BOOLEAN;
			-- Is `Current' after the end of the tree?

	before: BOOLEAN;
			-- Is `Current' before the start of the tree?

	below: BOOLEAN;
			-- Is `Current' below the tree?

end -- class RECURSIVE_TREE_CURSOR
