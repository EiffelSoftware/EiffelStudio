--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Cursor trees are based on the notion of active data structures
-- with cursors.
-- If `t' is a tree, the cursor position is given by `t.cursor'
-- and the value of the corresponding element by `t.item'.
-- The cursor may be moved by operations `start', `up', `back',
-- `forth', `down',`go_to', `preorder_forth', `postorder_forth',
-- and `breadth_forth'.

indexing

	names: cursor_tree, tree;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CURSOR_TREE [G] inherit

	HIERARCHICAL [G]
		rename
			nb_of_successors as arity,
			back as up,
			forth as down
		redefine
			arity, back, forth
		end;

	CURSOR_STRUCTURE [G]
		rename
			fill as container_fill
		end;

	SEQUENTIAL [G]
		rename
			forth as preorder_forth,
			finish as go_last_child
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		end;

feature -- Access

	parent_item: G is
			-- Item in parent of `Current'
		require
			not_on_root: not is_root
		local
			pos: CURSOR;
		do
			pos := cursor;
			up;
			Result := item;
			go_to (pos)
		end;

	child_item (i: INTEGER): G is
			-- Item in `i'-th child of `Current'
		require
			argument_within_bounds: i >= 1 and then i <= arity;
			not_off: not off
		local
			pos: CURSOR;
		do
			pos:= cursor;
			down (i);
			Result := item;
			go_to (pos)
		end;

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not off
		end;

feature -- Insertion

	put (v: G) is
			-- Put `v' at cursor position.
			-- (Synonym for `replace')
		require
			writable: writable
		do
			replace (v)
		ensure
			item_inserted: item = v;
	--		same_count: count = old count
		end;

	add (v: G) is
			-- Put `v' after last child.
			-- Put `v' as `first_child' if `below' and place
			-- cursor `before'.
		require else
			not_above: not above;
			only_one_root: (level = 1) implies empty;
		local
			pos: CURSOR;
		do
			pos := cursor;
			go_last_child;
			add_right (v);
			go_to (pos);
			if below then
				below := false;
				down (0);
			end;
	--	ensure then
	--	  new_count: count = old count + 1;
		end;

	add_left (v: G) is
			-- Put `v' to the left of cursor position.
		require
			not_before: not before;
			not_above: not above;
			only_one_root: (level = 1) implies empty;
			not_full: not full
		do
			back;
			add_right (v);
			forth;
			forth
	--	ensure
	--		new_count: count = old count + 1;
		end;

	add_right (v: G) is
			-- Put `v' to the right of cursor position.
		require
			not_after: not after;
			not_above: not above;
			only_one_root: (level = 1) implies empty;
			not_full: not full
		deferred
	--	ensure
	--		new_count: count = old count + 1
		end;

	fill (other: CURSOR_TREE [G]) is
			-- Fill `Current' with as many elements of `other'
			-- as possible.
			-- The representations of `other' and `Current'
			-- need not be the same. (This feature enables you
			-- to map one implementation to another.)
		require
			is_empty: empty
		do
			go_above;
			if not other.empty then
				other.start;
				down (0);
				put_right (other.item);
				forth;
				fill_from_active (other)
			end
		ensure
			new_count: count = other.count
		end;

	fill_from_active (other: CURSOR_TREE [G]) is
			-- Copy subtree of `other''s active node
			-- onto active node of current tree.
		require
			cursor_on_leaf: is_leaf
		do
			if not other.is_leaf then
				from
					other.down (1);
					down (0)
				until
					other.after
				loop
					add_right (other.item);
					forth;
					fill_from_active (other);
					other.forth
				end;
				other.up;
				up
			end
		end;

	merge_right (other: CURSOR_TREE [G]) is
			-- Merge the elements of `other' into `Current' to
			-- the right of cursor position.
		require
			not_after: not after;
			not_above: not above;
			only_one_root: (level = 1) implies empty;
			not_full: not full
		local
			pos: CURSOR;
		do
			if not other.empty then
				pos := other.cursor;
				other.start;
				add_right (other.item);
				forth;
				if not other.is_leaf then
					down (0);
					other.down (0);
					from
					until
						other.islast
					loop
						other.forth;
						merge_right (other.subtree);
					end;
					up;
				end;
				other.go_to (pos);
			end;
	--	ensure
	--		new_count: count = old count + other.count
		end;

	merge_left (other: CURSOR_TREE [G]) is
			-- Merge the elements of `other' into Current to
			-- the left of cursor position.
		require
			not_before: not before;
			not_above: not above;
			only_one_root: (level = 1) implies empty;
			not_full: not full
		do
			back;
			merge_right (other);
	--	ensure
	--		new_count: count = old count + other.count
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not off
		end;

	extensible: BOOLEAN is true;
			-- May new items be added to current?

feature -- Deletion

	contractable: BOOLEAN is
			-- May items be removed from `Current'?
		do
			Result := not off
		end;

feature {NONE} -- Deletion

	remove_item (v: G) is
			-- Remove item `v' in `Current'
		do
		end;

feature -- Transformation

	subtree: like Current is
			-- Subtree rooted at `Current'
		require
			not_off: not off
		do
			Result := new_tree;
			Result.go_above;
			Result.down (0);
			Result.add_right (item);
			Result.forth;
			Result.fill_from_active (Current)
		end;

	parent_tree: like Current is
			-- Subtree rooted at parent of `Current'
		require
			not_on_root: not is_root;
			not_off: not off
		local
			pos: CURSOR;
		do
			pos := cursor;
			up;
			Result := subtree;
			go_to (pos)
		end;

	child_tree (i: INTEGER): like Current is
			-- Subtree rooted at `i'-th child of `Current'
		require
			argument_within_bounds: i >= 1 and then i <= arity;
			not_off: not off
		local
			pos: CURSOR;
		do
			pos := cursor;
			down (i);
			Result := subtree;
			go_to (pos)
		end;

feature -- Number of elements

	arity: INTEGER is
			-- Number of children of `Current'.
			-- This function may be called when
			-- the cursor is above the tree in
			-- which case it returns 0 for an
			-- empty tree and 1 for a non empty
			-- one
		require else
			not_after: not after;
			not_before: not before;
			not_below: not below
		deferred
		ensure then
			(above and empty) implies (Result = 0);
			(above and not empty) implies (Result = 1)
		end;

	depth: INTEGER is
			-- Depth of the tree
		local
			pos: CURSOR;
		do
			pos := cursor;
			go_above;
			Result := depth_from_active - 1;
			go_to (pos)
		end;

	level: INTEGER is
			-- Level of `Current' in the tree
			-- (Root is on level 1)
		local
			pos: CURSOR;
		do
			from
				pos := cursor;
			until
				above
			loop
				Result := Result + 1;
				up
			end;
			go_to (pos)
		end;

	breadth: INTEGER is
			-- Breadth of current level
		local
			l: INTEGER;
			pos: CURSOR
		do
			l := level;
			if l > 0 then
				pos := cursor;
				go_above;
				Result := breadth_of_level_from_active (l + 1);
				go_to (pos)
			end
		end;

feature {NONE} -- Number of elements

	depth_from_active: INTEGER is
			-- Depth of subtree starting at active
		do
			if arity = 0 then
				Result := 1
			else
				from
					down (1)
				until
					after
				loop
					Result := max (Result, depth_from_active + 1);
					forth
				end;
				up
			end
		end;

	breadth_of_level_from_active (l: INTEGER): INTEGER is
			-- Breadth of level `l' of subtree
			-- starting at `Current'
		do
			if (l = 2) or else is_leaf then
				Result := arity
			else
				from
					down (1)
				until
					after
				loop
					Result := Result +
						breadth_of_level_from_active (l - 1);
					forth
				end;
				up
			end
		end;

feature -- Cursor

	start is
			-- Move cursor to root.
			-- Leave cursor `off' if `empty'.
		do
			go_above;
			if not empty then
				down (1)
			end
		ensure then
			on_root_unless_empty: not empty implies is_root
		end;

	go_last_child is
			-- Go to the last child of current parent.
			-- No effect if below
		require else
			not_above: not above
		do
			up;
			down (arity);
		end;

	back is
			-- Move cursor one position backward.
		require
			not_before: not before;
			not_above: not above
		deferred
		ensure
			not_after: not after;
	--		(old below or old isfirst) implies before
		end;

	forth is
			-- Move cursor one position forward.
		require else
			not_after: not after;
			not_above: not above
		deferred
		ensure
			not_before: not before;
	--		(old below or old islast) implies after
		end;

	up is
			-- Move cursor one level upward:
			-- to parent of `Current',
			-- or `above' if `Current.is_root'
		require else
			not_above: not above
		deferred
		ensure then
			not_before: not before;
			not_after: not after;
			not_below: not below;
	--		above = (old is_root)
		end;

	down (i: INTEGER) is
			-- Move cursor one level downward:
			-- to `i'-th child if there is one,
			-- or `after' if `i' = `arity' + 1,
			-- or `before' if `i' = 0.
		require else
			not_before: not before;
			not_after: not after;
			not_below: not below;
			valid_cursor_index: valid_cursor_index (i)
		deferred
		ensure then
			(i = 0) implies before;
	--		(i = old arity + 1) implies after;
	--		((i > 0) and (i <= old arity)) implies not off;
	--		((old arity) = 0) implies below
		end;

	is_leaf: BOOLEAN is
			-- Is cursor on a leaf?
		do
			if not off then
				Result := (arity = 0)
			end
		end;

	off: BOOLEAN is
			-- Is there no current item?
			-- (True if `empty')
		do
			Result := (after or before or below or above)
		end;

	after: BOOLEAN is
			-- Is there no position to the right of the cursor?
		deferred
		end;

	before: BOOLEAN is
			-- Is there no position to the left of the cursor?
		deferred
		end;

	above: BOOLEAN is
			-- Is there no position above the cursor?
		deferred
		end;

	below: BOOLEAN;
			-- Is there no position below the cursor?

	isfirst: BOOLEAN is
			-- Is cursor on first sibling?
		deferred
		end;

	islast: BOOLEAN is
			-- Is cursor on last sibling?
		deferred
		end;

	is_root: BOOLEAN is
			-- Is cursor on root?
		deferred
		end;

	preorder_forth is
			-- Move cursor to next position in preorder.
			-- If the active node is the last in
			-- preorder, the cursor ends up `off'.
		do
			if is_leaf then
				from
				until
					not islast
				loop
					up
				end;
				if not above then forth end
			else
				down (1)
			end
		end;

	postorder_forth is
			-- Move cursor to next position in postorder.
			-- If the active node is the last in
			-- postorder, the cursor ends up `off'.
		require
			not_off: not off
		do
			if islast then
				up
			else
				forth;
				from
				until
					is_leaf
				loop
					down (1)
				end
			end
		end;

	breadth_forth is
			-- Move cursor to next position in breadth-first order.
			-- If the active node is the last in
			-- breadth-first order, the cursor ends up `off'.
		require
			not_off: not off
		local
			l: INTEGER;
		do
			l := level;
			level_forth;
			if above and (l < depth) then
				start_on_level (l + 1)
			end
		end;

	start_on_level (l: INTEGER) is
			-- Move the cursor to the first position
			-- of the `l'-th level counting from root.
		require
			argument_within_bounds: l >= 1 and then depth >= l
		do
			go_above;
			start_on_level_from_active (l + 1)
		ensure
			level_expected: level = l;
			is_first: isfirst
		end;

	level_forth is
			-- Move cursor to next position of current level.
		do
			if not above and then not islast then
				forth
			elseif not above then
				from
					up;
					level_forth
				until
					 above or else not is_leaf
				loop
					level_forth
				end;
				if not above then down (1) end
			end
		end;

	level_back is
			-- Move cursor to previous position of current level.
		do
			if not isfirst then
				back
			elseif not above then
				from
					up;
					level_back
				until
					above or else not is_leaf
				loop
					level_back
				end;
				if not above then down (arity) end
			end
		end;

	postorder_start is
			-- Move cursor to first position in postorder.
			-- Leave cursor off if tree is empty.
		do
			from
				go_above
			until
				arity = 0
			loop
				down (1)
			end
		end;

feature {CURSOR_TREE} -- Cursor

	go_above is
			-- Move the cursor above the tree
		do
			from
			until
				above
			loop
				up
			end
		end;

feature {NONE} -- Cursor

	start_on_level_from_active (l: INTEGER) is
			-- Move the cursor to the first position
			-- of the `l'-th level counting from active.
		require
			deep_enough: depth_from_active >= l
		do
			from
				down (1)
			until
				depth_from_active >= l - 1
			loop
				forth
			end;
			if (l > 2) then
				start_on_level_from_active (l - 1)
			end
		end;

feature {CURSOR_TREE} -- Creation

	new_tree: like Current is
			-- Instance of class `like Current'.
			-- This feature should be implemented in
			-- every effective descendant of CURSOR_TREE,
			-- so as to return an adequately allocated and
			-- initialized object.
		deferred
		ensure
			result_exists: Result /= Void;
			result_is_empty: result.empty
		end;

feature {NONE} -- Assertion check

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Can cursor be moved to i-th child?
			-- 0 is before and `arity' + 1 is after.
		do
			Result := i >= 0 and i <= (arity + 1)
		end;

feature -- Obsolete features

	offleft: BOOLEAN is
		obsolete "Use ``before'' and ``empty''"
			-- Is cursor off left edge?
		do
			Result := before or empty
		end;

	offright: BOOLEAN is
		obsolete "Use ``after'' and ``empty''"
			-- Is cursor off right edge?
		do
			Result := after or empty
		end;

	put_left (v: G) is
		obsolete "Use ``add_left''"
			-- Put `v' to the left of cursor position.
		require
			not_before: not before;
			not_above: not above;
			only_one_root: (level = 1) implies empty;
			not_full: not full
		do
			add_left (v)
	--	ensure
	--		one_more_item: count = old count + 1;
		end;

	put_right (v: G) is
		obsolete "Use ``add_right''"
			-- Put `v' to the right of cursor position.
		require
			not_after: not after;
			not_above: not above;
			only_one_root: (level = 1) implies empty;
			not_full: not full
		do
			add_right (v)
	--	ensure
	--		one_more_item: count = old count + 1
		end;

invariant

	positive_depth: depth >= 0;
	positive_breadth: breadth >= 0;
	is_leaf_definition: not off implies is_leaf = (arity = 0);
	above_property: above implies (arity <= 1);
	(isfirst or islast or is_leaf or is_root) implies not off;

-- The following clauses express the constraints
-- on the different legal cursor positions.

	off_definition: off = after or before or above or below;
	below_constraint: below implies ((after or before) and not above);
	above_constraint: above implies not (before or after or below);
	after_constraint: after implies not (before or above);
	before_constaint: before implies not (after or above);
	(empty and (after or before)) implies below;

	offright_definition: offright = empty or after;
	offleft_definition: offleft = empty or before

end
