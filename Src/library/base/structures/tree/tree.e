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

deferred class TREE [G] inherit

	LINEAR [G] --| Operations on items of children	
		rename
			item as child_item,
			readable as child_readable,
			start as child_start,
			finish as child_finish,
			forth as child_forth,
			back as child_back,
			off as child_off,
			before as child_before,
			after as child_after,
			index as child_index
		undefine
			exhausted, child_off
		redefine
			has, sequential_representation
		select
			child_item
		end;

	CURSOR_STRUCTURE [G] --| Operations on items of children
		rename
			readable as child_readable,
			add as child_add,
			replace as child_replace,
			writable as child_writable,
			remove as child_remove,
			count as arity,
			go_to as child_go_to,
			cursor as child_cursor,
			fill as old_fill
		export
			{NONE} old_fill
		undefine
			old_fill
		redefine
			empty
		end;

	ACTIVE [TREE [G]] --| Operations on children
		rename
			item as child,
			readable as readable_child,
			add as add_child,
			replace as replace_child,
			writable as writable_child,
			remove as remove_child,
			contractable as child_contractable,
			count as arity,
			remove_item as active_rmv_item,
			sequential_representation as active_seq_rep,
			fill as active_fill,
			has as active_has
		export
			{NONE}	active_seq_rep, active_fill,
					active_has, active_rmv_item
		redefine
			empty
		end;

	LINEAR [TREE [G]] --| Operations on children
		rename
			search as search_child,
			search_equal as search_equal_child,
			index_of as index_of_child,
			readable as child_readable,
			start as child_start,
			finish as child_finish,
			forth as child_forth,
			back as child_back,
			off as child_off,
			before as child_before,
			after as child_after,
			index as child_index,
			sequential_representation as linear_seq_rep,
			sequential_search as linear_seq_srch,
			seq_search_equal as linear_seq_srch_equal,
			search_same as linear_search_same,
			has as linear_has,
			item as child2
		export
			{NONE}
				linear_seq_rep, linear_has,
				linear_seq_srch, child2,
				linear_seq_srch_equal,
				linear_search_same
		select
			index_of, search, sequential_search,
			search_equal, search_same, seq_search_equal
		end;

	FINITE
		redefine
			empty
		end;

	ACTIVE [G] --| Operations on item of `Current'
		rename
			fill as old_fill
		export
			{NONE} old_fill
		redefine
			empty
		select
			item, replace, add, writable, remove, count,
			readable, contractable, sequential_representation,
			has, old_fill, remove_item
		end


feature -- Access

	parent: TREE [G];
			-- Parent of `Current'

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

	readable: BOOLEAN is true;
			-- Is there a current item that may be read?

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

feature {TREE} -- Access

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

feature -- Insertion

	put (v: like item) is
			-- Replace item in `Current' by `v'.
			-- (Synonym for replace)
		require
			is_writable: writable
		do
			replace (v)
		ensure
			item_inserted: item = v;
	--		same_count: count = old count
		end;

	child_put (v: like item) is
			-- Put `v' at current child position.
			-- (Synonym for `child_replace')
		require
			child_writable: child_writable
		do
			child_replace (v)
		ensure
			item_inserted: child_item = v;
	--		same_count: count = old count
		end;

	put_child (n: like parent) is
			-- Put `n' at current child position.
			-- (Synonym for `replace_child')
		require
			writable_child: writable_child
		do
			replace_child (n)
		ensure
			child_replaced: child = n;
	--		same_count: count = old count
		end;

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

feature {TREE} -- Insertion

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

feature -- Deletion

	contractable: BOOLEAN is false;
			-- May items be removed from `Current'?

feature {NONE} -- Deletion

	remove is
			-- Remove current item
		do
		end;

	child_remove is
			-- Remove item of current child
		do
		end;

feature -- Transformation

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-tree beginning at cursor position and
			-- having min (`n', `arity' - `child_index' + 1)
			-- children.
		require
			not_child_off: not child_off;
			valid_sublist: n >= 0
		deferred
		end;

	sequential_representation: SEQUENTIAL [G] is
			-- Sequential representation of `Current'.
			-- This feature enables you to manipulate each
			-- item of `Current' regardless of its
			-- actual structure.
		local
			fl: FIXED_LIST [G]
		do
			!!fl.make (count);
			fl.add (item);
			fill_list (fl);
			Result := fl
		end;

feature {TREE} -- Transformation

	fill_list (fl: FIXED_LIST [G]) is
			-- Fill `fl' with all the childrens items.
		do
			from
				child_start
			until
				child_off
			loop
				if child /= Void then
					fl.add (child_item);
					child.fill_list (fl)
				end;
				child_forth
			end
		end;

feature -- Number of elements

	count: INTEGER is
			-- Number of elements in `Current'
		do
			Result := subtree_count + 1
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

feature {TREE} -- Number of elements

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

feature -- Cursor

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

feature -- Assertion check

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= arity + 1)
		ensure
			valid_index_definition: Result = (i >= 0) and (i <= arity + 1)
		end;

feature -- Obsolete features

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

invariant

	leaf_definition: is_leaf = (arity = 0);

	child_before_definition: child_before = (child_index = 0);
	child_isfirst_definition: child_isfirst = (child_index = 1);
	child_islast_definition: child_islast = (child_index = arity);
	child_after_definition: child_after = (child_index = arity + 1)

end -- class TREE
