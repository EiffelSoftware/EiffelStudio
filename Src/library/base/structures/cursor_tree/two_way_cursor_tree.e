--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	--
--|    270 Storke Road, Suite 7 Goleta, California 93117	--
--|                   (805) 685-1006				--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursor tree implementation using class TWO_WAY_TREE

indexing

	names: two_way_cursor_tree, cursor_tree;
	access: cursor, membership;
	representation: recursive, linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_CURSOR_TREE [G] inherit

	RECURSIVE_CURSOR_TREE [G]
		redefine
			add_right,
			full,
			active, cursor_anchor
		end

creation

	make

feature -- Initialization

	make is
			-- Create an empty tree.
		local
			dummy: G;
		do
			!! above_node.make (dummy);
			active := above_node;
		ensure
			is_above: above;
			is_empty: empty
		end;

feature -- Modification & Insertion

	add_right (v: G) is
			-- Put `v' to the right of cursor position.
		do
			if below then
				active.child_add_right (v);
				active.child_forth;
				active_parent := active;
				active := active.child;
				below := false
			elseif before then
				active_parent.child_add_left (v);
				active_parent.child_back;
				active := active_parent.child
			else
				active_parent.child_add_right (v)
			end
		end;

feature -- Status report

	full: BOOLEAN is false;
			-- Is `Current' full?

feature  {LINKED_CURSOR_TREE} -- Initialization

	new_tree: like Current is
			-- Instance of class `like Current'
		do
			!! Result.make
		end;

feature  {NONE} -- Access

	cursor_anchor: TWO_WAY_TREE_CURSOR [G];
			-- Anchor for definitions concerning cursors
 
	active: TWO_WAY_TREE [G];
			-- Current node

end -- class TWO_WAY_CURSOR_TREE
