--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursors for linked cursor trees

indexing

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

feature {LINKED_CURSOR_TREE} -- Representation

	active: LINKED_TREE [G]
			-- Current node

end -- class LINKED_TREE_CURSOR
