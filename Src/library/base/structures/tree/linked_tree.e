--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Trees implemented using a linked list representation

indexing

	names: linked_tree, tree, linked_list;
	representation: recursive, linked;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_TREE [G] inherit

	DYNAMIC_TREE [G]
		redefine
			parent
		end;

	LINKABLE [G]
		rename
			put as replace,
			right as right_sibling,
			put_between as l_put_between,
			put_right as l_put_right
		export
			{LINKED_TREE}
				l_put_right, forget_right;
			{NONE}
				l_put_between
		end;

	LINKABLE [G]
		rename
			put as replace,
			right as right_sibling,
			put_right as l_put_right
		export
			{LINKED_TREE}
				l_put_right, forget_right
		redefine
			put_between
		select
			put_between
		end;

	LINKED_LIST [G]
		rename
			make as ll_make,
			item as child_item,
			active as child,
			has as ll_has,
			search as search_child,
			first_element as first_child,
			last_element as last_child,
			readable as child_readable,
			replace as ll_replace,
			add as ll_add,
			put as ll_put,
			merge_left as ll_merge_left,
			merge_right as ll_merge_right,
			fill as ll_fill,
			writable as child_writable,
			extensible as child_extensible,
			remove as remove_child,
			remove_left as remove_left_child,
			remove_right as remove_right_child,
			contractable as child_contractable,
			duplicate as ll_duplicate,
			empty as is_leaf,
			full as ll_full,
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
			{NONE}
				ll_has, ll_add, ll_duplicate,
				ll_put, ll_replace, ll_fill,
				ll_merge_left, ll_merge_right,
				ll_contractable, ll_full
		undefine
			child_readable, is_leaf, arity,
			child_writable, child_extensible,
			child_contractable,
			sequential_representation
		redefine
			first_child
		end

creation

	make

feature -- Creation

	make (v: like item) is
			-- Create single node with item `v'.
		do
			l_put (v);
			ll_make
		end;

feature -- Access

	parent: LINKED_TREE [G];
			-- Parent of `Current'

	first_child: like parent;
			-- First child of `Current'

feature -- Insertion

	child_add (v: like item) is
			-- Add `v' to the children list of `Current'.
			-- Do not move child cursor.
		do
			add (v);
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
			add_child_right (n);
			remove_child
		end;

	add_child_left (n: like parent) is
			-- Add `n' to the left of cursor position.
			-- Do not move cursor.
		local
			temp: like item
		do
			n.forget_right;
			if child_after then
				child_back;
				add_child_right (n);
				child_forth; child_forth
			else
				temp := n.item;
				n.put (child_item);
				child_replace (temp);
				add_child_right (n);
				child_forth
			end
		end;

	add_child_right (n: like parent) is
			-- Add `n' to the right of cursor position.
			-- Do not move cursor.
		do
			n.forget_right;
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

	put_between (bef, aft: like first_child) is
			-- Put `Current' node between `bef' and `aft'.
		do
			l_put_between (bef, aft);
			if bef /= Void then
				attach_to_parent (bef.parent)
			elseif aft /= Void then
				attach_to_parent (aft.parent)
			end
		end;

	merge_tree_before (other: like first_child) is
			-- Merge children of `other' into `Current'
			-- before cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other);
			ll_merge_left (other)
		end;

	merge_tree_after (other: like first_child) is
			-- Merge children of `other' into `Current'
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other);
			ll_merge_right (other)
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

	new_tree: like Current is
			-- Instance of class `like Current'.
			-- This feature should be implemented in
			-- every effective descendant of LINKED_TREE,
			-- so as to return an adequately allocated and
			-- initialized object.
		do
			!!Result.make (item)
		end;

invariant

	off_constraint: (child = Void) implies child_off

end -- class LINKED_TREE
