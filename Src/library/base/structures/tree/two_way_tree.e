--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Trees implemented using a two way linked list representation

indexing

	names: two_way_tree, tree, two_way_list;
	representation: recursive, linked;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_TREE [G] inherit

	DYNAMIC_TREE [G]
		redefine
			parent
		end;

	BI_LINKABLE [G]
		rename
			put as replace,
			left as left_sibling,
			right as right_sibling,
			put_between as bl_put_between,
			put_left as bl_put_left,
			put_right as bl_put_right
		export
			left_sibling, right_sibling;
			{TWO_WAY_TREE}
				bl_put_left, bl_put_right,
				forget_left, forget_right;
			{NONE} bl_put_between
		end;

	BI_LINKABLE [G]
		rename
			put as replace,
			left as left_sibling,
			right as right_sibling,
			put_left as bl_put_left,
			put_right as bl_put_right
		export
			left_sibling, right_sibling;
			{TWO_WAY_TREE}
				bl_put_left, bl_put_right,
				forget_left, forget_right;
		redefine
			put_between
		select
			put_between
		end;

	TWO_WAY_LIST [G]
		rename
			make as twl_make,
			item as child_item,
			active as child,
			has as twl_has,
			search as search_child,
			search_equal as search_equal_child,
			first_element as first_child,
			last_element as last_child,
			readable as child_readable,
			replace as twl_replace,
			add as twl_add,
			put as twl_put,
			merge_left as twl_merge_left,
			merge_right as twl_merge_right,
			fill as twl_fill,
			writable as child_writable,
			remove as remove_child,
			remove_left as remove_left_child,
			remove_right as remove_right_child,
			contractable as child_contractable,
			extensible as child_extensible,
			duplicate as twl_duplicate,
			empty as is_leaf,
			full as twl_full,
			count as arity,
			start as child_start,
			finish as child_finish,
			back as child_back,
			forth as child_forth,
			index as child_index,
			cursor as child_cursor,
			after as child_after,
			before as child_before,
			off as child_off,
			go_i_th as child_go_i_th,
			go_to as child_go_to,
			isfirst as child_isfirst,
			islast as child_islast
		export
			{ANY} child
		undefine
			child_readable, is_leaf,
			child_writable,
			child_contractable,
			sequential_representation,
			child_isfirst, child_islast, valid_cursor_index
		redefine
			first_child, last_child, new_cell
		end

creation

	make

feature -- Creation

	make (v: like item) is
			-- Create single node with item `v'.
		do
			put (v);
			twl_make
		end;

feature -- Access

	parent: TWO_WAY_TREE [G];
			-- Parent of `Current'

	first_child: like parent;
			-- First child of `Current'

	last_child: like parent;
			-- Last child of `Current'

feature -- Insertion

	child_add (v: like item) is
			-- Add `v' to the children list of `Current'.
			-- Do not move child cursor.
		do
			twl_add (v);
			last_child.attach_to_parent (Current)
		end;

	child_replace (v: like item) is
			-- Put item `v' at active child position.
		do
			child.replace (v)
		end;

	child_add_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move child cursor.
		do
			add_left (v);
			previous.attach_to_parent (Current)
		end;

	child_add_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move child cursor.
		do
			add_right (v);
			next.attach_to_parent (Current)
		end;

	add_child (n: like parent) is
			-- Add `n' to the children list of `Current'.
			-- Do not move child cursor.
		do
			if is_leaf then
				first_child := n;
				child := n
			else
				last_child.bl_put_right (n);
				if child_after then
					child := n
				end
			end;
			last_child := n;
			n.attach_to_parent (Current);
			arity := arity + 1
		end;

	replace_child (n: like parent) is
			-- Replace current child by `n'.
		do
			add_child_right (n);
			remove_child
		end;

	add_child_left (n: like parent) is
			-- Add `n' to the left of cursor position.
			-- Do not move cursor.
		do
			n.forget_left;
			n.forget_right;
			if is_leaf then
				first_child := n;
				last_child := n;
				child := n
			elseif child_after then
				n.bl_put_left (last_child);
				last_child := n;
				child := n
			elseif child_isfirst then
				n.bl_put_right (child);
				first_child := n
			else
				n.bl_put_left (child.left_sibling);
				n.bl_put_right (child);
			end;
			n.attach_to_parent (Current);
			arity := arity + 1
		end;

	add_child_right (n: like parent) is
			-- Add `n' to the right of cursor position.
			-- Do not move cursor.
		do
			n.forget_left;
			n.forget_right;
			if is_leaf then
				first_child := n;
				last_child := n;
				child := n
			elseif child_before then
				n.bl_put_right (first_child);
				first_child := n;
				child := n
			elseif child_islast then
				child.bl_put_right (n);
				last_child := n
			else
				n.bl_put_right (child.right_sibling);
				n.bl_put_left (child)
			end;
			n.attach_to_parent (Current);
			arity := arity + 1
		end;

	put_between (bef, aft: like first_child) is
			-- Put `Current' node between `bef' and `aft'.
		do
			bl_put_between (bef, aft);
			if bef /= Void then
				attach_to_parent (bef.parent)
			elseif aft /= Void then
				attach_to_parent (aft.parent)
			end
		end;

	merge_tree_before (other: like first_child) is
			-- Merge children of `other' into `Current'
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other);
			twl_merge_left (other)
		end;

	merge_tree_after (other: like first_child) is
			-- Merge children of `other' into `Current'
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other);
			twl_merge_right (other)
		end;

feature {NONE} -- Insertion

	attach (other: like first_child) is
				-- Attach all children of `other' to `Current'.
		do
			from
				other.child_start
			until
				other.child_off
			loop
				other.child.attach_to_parent (Current);
				other.child_forth
			end
		end;

feature {LINKED_TREE} -- Creation


	new_cell (v: like item): like first_child is
		do
			!!Result.make (v)
		end;

	new_tree: like Current is
			-- Instance of class `like Current'.
			-- This feature should be implemented in
			-- every effective descendant of TWO_WAY_TREE,
			-- so as to return an adequately allocated and
			-- initialized object.
		do
			!!Result.make (item)
		end;

invariant

	off_constraint: (child = Void) implies child_off

end -- class TWO_WAY_TREE
