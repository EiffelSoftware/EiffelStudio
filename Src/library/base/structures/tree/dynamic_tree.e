--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Dynamically modifiable trees

indexing

	names: dynamic_tree, tree;
	representation: recursive;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DYNAMIC_TREE [G] inherit

	TREE [G]
		redefine
			parent
		end

feature -- Access

	parent: DYNAMIC_TREE [G];
			-- Parent of `Current'

feature -- Insertion

	add (v: like item) is
			-- Add `v' to `Current'.
		do
			child_add (v)
		end;

	child_add (v: like item) is
			-- Add `v' to the children list of `Current'.
			-- Do not move child cursor.
		deferred
		end;

	child_add_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move child cursor.
		require
			extensible: extensible;
			not_child_before: not child_before
		deferred
		end;

	child_add_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move child cursor.
		require
			extensible: extensible;
			not_child_after: not child_after
		deferred
		end;

	add_child (n: like parent) is
			-- Add `n' to the children list of `Current'.
			-- Do not move child cursor.
		require else
			non_void_argument: n /= Void
		deferred
		end;

	add_child_left (n: like parent) is
			-- Add `n' to the left of cursor position.
			-- Do not move cursor.
		require
			extensible: extensible;
			not_child_before: not child_before;
			non_void_argument: n /= Void
		deferred
		end;

	add_child_right (n: like parent) is
			-- Add `n' to the right of cursor position.
			-- Do not move cursor.
		require
			extensible: extensible;
			not_child_after: not child_after;
			non_void_argument: n /= Void
		deferred
		end;

	put_between (bef, aft: like first_child) is
			-- Put `Current' between `bef' and `aft'.
		require
			same_parent:
				(bef /= Void and aft /= Void) implies
				(bef.parent = aft.parent)
		deferred
		end;

	merge_tree_before (other: like first_child) is
			-- Merge children of `other' into `Current'
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		require
			not_child_off: not child_off;
			other_has_children:
				(other /= Void) and then (other.arity > 0)
		deferred
		ensure
			other_is_leaf: other.is_leaf
		end;

	merge_tree_after (other: like first_child) is
			-- Merge children of `other' into `Current'
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		require
			not_child_off: not child_off;
			other_has_children:
				(other /= Void) and then (other.arity > 0)
		deferred
		ensure
			other_is_leaf: other.is_leaf
		end;

	extensible: BOOLEAN is true;
			-- May new items be added to `Current'?

feature {DYNAMIC_TREE} -- Insertion

	fill_subtree (other: TREE [G]) is
			-- Fill children with children of `other'.
		do
			from
				other.child_start
			until
				other.child_off
			loop
				child_add (other.item);
				other.child_forth
			end;
			from
				child_start;
				other.child_start
			until
				child_off
			loop
				child.fill_subtree (other.child);
				other.child_forth;
				child_forth
			end
		end;

feature -- Transformation

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-tree beginning at cursor position and
			-- having min (`n', `arity' - `child_index' + 1)
			-- children
		local
			pos: CURSOR;
			counter: INTEGER
		do
			from
				Result := new_tree;
				pos := child_cursor
			until
				child_after or else (counter = n)
			loop
				Result.add_child (child.duplicate_all);
				child_forth;
				counter := counter + 1
			end;
			child_go_to (pos)
		end;

feature {DYNAMIC_TREE} -- Transformation

	duplicate_all: like Current is
			-- Copy of sub-tree including all children
		local
			pos: CURSOR
		do
			from
				Result := new_tree;
				pos := child_cursor;
				child_start
			until
				child_off
			loop
				Result.add_child (child.duplicate_all);
				Result.child_forth;
				child_forth
			end;
			child_go_to (pos)
		end;

feature -- Deletion

	remove_left_child is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require
			is_not_first: not child_isfirst;
			child_contractable: child_contractable
		deferred
		ensure
	--		new_count: count = old count - 1;
	--		new_arity: arity = old arity - 1;
	--		new_child_index: child_index = old child_index - 1
		end;

	remove_right_child is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			is_not_last: not child_islast;
			child_contractable: child_contractable
		deferred
		ensure
	--	  new_count: count = old count - 1;
	--	  new_arity: arity = old arity - 1;
	--	  new_child_index: child_index = old child_index
		end;

	wipe_out is
			-- Empty `Current'.
		deferred
		end;

	child_contractable: BOOLEAN is
			-- May items be removed from `Current'?
		do
			Result := not child_off
		end;

feature {DYNAMIC_TREE} -- Creation

	new_tree: like Current is
			-- Instance of class `like Current'.
			-- This feature should be implemented in
			-- every effective descendant of DYNAMIC_TREE,
			-- so as to return an adequately allocated and
			-- initialized object.
		deferred
		ensure
			result_exists: Result /= Void;
			result_item: Result.item = item
		end;

feature -- Obsolete features

	remove_child_left (n: INTEGER) is
			obsolete "Use ``remove_left_child'' repeatedly"
			-- Remove min (`n', `child_index' - 1) children to
			-- the left of child cursor.
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				child_off or else (counter > n)
			loop
				remove_left_child;
				counter := counter + 1
			end
		end;

	remove_child_right (n: INTEGER) is
			obsolete "Use ``remove_right_child'' repeatedly"
			-- Remove min (`n', `arity' - `child_index') children to
			-- the right of child cursor.
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				child_off or else (counter > n)
			loop
				remove_right_child;
				counter := counter + 1
			end
		end;

invariant

	extensible_definition: extensible = true;
	child_property: child_contractable = not child_off

end -- class DYNAMIC_TREE
