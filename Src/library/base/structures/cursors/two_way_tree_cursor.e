--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursors for two way cursor trees

indexing

	names: two_way_tree_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_TREE_CURSOR [G] inherit

	RECURSIVE_TREE_CURSOR [G]
		export
			{TWO_WAY_CURSOR_TREE} make
		redefine
			active
		end

feature {TWO_WAY_CURSOR_TREE} -- Representation

	active: TWO_WAY_TREE [G]
			-- Current node

end -- class TWO_WAY_TREE_CURSOR
