indexing

	description:
		"Cursor trees in linked representation";

	copyright: "See notice at end of class";
	names: linked_cursor_tree, cursor_tree;
	access: cursor, membership;
	representation: recursive, linked;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_CURSOR_TREE [G] inherit

	RECURSIVE_CURSOR_TREE [G]
		redefine
			put_right,
			active, cursor_anchor
		end

creation

	make

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

feature -- Status report

	full: BOOLEAN is false;
			-- Is tree filled to capacity? (Answer: no.)

	prunable: BOOLEAN is true

feature -- Element change

	put_right (v: G) is
			-- Put `v' to the right of cursor position.
		do
			if below then
				active.child_put_right (v);
				active.child_forth;
				active_parent := active;
				active := active.child;
				below := false
			elseif before then
				active_parent.child_put_left (v);
				active_parent.child_back;
				active := active_parent.child
			else
				active_parent.child_put_right (v)
			end
		end;

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
