--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.		--
--|    270 Storke Road, Suite 7 Goleta, California 93117		--
--|                   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursor tree implementation using class LINKED_TREE

indexing

	names: linked_cursor_tree, cursor_tree;
	access: cursor, membership;
	representation: recursive, linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_CURSOR_TREE [G] inherit

	RECURSIVE_CURSOR_TREE [G]
		redefine
			add_right,
			full,
			active, cursor_anchor
		end

creation

	make

feature -- Creation

	make is
			-- Create an empty tree.
		local
			dummy: G
		do
			!! above_node.make (dummy);
			active := above_node
		ensure
			is_above: above;
			is_empty: empty
		end;

feature -- Insertion

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

feature -- Number of elements

	full: BOOLEAN is false;
			-- Is `Current' full?

feature {LINKED_CURSOR_TREE} -- Creation

	new_tree: like Current is
			-- Instance of class `like Current'.
		do
			!! Result.make
		end;

feature {NONE} -- Cursor

	cursor_anchor: LINKED_TREE_CURSOR [G];
			-- Anchor for definitions concerning cursors

feature {NONE} -- Representation

	active: LINKED_TREE [G];
			-- Current node

end
