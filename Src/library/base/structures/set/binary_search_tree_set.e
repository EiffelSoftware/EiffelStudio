--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sorted sets
-- implemented as binary search trees

indexing

	names: binary_search_tree_set, set, binary_search_tree;
	representation: recursive, array;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BINARY_SEARCH_TREE_SET [G -> PART_COMPARABLE] inherit

	COMPARABLE_SET [G];

	BINARY_SEARCH_TREE [G]
		rename
			make as tree_make,
			item as tree_item,
			has as tree_has,
			min as tree_min,
			max as tree_max,
			put as tree_put,
			wipe_out as tree_wipe_out
		export
			{NONE}
				all;
			{BINARY_SEARCH_TREE_SET}
				clean_child, tree_item;
			balance
		redefine
			parent,
			new_tree
		end

creation

	make

feature -- Creation

	make is
			-- Create node with void item.
		local
			dummy: like tree_item
		do
			tree_make (dummy);
			depth := -1
		end;

feature -- Access

	has (v: like tree_item): BOOLEAN is
			-- Is there a node with item `v' in `Current'?
			-- (According to the currently adopted
			-- discrimination rule)
		do
			Result := (tree_item /= Void) and then tree_has (v)
		end;

	min: like tree_item is
			-- Minimum in `Current'
		do
			if has_left then
				Result := left_child.min
			else
				Result := tree_item
			end
		end;

	max: like tree_item is
			-- Maximum in `Current'
		do
			if has_right then
				Result := right_child.max
			else
				Result := tree_item
			end
		end;

feature {NONE} -- Access

	parent: like Current;
			-- Parent of `Current'
			-- (Now of type `Current')

feature -- Insertion

	add (v: like tree_item) is
			-- Put `v' at proper position in set
			-- (unless one already exists).
		require else
			item_exists: v /= Void
		do
			if tree_item = Void then
				tree_put (v)
			else
				if v < tree_item then
					if left_child = Void then
						put_left_child (new_tree (v))
					else
						left_child.put (v)
					end;
					balanced := false
				elseif tree_item < v then
					if right_child = Void then
						put_right_child (new_tree (v))
					else
						right_child.put (v)
					end;
					balanced := false
				end
			end
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		do
			if other.right_child /= Void then
				merge (other.right_child)
			end;
			if other.left_child /= Void then
				merge (other.left_child)
			end;
			if other.tree_item /= Void then
				add (other.tree_item)
			end
		end;

feature -- Deletion

	remove_item (v: like tree_item) is
			-- Remove `v' from `Current' if it is already present.
		do
			if (v < tree_item) and then (left_child /= Void) then
				left_child.remove (v)
			elseif (tree_item < v) and then (right_child /= Void) then
				right_child.remove (v)
			else
				remove_tree_item
			end
		end;

	wipe_out is
			-- Empty `Current'.
		do
			tree_item := Void;
			remove_right_child;
			remove_left_child;
			balanced := true;
			depth := -1
		end;

feature {BINARY_SEARCH_TREE_SET} -- Deletion

	clean_child is
			-- Get rid of useless references.
		do
			if (left_child /= Void) and then
				(left_child.tree_item = Void) then
				remove_left_child
			end;
			if (right_child /= Void) and then
				(right_child.tree_item = Void) then
				remove_right_child
			end;
		end;

	remove_tree_item is
			-- Remove current item from `Current'.
		local
			v: like tree_item;
		do
			if has_none then
				tree_item := Void;
				if parent /= Void then
					parent.clean_child
				end
			elseif has_left then
				v := left_child.max;
				tree_put (v);
				left_child.remove (v)
			else
				v := right_child.min;
				tree_put (v);
				right_child.remove (v)
			end
		end;

feature -- Transformation

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		do
			if right_child /= Void then
				right_child.intersect (other)
			end;
			if left_child /= Void then
				left_child.intersect (other)
			end;
			if not other.has (tree_item) then
				remove_tree_item
			end
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		require
			set_exists: other /= Void
		do
			if right_child /= Void then
				right_child.subtract (other)
			end;
			if left_child /= Void then
				left_child.subtract (other)
			end;
			if other.has (tree_item) then
				remove_tree_item
			end;
		end;

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is `Current' a subset of `other'?
		do
			Result := (right_child = Void) or else
				right_child.is_subset (other);
			Result := Result and (left_child = Void or else
				left_child.is_subset (other));
			Result := Result and then (tree_item = Void or else
				other.has (tree_item))
		end;

feature -- Number of elements

	count: INTEGER is
			-- Number of elements in `Current'
		do
			if right_child /= Void then
				Result := right_child.count
			end;
			if left_child /= Void then
				Result := Result + left_child.count
			end;
			if tree_item /= Void then
				Result := Result + 1
			end
		end;

feature {NONE} -- Creation

	new_tree (v: like tree_item): like Current is
			-- New allocated node with `tree_item' set to `v'
		do
			!!Result.make;
			Result.tree_put (v)
		end;

end -- class BINARY_SEARCH_TREE_SET
