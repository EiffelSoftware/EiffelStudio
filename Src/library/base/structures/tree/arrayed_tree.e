indexing

	description:
		"Trees where the children of each node are kept in an array"

	status: "See notice at end of class"
	names: tree;
	representation: recursive, array;
	access: cursor, membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class ARRAYED_TREE [G] inherit

	CELL [G]
		undefine
			is_equal
		redefine
			copy
		end

	DYNAMIC_TREE [G]
		rename
			empty as al_empty
		export
			{NONE} al_empty
		undefine
			child_after, readable_child,
			writable_child, child_off, child_before
		redefine
			parent, attach_to_parent, duplicate, extend,
			duplicate_all, fill_subtree, copy
		select
			object_comparison, linear_representation,
			has
		end

	ARRAYED_LIST [ARRAYED_TREE [G]]
		rename
			make as al_make,
			item as child,
			i_th as array_item,
			last as last_child,
			first as first_child,
			search as search_child,
			has as al_has,
			readable as readable_child,
			extend as al_extend,
			extendible as al_extendible,
			put as al_put,
			replace as al_replace,
			fill as al_fill,
			writable as writable_child,
			remove as al_remove,
			remove_left as al_remove_left,
			remove_right as al_remove_right,
			linear_representation as al_lin_rep,
			count as arity,
			empty as al_empty,
			is_empty as is_leaf,
			full as al_full,
			start as child_start,
			finish as child_finish,
			forth as child_forth,
			back as child_back,
			go_i_th as child_go_i_th,
			index as child_index,
			off as child_off,
			after as child_after,
			before as child_before,
			isfirst as child_isfirst,
			islast as child_islast,
			cursor as child_cursor,
			go_to as child_go_to,
			duplicate as al_duplicate,
			put_left as al_put_left,
			put_right as al_put_right,
			merge_left as al_merge_left,
			merge_right as al_merge_right,
			object_comparison as al_object_comparison
		export
			{NONE}
				al_extend, al_duplicate,
				al_remove, al_make,
				al_put, al_replace, al_has,
				al_fill, al_full, al_empty,
				al_remove_left, al_remove_right, al_lin_rep,
				al_put_left, al_put_right,
				al_merge_left, al_merge_right, al_object_comparison
		undefine
			is_leaf, child_isfirst, is_equal,
			child_islast, valid_cursor_index,
			changeable_comparison_criterion,
			compare_objects, compare_references,
			al_empty
		redefine
			copy
		select
			is_leaf
		end

create

	make

feature -- Initialization

	make (n: INTEGER; v: G) is
			-- Create node with item `v'.
			-- Allocate space for `n' children.
		require
			valid_number_of_children: n >= 0
		do
			al_make (n)
			replace (v)
		ensure
			node_item: item = v
		end

feature -- Access

	parent: ARRAYED_TREE [G]
			-- Parent of current node

	left_sibling: like parent is
			-- Left neighbor if any
		do
			if position_in_parent > 1 then
				Result := parent.array_item (position_in_parent - 1)
			end
		end

	right_sibling: like parent is
			-- Right neighbor if any
		do
			if position_in_parent < parent.arity then
				Result := parent.array_item (position_in_parent + 1)
			end
		end

feature -- Element change

	child_put, child_replace (v: like item) is
			-- Replace current child item with `v'.
		do
			if object_comparison then
				child.compare_objects
			else
				child.compare_references
			end
			child.replace (v)
		end

	replace_child (n: like parent) is
			-- Make `n' the node's current child.
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			if child_off then
				al_extend (n)
			else
				al_replace (n)
			end
			n.attach_to_parent (Current)
		ensure then
			child_replaced: n.parent = Current
		end

	child_extend (v: like item) is
			-- Add `v' at end.
			-- Do not move child cursor.
		local
			n: like parent
		do
			n := new_cell (v)
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			al_extend (n)
		end

	child_put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move child cursor.
		local
			n: like parent
		do
			n := new_cell (v)
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			al_put_left (n)
		end

	child_put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move child cursor.
		local
			n: like parent
		do
			n := new_cell (v)
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			al_put_right (n)
		end

	put_child_left (n: like parent) is
			-- Add `n' to the left of cursor position.
			-- Do not move cursor.
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			al_put_left (n)
			n.attach_to_parent (Current)
		end

	put_child_right (n: like parent) is
			-- Add `n' to the right of the cursor position.
			-- Do not move cursor.
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			al_put_right (n)
			n.attach_to_parent (Current)
		end

	put_child (n: like parent) is
			-- Add `n' to the list of children.
			-- Do not move child cursor.
		do
			if object_comparison then
				n.compare_objects
			else
				n.compare_references
			end
			al_extend (n)
			n.attach_to_parent (Current)
		end

	merge_tree_before (other: like first_child) is
			-- Merge children of `other' into current structure
			-- before cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other)
			al_merge_left (other)
		end

	merge_tree_after (other: like first_child) is
			-- Merge children of `other' into current structure
			-- after cursor position. Do not move cursor.
			-- Make `other' a leaf.
		do
			attach (other)
			al_merge_right (other)
		end

feature -- Removal

	remove_child is
			-- Remove child at cursor position.
			-- Move cursor to the next sibling, or `after' if none.
		do
			child.attach_to_parent (Void)
			al_remove
		end

	remove_left_child is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			child_back
			remove_child
		end

	remove_right_child is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			child_forth
			remove_child
			child_back
		end


feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-tree beginning at cursor position and
			-- having min (`n', `arity' - `child_index' + 1)
			-- children.
		local
			counter: INTEGER
			pos: CURSOR
		do
			from
				Result := new_node
				pos := child_cursor
				Result.child_start
			until
				child_after or else (counter = n)
			loop
				if child /= Void then
					Result.replace_child (child.duplicate_all)
				end
				Result.child_forth
				child_forth
				counter := counter + 1
			end
			child_go_to (pos)
		end

	copy (other: like Current) is
			-- Copy contents from `other'.
		local
			tmp_tree: like Current
		do
			create tmp_tree.make (other.child_capacity, other.item)
			if not other.is_leaf then tree_copy (other, tmp_tree) end
			standard_copy (tmp_tree)
		end

feature {NONE} -- Inapplicable

	extend (v: G) is
			-- Add `v' as new child.
		do
		end

	set_child (n: like parent) is
			-- Set child to `n'.
		do
		end

feature {ARRAYED_TREE} -- Implementation

	new_node: like Current is
			-- A newly created instance of the same type,
			-- with the same arity and node value.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			create Result.make (arity, item)
		end

	duplicate_all: like Current is
			-- Copy of sub-tree including all children
		local
			pos: CURSOR
		do
			from
				Result := new_node
				pos := child_cursor
				Result.child_start
				child_start
			until
				child_off
			loop
				if child /= Void then
					Result.replace_child (child.duplicate_all)
				end
				Result.child_forth
				child_forth
			end
			child_go_to (pos)
		end

	fill_subtree (other: TREE [G]) is
			-- Fill children with children of `other'
		local
			temp: like parent
		do
			from
				other.child_start
				child_start
			until
				child_after
			loop
				if other.child /= Void then
					create temp.make (other.arity, other.child_item)
					temp.fill_subtree (other.child)
				end
				replace_child (temp)
				child_forth
				other.child_forth
			end
		end

	attach_to_parent (n: like parent) is
			-- Make `n' parent of current node;
		do
			parent := n
		end

feature {NONE} -- Implementation

	new_tree: like Current is
			-- A newly created instance of the same type.
		do
			create Result.make (0, item)
		end

	new_cell (v: like item): like Current is
			-- New node with value `v' and no children.
		do
			create Result.make (0, v)
			Result.attach_to_parent (Current)
		end

	position_in_parent: INTEGER is
			-- Position of current node in parent
		do
			if parent /= Void then
				Result := parent.index_of (Current, 1)
			end
		end

	attach (other: like first_child) is
				-- Attach all children of `other' to current node.
				-- Put `other' in mode `off'.
		local
			c: like child
		do
			from
				other.child_start
			until
				other.child_off
			loop
				c := other.child
				other.child_forth
				c.attach_to_parent (Current)
			end
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ARRAYED_TREE
