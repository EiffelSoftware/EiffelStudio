indexing

	description:
		"Trees, without commitment to a particular representation";

	status: "See notice at end of class";
	names: tree;
	access: cursor, membership;
	representation: recursive;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class	TREE [G] inherit

	CONTAINER [G]

feature -- Access

	parent: TREE [G];
			-- Parent of current node

	child: like parent is
			-- Current child node
		require
			readable: readable_child
		deferred
		end;

	item: G is
			-- Item in current node
		deferred
		end;

	child_item: like item is
			-- Item in current child node
		require
			readable: child_readable
		do
			Result := child.item
		end;

	child_cursor: CURSOR is
			-- Current cursor position
		deferred
		end;

	child_index: INTEGER is
			-- Index of current child
		deferred
		ensure
			valid_index: Result >= 0 and Result <= arity + 1
		end;

	first_child: like parent is
			-- Leftmost child
		require
			is_not_leaf: not is_leaf
		deferred
		end;

	last_child: like first_child is
			-- Right most child
		require
			is_not_leaf: not is_leaf
		deferred
		end;

	left_sibling: like parent is
			-- Left neighbor (if any)
		require
			is_not_root: not is_root
		deferred
		ensure
			is_sibling: is_sibling (Result);
			right_is_current: (Result /= Void) implies (Result.right_sibling = Current);
		end;

	right_sibling: like parent is
			-- Right neighbor (if any)
		require
			is_not_root: not is_root
		deferred
		ensure
			is_sibling: is_sibling (Result);
			left_is_current: (Result /= Void) implies (Result.left_sibling = Current)
		end;

	has (v: G): BOOLEAN is
			-- Does subtree include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			if object_comparison then
				Result := (v /= Void) and then (item /= Void) and then (v.is_equal (item) or else subtree_has (v))
			else
				Result := v = item or else subtree_has (v)
			end
		end;

	is_sibling (other: like parent): BOOLEAN is
			-- Are current node and `other' siblings?
		do
			Result := not is_root and other.parent = parent
		ensure
			not_root: Result implies not is_root;
			other_not_root: Result implies not other.is_root;
			same_parent: Result = not is_root and other.parent = parent
		end;

feature -- Measurement

	arity: INTEGER is
			-- Number of children
		deferred
		end;

	count: INTEGER is
			-- Number of items
		do
			Result := subtree_count + 1
		end;

feature -- Status report

	readable: BOOLEAN is true;

	child_readable: BOOLEAN is
			-- Is there a current `child_item' to be read?
		do
			Result := not child_off and then (child /= Void)
		end;

	readable_child: BOOLEAN is
			-- Is there a current child to be read?
		do
			Result := not child_off
		end;

	writable: BOOLEAN is true;
			-- Is there a current item that may be modified?

	child_writable: BOOLEAN is
			-- Is there a current `child_item' that may be modified?
		do
			Result := not child_off and then (child /= Void)
		end;

	writable_child: BOOLEAN is
			-- Is there a current child that may be modified?
		do
			Result := not child_off
		end;

	child_off: BOOLEAN is
			-- Is there no current child?
		do
			Result := child_before or child_after
		end;

	child_before: BOOLEAN is
			-- Is there no valid child position to the left of cursor?
		do
			Result := child_index = 0
		end;

	child_after: BOOLEAN is
			-- Is there no valid child position to the right of cursor?
		do
			Result := child_index = arity + 1
		end;

	is_empty: BOOLEAN is
			-- Is structure empty of items?
		do
			Result := false
		end;

	is_leaf: BOOLEAN is
			-- Are there no children?
		do
			Result := arity = 0
		end;

	is_root: BOOLEAN is
			-- Is there no parent?
		do
			Result := parent = Void
		end;

	child_isfirst: BOOLEAN is
			-- Is cursor under first child?
		do
			Result := not is_leaf and child_index = 1
		ensure
			not_is_leaf: Result implies not is_leaf
		end;

	child_islast: BOOLEAN is
			-- Is cursor under last child?
		do
			Result := not is_leaf and child_index = arity
		ensure
			not_is_leaf: Result implies not is_leaf
		end;

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= arity + 1)
		ensure
			valid_cursor_index_definition: Result = (i >= 0) and (i <= arity + 1)
		end;

feature -- Cursor movement

	child_go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		deferred
		end;

	child_start is
			-- Move cursor to first child.
		deferred
		ensure then
			is_first_child: not is_leaf implies child_isfirst;
		end;

	child_finish is
			-- Move cursor to last child.
		deferred
		ensure then
			is_last_child: not is_leaf implies child_islast;
		end;

	child_forth is
			-- Move cursor to next child.
		deferred
		end;

	child_back is
			-- Move cursor to previous child.
		deferred
		end;

	child_go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th child.
		require else
			valid_cursor_index: valid_cursor_index (i)
		deferred
		ensure then
			position: child_index = i;
			is_before: (i = 0) implies child_before;
			is_after: (i = arity + 1) implies child_after
		end;

feature -- Element change

	sprout is
			-- Make current node a root.
		do
			if parent /= void then
				parent.prune (Current)
			end
		end;

	put, replace (v: like item) is
			-- Replace element at cursor position by `v'.
		require
			is_writable: writable
		deferred
		ensure
			item_inserted: item = v
		end;

	child_put, child_replace (v: like item) is
			-- Put `v' at current child position.
		require
			child_writable: child_writable
		deferred
		ensure
			item_inserted: child_item = v
		end;

	replace_child (n: like parent) is
			-- Put `n' at current child position.
		require
			writable_child: writable_child;
			was_root: n.is_root
		deferred
		ensure
			child_replaced: child = n
		end;

	prune (n: like parent) is
			-- Remove `n' from the children
		require
			is_child: n.parent = Current
		deferred
		ensure
			n_is_root: n.is_root
		end;

	fill (other: TREE [G]) is
			-- Fill with as many items of `other' as possible.
			-- The representations of `other' and current node
			-- need not be the same.
		do
			replace (other.item);
			fill_subtree (other)
		end;

feature -- Conversion

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		local
			al: ARRAYED_LIST [G]
		do
			!! al.make (count);
			al.start;
			al.extend (item);
			fill_list (al);
			Result := al
		end;

	binary_representation: BINARY_TREE[G] is
			-- Convert to binary tree representation:
			-- first child becomes left child,
			-- right sibling becomes right child.
		local
			current_sibling: BINARY_TREE [G];
		do
			!!Result.make (item);
			if not is_leaf then
				Result.put_left_child (first_child.binary_representation);
				from
					child_start;
					child_forth;
					current_sibling := Result.left_child
				until
					child_after
				loop
					current_sibling.put_right_child (child.binary_representation);
					current_sibling := current_sibling.right_child;
					child_forth
				end
			end
		ensure
			Result_is_root: Result.is_root;
			Result_has_no_right_child: not Result.has_right
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-tree beginning at cursor position and
			-- having min (`n', `arity' - `child_index' + 1)
			-- children.
		require
			not_child_off: not child_off;
			valid_sublist: n >= 0
		deferred
		end;

feature {TREE} -- Implementation

	subtree_has (v: G): BOOLEAN is
			-- Do children include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			cursor : CURSOR
		do
			cursor := child_cursor
			from
				child_start
			until
				child_off or else Result
			loop
				if child /= Void then
					if object_comparison then
						Result := (v /= Void) and then (child_item /= Void) and then v.is_equal (child_item)
					else
						Result := v = child_item
					end
				end;
				child_forth
			end;
			from
				child_start
			until
				child_off or else Result
			loop
				if child /= Void then
					Result := child.subtree_has (v)
				end;
				child_forth
			end
			child_go_to (cursor)
		end;

	subtree_count: INTEGER is
			-- Number of items in children
		local
			pos: CURSOR
		do
			Result := arity;
			from
				pos := child_cursor;
				child_start
			until
				child_off
			loop
				if child /= Void then
					Result := Result + child.subtree_count
				end;
				child_forth
			end;
			child_go_to (pos)
		end;


	fill_list (al: ARRAYED_LIST [G]) is
			-- Fill `al' with all the children's items.
		do
			from
				child_start
			until
				child_off
			loop
				if child /= Void then
					al.extend (child_item);
					child.fill_list (al)
				end;
				child_forth
			end
		end;


	attach_to_parent (n: like parent) is
			-- Make `n' parent of current node.
		do
			parent := n
		ensure
			new_parent: parent = n
		end;

	fill_subtree (s: TREE [G]) is
			-- Fill children with children of `other'.
		deferred
		end;

feature {NONE} -- Implementation

	remove is
			-- Remove current item
		do
		end;

	child_remove is
			-- Remove item of current child
		do
		end;

invariant

	leaf_definition: is_leaf = (arity = 0);
	child_off_definition: child_off = child_before or child_after;
	child_before_definition: child_before = (child_index = 0);
	child_isfirst_definition: child_isfirst = (not is_leaf and child_index = 1);
	child_islast_definition: child_islast = (not is_leaf and child_index = arity);
	child_after_definition: child_after = (child_index >= arity + 1);
	child_consistency: child_readable implies child.parent = Current

end -- class TREE


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

