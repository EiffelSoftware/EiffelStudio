
indexing

	description:
		"Trees, without commitment to a particular representation";

	copyright: "See notice at end of class";
	names: tree;
	access: cursor, membership;
	representation: recursive;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class
	TREE [G]

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
		end; -- item

   	child_item: like item is
			-- Item in current child node
		require
			readable: child_readable
		do
			Result := child.item
		end; -- child_item

	arity: INTEGER is
			-- Number of children
		deferred
		end;

	child_cursor: CURSOR is
			-- Current cursor position
		deferred
		end;

	child_index: INTEGER is
			-- Index of current child
		deferred
		ensure
			Result >= 0 and Result <= arity + 1
		end;

	first_child: like parent is
			-- Left most child
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
			is_sibling (Result);
			(Result /= Void) implies (Result.right_sibling = Current);
		end;

	right_sibling: like parent is
			-- Right neighbor (if any)
		require
			is_not_root: not is_root
		deferred
		ensure
			is_sibling (Result);
			(Result /= Void) implies (Result.left_sibling = Current)
		end;

	has (v: G): BOOLEAN is
			-- Does subtree include `v'?
			-- (According to the currently adopted
			-- discrimination rule)
		do
			Result := v = item or else subtree_has (v)
		end;
		
	is_sibling (other: like parent): BOOLEAN is
			-- are `Current' and `other' siblings
		do
			Result := not is_root and other.parent = parent
		ensure
			not_root: Result implies not is_root;
			other_not_root: Result implies not other.is_root;
			same_parent: Result = not is_root and other.parent = parent
		end;

feature -- Measurement

	count: INTEGER is
			-- Number of elements
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
			-- Is there no current child
		do
			Result := child_before or child_after
		end;

	child_before: BOOLEAN is
			-- Is there no valid child position to the left
		do
			Result := child_index = 0
		end;

	child_after: BOOLEAN is
			-- Is there no valid child position to the right
		do
			Result := child_index = arity + 1
		end;

	empty: BOOLEAN is
			-- Is structure empty of elements?
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
			Result implies (not is_leaf)
		end;

	child_islast: BOOLEAN is
			-- Is cursor under last child?
		do
			Result := not is_leaf and child_index = arity
		ensure
			Result implies (not is_leaf)
		end;

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= arity + 1)
		ensure
			valid_index_definition: Result = (i >= 0) and (i <= arity + 1)
		end;

feature -- Cursor movement

	child_go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		deferred
		end;

	child_start is
			-- Move to first child.
		deferred
		ensure then
			is_first_child: not is_leaf implies child_isfirst;
			after_if_leaf: is_leaf implies child_after
		end;

	child_finish is
			-- Move to last child.
		deferred
		ensure then
			is_last_child: not is_leaf implies child_islast;
			before_if_leaf: is_leaf  implies child_before
		end; -- child_finish

	child_forth is
		deferred
		end;

	child_back is
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
			-- Make `Current' a root
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
		end; -- replace
			
	child_put, child_replace (v: like item) is
			-- Put `v' at current child position.
		require
			child_writable: child_writable
		deferred
		ensure
			item_inserted: child_item = v
		end; -- child_replace

	put_child, replace_child (n: like parent) is
			-- Put `n' at current child position.
		require
			writable_child: writable_child;
			was_root: n.is_root
		deferred
		ensure
			child_replaced: child = n
		end; -- replace_child

	prune (n: like parent) is
			-- Remove `n' from the children
		require
			is_child: n.parent = Current
		deferred
		ensure
			n.is_root
		end;
		
	fill (other: TREE [G]) is
			-- Fill with as many elements of `other' as possible.
			-- The representations of `other' and current node
			-- need not be the same.
		do
			replace (other.item);
			fill_subtree (other)
		end;
	
feature -- Conversion

	sequential_representation: SEQUENTIAL [G] is
			-- Representation as a sequential structure
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
			-- Convert to binary representation:
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

feature -- Obsolete

	child_position: INTEGER is obsolete "Use ``child_index''"
			-- Position of child cursor
		do
			Result := child_index
		end;

	child_go (i: INTEGER) is obsolete "Use ``child_go_i_th''"
			-- Move cursor to `i'-th position.
		require
			valid_cursor_index: valid_cursor_index (i)
		do
			child_go_i_th (i)
		ensure
			position_espected: child_index = i
		end;

	child_offleft: BOOLEAN is obsolete "Use ``child_before''"
			-- Is child cursor left of leftmost child?
		do
			Result := child_before
		end;

	child_offright: BOOLEAN is obsolete "Use ``child_after''"
			-- Is child cursor right of rightmost child?
		do
			Result := child_after
		end;

feature {TREE} -- Implementation

	subtree_has (v: G): BOOLEAN is
			-- Do children include `v'?
			-- (According to the currently adopted
			-- discrimination rule)
		do
			from
				child_start
			until
				child_off or else Result
			loop
				if child /= Void then
					Result := v.is_equal (child_item)
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
		end;

	subtree_count: INTEGER is
			-- Number of elements in children
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
	leaf_constraint: is_leaf implies child_off;
	child_off_definition: child_off = child_before or child_after;
	child_before_definition: child_before = (child_index = 0);
	child_isfirst_definition: child_isfirst = (not is_leaf and child_index = 1);
	child_islast_definition: child_islast = (not is_leaf and child_index = arity);
	child_after_definition: child_after = (child_index = arity + 1);
	child_consistency: child_readable implies child.parent = Current

end -- class TREE


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
