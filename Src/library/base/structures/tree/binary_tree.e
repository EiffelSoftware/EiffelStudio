--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Binary trees
-- implemented as fixed trees

indexing

	names: binary_tree, tree, fixed_tree;
	representation: recursive, array;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BINARY_TREE [G] inherit

		FIXED_TREE [G]
			rename
				make as ft_make,
				first_child as left_child,
				last_child as right_child
			redefine
				parent
			end

creation

	make

feature -- Creation

	make (v: like item) is
			-- Create node with item `v'.
		do
			ft_make (2, v)
		ensure
			node_item: item = v;
			binary_tree_arity: arity = 2;
			no_child: (left_child = Void) and (right_child = Void)
		end;

feature -- Access

	parent: BINARY_TREE [G]
			-- Parent of `Current'

feature -- Insertion

	child_put_left (v: like item) is
			-- Put item `v' at left child position;
			-- create child if no left child.
		local
			node: like parent
		do
			if has_left then
				left_child.put (v)
			else
				!!node.make (v);
				put_left_child (node)
			end
		ensure
			left_child_item: left_child.item = v
		end;

	child_put_right (v: like item) is
			-- Put item `v' at right child position;
			-- create child if no right child.
		local
			node: like parent
		do
			if has_right then
				right_child.put (v)
			else
				!!node.make (v);
				put_right_child (node)
			end
		ensure
			right_child_item: right_child.item = v
		end;

feature -- Deletion

	remove_left_child is
			-- Remove the left child of `Current'.
		do
			child_start;
			remove_child
		ensure
			left_child_removed: left_child = Void
		end;

	remove_right_child is
			-- Remove the right child of `Current'.
		do
			child_finish;
			remove_child
		ensure
			right_child_removed: right_child = Void
		end;

feature -- Number of elements

	has_left: BOOLEAN is
			-- Does left child exist?
		do
			Result := (left_child /= Void)
		ensure
			has_left_definition: Result = (left_child /= Void)
		end;

	has_right: BOOLEAN is
			-- Does right child exist?
		do
			Result := (right_child /= Void)
		ensure
			has_right_definition: Result = (right_child /= Void)
		end;

	has_both: BOOLEAN is
			-- Do both children exist?
		do
			Result := (left_child /= Void) and (right_child /= Void)
		ensure
			has_both_definition: Result = (has_left and has_right)
		end;

	has_none: BOOLEAN is
			-- Is `Current' childless?
		do
			Result := (left_child = Void) and (right_child = Void)
		ensure
			has_none_definition: Result = (not has_left and not has_right)
		end;

	height: INTEGER is
			-- Height of the tree: 1 + (max height of the children)
		local
			hl, hr: INTEGER
		do
			if has_left then hl := left_child.height end;
			if has_right then hr := right_child.height end;
			if hl > hr then
				Result := 1 + hl
			else
				Result := 1 + hr
			end
		end;

feature {NONE} -- Secret

	put_left_child (other: like parent) is
			-- Make `other' the left child of `Current'.
		require
			new_node_exists: other /= Void
		do
			child_start;
			put_child (other)
		ensure
			left_child_put: left_child = other
		end;

	put_right_child (other: like parent) is
			-- Make `other' the right child of current node.
		require
			new_node_exists: other /= Void
		do
			child_finish;
			put_child (other)
		ensure
			right_child_put: right_child = other
		end;

invariant

	is_binary_tree: arity = 2

end -- class BINARY_TREE
