--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Trees,
-- without commitment to a particular representation

indexing

	names: tree;
	access: cursor, membership;
	representation: recursive;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class TREE [G]

feature -- Access

	parent: TREE [G];
			-- Parent of `Current'

	child: like parent is
		deferred
		end;

   	item: G is
			-- Item in current node
		deferred
		end; -- item

   	child_item: like item is
		deferred
		end; -- child_item

	arity: INTEGER is
		deferred
		end;

	child_cursor: CURSOR is
			-- Current cursor position
		deferred
		end;

	child_index: INTEGER is
		deferred
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
			-- Left neighbor of `Current' (if any)
		require
			is_not_root: not is_root
		deferred
		ensure
			(Result /= Void) implies (Result.right_sibling = Current)
		end;

	right_sibling: like parent is
			-- Right neighbor of `Current' (if any)
		require
			is_not_root: not is_root
		deferred
		ensure
			(Result /= Void) implies (Result.left_sibling = Current)
		end;

	has (v: G): BOOLEAN is
			-- Does `Current' include `v'?
			-- (According to the currently adopted
			-- discrimination rule)
		do
			Result := v = item or else subtree_has (v)
		end;

feature -- Measurement

	count: INTEGER is
			-- Number of elements in `Current'
		do
			Result := subtree_count + 1
		end;



feature -- Conversion

	sequential_representation: SEQUENTIAL [G] is
			-- Sequential representation of `Current'.
			-- This feature enables you to manipulate each
			-- item of `Current' regardless of its
			-- actual structure.
		local
			fl: FIXED_LIST [G]
		do
			!!fl.make (count);
			fl.start;
			fl.replace (item);
			fl.forth;
			fill_list (fl);
			Result := fl
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


feature -- Modification & Insertion

	replace (v: like item) is
			-- Replace item in `Current' by `v'.
		require
			is_writable: writable
		deferred
		ensure
			item_inserted: item = v
		end; -- replace
		
	put (v: like item) is
			-- Replace item in `Current' by `v'.
			-- (Synonym for replace)
		require
			is_writable: writable
		do
			replace (v)
		ensure
			item_inserted: item = v
		end; -- put

	child_replace (v: like item) is
			-- Put `v' at current child position.
		require
			child_writable: child_writable
		deferred
		ensure
			item_inserted: child_item = v
		end; -- child_replace

	child_put (v: like item) is
			-- Put `v' at current child position.
			-- (Synonym for `child_replace')
		require
			child_writable: child_writable
		do
			child_replace (v)
		ensure
			item_inserted: child_item = v
		end; -- child_put

	replace_child (n: like parent) is
			-- Put `n' at current child position.
		require
			writable_child: writable_child
		deferred
		ensure
			child_replaced: child = n
		end; -- replace_child

	put_child (n: like parent) is
			-- Put `n' at current child position.
			-- (Synonym for `replace_child')
		require
			writable_child: writable_child
		do
			replace_child (n)
		ensure
			child_replaced: child = n
		end; -- put_child

	fill (other: TREE [G]) is
			-- Fill `Current' with as many elements of `other'
			-- as possible.
			-- The representations of `other' and `Current'
			-- need not be the same. (This feature enables you
			-- to map one implementation to another.)
		do
			replace (other.item);
			fill_subtree (other)
		end;

feature -- Cursor movement

	child_go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		deferred
		end;

	child_start is
			-- Move to first child in `Current'.
		deferred
		ensure then
			not empty implies child_isfirst
		end;

	child_finish is
			-- Move to last child in `Current'.
		deferred
		ensure then
			is_last_child: not empty implies child_islast
		end; -- child_finish

	child_forth is
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

	contractable: BOOLEAN is false;
			-- May items be removed from `Current'?



	child_off: BOOLEAN is
		deferred
		end;

	child_before: BOOLEAN is
		deferred
		end;

	child_after: BOOLEAN is
		deferred
		end;



	empty: BOOLEAN is
			-- Is `Current' empty?
		do
			Result := false
		end;

	is_leaf: BOOLEAN is
			-- Has `Current' no children?
		do
			Result := arity = 0
		end;

	is_root: BOOLEAN is
			-- Has `Current' no parent?
		do
			Result := parent = Void
		end;

	child_isfirst: BOOLEAN is
			-- Is cursor under first child?
		do
			Result := (child_index = 1)
		ensure
			Result implies (not empty)
		end;

	child_islast: BOOLEAN is
			-- Is cursor under last child?
		do
			Result := (child_index = arity)
		ensure
			Result implies (not empty)
		end;

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= arity + 1)
		ensure
			valid_index_definition: Result = (i >= 0) and (i <= arity + 1)
		end;


feature -- Obsolete, Access

	child_position: INTEGER is obsolete "Use ``child_index''"
			-- Position of child cursor
		do
			Result := child_index
		end;
feature -- Obsolete, Cursor movement

	child_go (i: INTEGER) is obsolete "Use ``child_go_i_th''"
			-- Move cursor to `i'-th position.
		require
			valid_cursor_index: valid_cursor_index (i)
		do
			child_go_i_th (i)
		ensure
			position_espected: child_index = i
		end;


feature -- Obsolete, Status report

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




feature  {TREE} -- Access

	subtree_has (v: G): BOOLEAN is
			-- Do the children of `Current' include `v'?
			-- (According to the currently adopted
			-- discrimination rule)
		do
			from
				child_start
			until
				child_off or else Result
			loop
				if child /= Void then
					Result := equal (v, child_item)
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


feature  {TREE} -- Measurement

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


feature  {TREE} -- Duplication

	fill_list (fl: FIXED_LIST [G]) is
			-- Fill `fl' with all the childrens items.
		do
			from
				child_start
			until
				child_off
			loop
				if child /= Void then
					fl.replace (child_item);
					fl.forth;
					child.fill_list (fl)
				end;
				child_forth
			end
		end;



feature  {TREE} -- Modification & Insertion

	attach_to_parent (n: like parent) is
			-- Make `n' parent of `Current'.
		do
			parent := n
		ensure
			new_parent: parent = n
		end;

	fill_subtree (s: TREE [G]) is
			-- Fill children with children of `other'.
		deferred
		end;

 

feature  {NONE} -- Removal

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

	child_before_definition: child_before = (child_index = 0);
	child_isfirst_definition: child_isfirst = (child_index = 1);
	child_islast_definition: child_islast = (child_index = arity);
	child_after_definition: child_after = (child_index = arity + 1)

end -- class TREE
