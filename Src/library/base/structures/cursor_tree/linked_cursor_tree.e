indexing

	description:
		"Cursor trees in linked representation";

	status: "See notice at end of class";
	names: linked_cursor_tree, cursor_tree;
	access: cursor, membership;
	representation: recursive, linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_CURSOR_TREE [G] inherit

	RECURSIVE_CURSOR_TREE [G]
		redefine
			extend, put_right,
			active, cursor_anchor, is_leaf
		end

creation

	make, make_root

feature -- Initialization

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

	make_root (v: G) is
			-- Create a tree with `v' as root.
		do
			make;
			put_root (v)
		end;

feature -- Status report

	full: BOOLEAN is false;
			-- Is tree filled to capacity? (Answer: no.)

	prunable: BOOLEAN is true

	is_leaf: BOOLEAN is
		do
			if not off then
				Result := not below and then active.arity = 0
			end
		end

feature -- Element change

	extend (v: G) is
		-- Add node of value `v' at extreme right of level of current node if
		-- it exists and is not root.
		local
			pos: CURSOR;
		do
			pos := cursor;
			go_last_child;
			put_right (v);
			go_to (pos);
			if below then
				below := false;
				down (0);
			end;
		end;

	put_right (v: G) is
			-- Add `v' to the right of cursor position.
		do
			if below then
				active.child_put_right (v);
				active.child_forth;
				active_parent := active;
				active := active_parent.child;
				below := false
			elseif before then
				active_parent.child_put_left (v);
				active_parent.child_back;
				active := active_parent.child
			else
				active_parent.child_put_right (v)
			end
		end;

	put_root (v: G) is
			-- Put `v' as root of an empty tree.
		require
			is_empty: empty
		do
			above_node.child_put_right (v);
			active_parent := above_node;
			active := active_parent.child
		ensure
			is_root: is_root;
			count = 1
		end;

	put_child (v: G) is
			-- Put `v' as child of a leaf.
		require
			is_leaf: is_leaf
		do
			down (0)
			put_right (v)
		end

feature {LINKED_CURSOR_TREE} -- Implementation

	new_tree: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make
		end;

feature {NONE} -- Implementation

	cursor_anchor: LINKED_TREE_CURSOR [G];
			-- Anchor for definitions concerning cursors

	active: LINKED_TREE [G];
			-- Current node

end -- class LINKED_CURSOR_TREE


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
