indexing

	description:
		"Trees implemented using a linked list representation";

	status: "See notice at end of class";
	names: linked_tree, tree, linked_list;
	representation: recursive, linked;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_TREE [G] inherit

	DYNAMIC_TREE [G]
		undefine
			child_after, child_before, child_item,
			child_off
		redefine
			parent
		select
			has
		end;

	LINKABLE [G]
		rename
			right as right_sibling,
			put_right as l_put_right
		export
			{ANY} put, replace;
			{LINKED_TREE} l_put_right, forget_right;
		end;

	LINKED_LIST [G]
		rename
			active as child,
			put_left as child_put_left,
			put_right as child_put_right,
			after as child_after,
			back as child_back,
			before as child_before,
			count as arity,
			cursor as child_cursor,
			duplicate as ll_duplicate,
			empty as is_leaf,
			extend as child_extend,
			extendible as child_extendible,
			fill as ll_fill,
			finish as child_finish,
			first_element as first_child,
			forth as child_forth,
			full as ll_full,
			go_i_th as child_go_i_th,
			go_to as child_go_to,
			has as ll_has,
			index as child_index,
			isfirst as child_isfirst,
			islast as child_islast,
			item as child_item,
			last_element as last_child,
			make as ll_make,
			merge_left as ll_merge_left,
			merge_right as ll_merge_right,
			off as child_off,
			prune as ll_prune,
			put as child_put,
			readable as child_readable,
			remove as remove_child,
			remove_left as remove_left_child,
			remove_right as remove_right_child,
			replace as child_replace,
			search as search_child,
			start as child_start,
			writable as child_writable
		export
			{ANY}
				child;
			{NONE}
				ll_make, ll_has,
			 	ll_merge_left, ll_merge_right,
			 	ll_fill, ll_duplicate, ll_full;
		undefine
			child_readable, is_leaf,
			child_writable,
			linear_representation,
			child_isfirst, child_islast, valid_cursor_index
		redefine
			first_child, new_cell
		select
			is_leaf
		end

creation

	make

feature -- Initialization

	make (v: like item) is
			-- Create single node with item `v'.
		do
			put (v);
			ll_make
		ensure
			is_root;
			is_leaf
		end;

feature -- Access

	parent: LINKED_TREE [G];
			-- Parent of current node

	first_child: like parent;
			-- Leftmost child

	left_sibling: like parent is
			-- Left neighbor (if any)
		do
			if parent /= Void then
				from
					Result := parent.first_child;
				until
					Result = Void or else Result.right_sibling = Current
				loop
					Result := Result.right_sibling
				end
			end
		end

feature {RECURSIVE_CURSOR_TREE} -- Element change

	set_child (n: like parent) is
			-- Set the child of parent to `n'.
		do
			child := n
		ensure then
			child_set: child = n
		end;

feature -- Element change

	put_child (n: like parent) is
			-- Add `n' to the list of children.
			-- Do not move child cursor.
		do
			if is_leaf then
				first_child := n;
				child := n
			else
				last_child.l_put_right (n);
				if child_after then
					child := n
				end
			end;
			n.attach_to_parent (Current);
			arity := arity + 1
		end;

	replace_child (n: like parent) is
			-- Replace current child by `n'.
		do
			put_child_right (n);
			remove_child
		end;

	put_child_left (n: like parent) is
			-- Add `n' to the left of cursor position.
			-- Do not move cursor.
		local
			temp: like first_child
		do
			child_back;
			put_child_right (n);
			child_forth;
			child_forth
		end;

	put_child_right (n: like parent) is
			-- Add `n' to the right of cursor position.
			-- Do not move cursor.
		do
			if child_before then
				n.l_put_right (first_child);
				first_child := n
			else
				n.l_put_right (child.right_sibling);
				child.l_put_right (n)
			end;
			n.attach_to_parent (Current);
			arity := arity + 1
		end;

	merge_tree_before (other: like first_child) is
			-- Merge children of `other' into current structure
			-- before cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other);
			ll_merge_left (other)
		end;

	merge_tree_after (other: like first_child) is
			-- Merge children of `other' into current structure
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other);
			ll_merge_right (other)
		end;

	prune (n: like first_child) is
		local
			l_child: like first_child;
			left_child: like first_child
		do
			from
				l_child := first_child
			until
				l_child = Void or l_child = n
			loop
				left_child := l_child;
				l_child := l_child.right_sibling
			end;
			if l_child /= Void then
				if left_child /= Void then
					-- when `n' is after the first item.
					left_child.l_put_right (l_child.right_sibling)
					child := left_child
				else
					-- when `n' is the first item.
					first_child := first_child.right_sibling
					child := first_child
				end;

				arity := arity - 1;
				if is_leaf and not child_before then
					child_after := true
				end;

				n.attach_to_parent (Void)
			end;
		end;

feature {LINKED_TREE} -- Implementation

	new_cell (v: like item): like first_child is
		do
			!! Result.make (v);
			Result.attach_to_parent (Current)
		end;

	new_tree: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make (item)
		end;

feature {NONE} -- Implementation

	attach (other: like first_child) is
				-- Attach all children of `other' to current node.
		local
			cursor: CURSOR;
		do
			cursor := other.child_cursor;
			from
				other.child_start
			until
				other.child_off
			loop
				other.child.attach_to_parent (Current);
				other.child_forth
			end;
			other.child_go_to (cursor)
		end;

invariant

	no_void_child: readable_child = child_readable

end -- class LINKED_TREE


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
