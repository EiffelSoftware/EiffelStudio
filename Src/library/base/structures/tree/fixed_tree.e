indexing

	description:
		"Trees where each node has a fixed number of children %
		%(The number of children is arbitrary but cannot be %
		%changed once the node has been created";

	names: fixed_tree, tree, fixed_list;
	representation: recursive, array;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class FIXED_TREE [G] inherit

	CELL [G]
		undefine
			is_equal, copy, setup, consistent
		end;

	TREE [G]
		undefine
			child_off, child_after, child_before,
			is_equal, copy, setup, consistent, 
			child_item
		redefine
			parent, attach_to_parent
		select
			linear_representation, 
			sequential_representation,
			changeable_comparison_criterion,
			object_comparison,
			is_leaf, has
		end;

	FIXED_LIST [FIXED_TREE [G]]
		rename
			make as fl_make,
			item as child,
			i_th as array_item,
			last as last_child,
			first as first_child,
			search as search_child,
			has as fl_has,
			readable as fl_readable,
			put as fl_put,
			replace as fl_replace,
			fill as fl_fill,
			writable as fl_writable,
			extendible as fl_extendible,
			remove as fl_remove,
			sequential_representation as fl_seq_rep,
			linear_representation as fl_lin_rep,
			count as arity,
			empty as is_leaf,
			full as fl_full,
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
			object_comparison as fl_object_comparison,
			changeable_comparison_criterion as fl_changeable_object_criterion
		export
			{NONE}
				fl_put, fl_replace,
				fl_writable, fl_extendible,
				fl_remove, fl_make, fl_has, fl_readable,
				fl_seq_rep, fl_lin_rep,
				fl_fill, fl_full;
			{FIXED_TREE}
				array_item
		undefine
			is_leaf, child_isfirst, child_islast,
			valid_cursor_index, compare_references,
			compare_objects
		redefine
			duplicate, first_child
		end

creation

	make

feature -- Initialization

	make (n: INTEGER; v: G) is
			-- Create node with `n' void children and item `v'.
		require
			valid_number_of_children: n >= 0
		do
			fl_make (n);
			replace (v)
		ensure
			node_item: item = v;
			node_arity: arity = n
		end;

feature -- Access

	parent: FIXED_TREE [G];
			-- Parent of `Current'

	first_child: like parent is
			-- Item at first position
		do
			Result := array_item (1)
		end;

	child_item: like item is
			-- Item of active child
		do
			Result := child.item
		end;

	left_sibling: like parent is
			-- Left neighbor of `Current' (if any)
		do
			if position_in_parent > 1 then
				Result := parent.array_item (position_in_parent - 1)
			end
		end;

	right_sibling: like parent is
			-- Right neighbor of `Current' (if any)
		do
			if position_in_parent < parent.arity then
				Result := parent.array_item (position_in_parent + 1)
			end
		end;

feature -- Status report

	child_contractable: BOOLEAN is
			-- May items be removed from `Current'?
		do
			Result := not child_off
		ensure
			Result = not child_off
		end;

	full: BOOLEAN is true;
			-- Is `Current' full?

feature -- Element change

	child_put, child_replace (v: like item) is
			-- Replace current child item with `v'
		do
			child.replace (v)
		end;

	put_left (v: like item) is
			-- Add item `v' to the left of `Current'.
		require
			is_not_root: not is_root;
			has_left_sibling: left_sibling /= Void
		do
			parent.child_go_i_th (position_in_parent - 1);
			parent.child_replace (v)
		ensure
			item_put: left_sibling.item = v
		end;

	put_right (v: like item) is
			-- Put item `v' right of `Current'.
		require
			is_not_root: not is_root;
			has_right_sibling: right_sibling /= Void
		do
			parent.child_go_i_th (position_in_parent + 1);
			parent.child_replace (v)
		ensure
			item_put: right_sibling.item = v
		end;

	put_child, replace_child (n: like parent) is
			-- Make `n' the node's child.
		do
			fl_replace (n);
			n.attach_to_parent (Current)
		ensure then
			child_replaced: n.parent = Current
		end;

	put_left_sibling (other: like parent) is
			-- Make `other' the left sibling of current node.
		require
			is_not_root: not is_root;
			has_left_sibling: left_sibling /= Void
		do
			parent.child_go_i_th (position_in_parent - 1);
			parent.replace_child (other)
		ensure
			left_sibling_replaced: left_sibling = other
		end;

	put_right_sibling (other: like parent) is
			-- Make `other' the right sibling of current node.
		require
			is_not_root: not is_root;
			has_right_sibling: right_sibling /= Void
		do
			parent.child_go_i_th (position_in_parent + 1);
			parent.replace_child (other)
		ensure
			right_sibling_replaced: right_sibling = other
		end;

feature -- Removal

	remove_child is
			-- Remove active child.
		do
			fl_replace (Void);
		ensure then
			child_removed: child = Void
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-tree beginning at cursor position and
			-- having min (`n', `arity' - `child_index' + 1)
			-- children.
		local
			counter: INTEGER;
			pos: CURSOR
		do
			from
				Result := new_node;
				pos := child_cursor;
				Result.child_start
			until
				child_after or else (counter = n)
			loop
				if child /= Void then
					Result.replace_child (child.duplicate_all)
				end;
				Result.child_forth;
				child_forth;
				counter := counter + 1
			end;
			child_go_to (pos)
		end;

feature -- Obsolete

	add (v: G) is 
		obsolete "Use ``put'' instead."
			-- Add `v' to `Current'.
		do
		end;

feature  {FIXED_TREE} -- Implementation

	new_node: like Current is
			-- Instance of class `like Current'.
			-- New allocated node of arity `arity'
			-- and node value `item'
		do
			!!Result.make (arity, item)
		end;

	duplicate_all: like Current is
			-- Copy of sub-tree including all children
		local
			pos: CURSOR
		do
			from
				Result := new_node;
				pos := child_cursor;
				Result.child_start;
				child_start
			until
				child_off
			loop
				if child /= Void then
					Result.replace_child (child.duplicate_all)
				end;
				Result.child_forth;
				child_forth;
			end;
			child_go_to (pos)
		end;

	fill_subtree (other: TREE [G]) is
			-- Fill children with children of `other'
		local
			temp: like parent
		do
			from
				other.child_start;
				child_start
			until
				child_after
			loop
				if other.child /= Void then
					!!temp.make (other.arity, other.child_item);
					temp.fill_subtree (other.child)
				end;
				replace_child (temp);
				child_forth;
				other.child_forth;
			end
		end;

	attach_to_parent (n: like parent) is
			-- Make `n' parent of `Current',
			-- and set `position_in_parent'.
		do
			parent := n;
			position_in_parent := n.child_index
		end;

feature  {NONE} -- Implementation

	position_in_parent: INTEGER;
			-- Position of `Current' in parent

	extendible: BOOLEAN is false;
			-- May new items be added to `Current'?


end -- class FIXED_TREE

