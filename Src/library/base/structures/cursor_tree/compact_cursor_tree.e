--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Compact cursor trees,
-- implemented with association-arrays

indexing

	names: compact_cursor_tree, cursor_tree;
	representation: array;
	access: cursor, membership;
	size: resizable;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class COMPACT_CURSOR_TREE [G] inherit

	CURSOR_TREE [G]

creation

	make

feature -- Creation

	make (i: INTEGER) is
			-- Create an empty tree.
			-- `i' is an estimate of the number of nodes.
		do
			last := 1;
			active := 1;
			!! item_table.make (1, i + 1);
			!! next_sibling_table.make (1, i + 1);
			!! first_child_table.make (1, i + 1)
		ensure
			is_above: above;
			is_empty: empty
		end;

feature -- Access

	item: G is
			-- Current item
		do
			Result := item_table.item (active)
		end;

feature -- Insertion

	replace (v: G) is
			-- Replace current item by `v'
		require else
			is_writable: writable
		do
			item_table.put (v, active)
		end;

	add_right (v: G) is
			-- Put `v' to the right of cursor position.
		local
			index, new: INTEGER;
			extra_block_size: INTEGER
		do
			if not after and not above then
				if free_list_count > 0 then
					new := free_list_index;
					free_list_index := next_sibling_table.item (free_list_index);
					free_list_count := free_list_count - 1;
					next_sibling_table.put (0, new);
					first_child_table.put (0, new)
				else
					if last = item_table.upper then
							-- resize
						extra_block_size :=
							max (Block_threshold, (Extra_percentage * count) // 100);
						item_table.resize (1, last + extra_block_size);
						next_sibling_table.resize (1, last + extra_block_size);
						first_child_table.resize (1, last + extra_block_size)
					end;
					last := last + 1;
					new := last
				end;
				item_table.put (v, new);
				if below then
					first_child_table.put (new, active);
					next_sibling_table.put (- active, new);
					active := new;
					below := false
				elseif before then
					next_sibling_table.put (active, new);
					from
						index := next_sibling_table.item (active)
					until
						index < 0
					loop
						index := next_sibling_table.item (index)
					end;
					first_child_table.put (new, -index);
					active := new
				else
					next_sibling_table.put (next_sibling_table.item (active), new);
					next_sibling_table.put (new, active)
				end;
			end;
		end;

feature -- Number of elements

	count: INTEGER is
			-- Number of items in `Current'
		do
			Result := last - free_list_count - 1
		end;

	arity: INTEGER is
			-- Number of children of `Current'.
			-- This function may be called when
			-- the cursor is above the tree in
			-- which case it returns 0 for an
			-- empty tree and 1 for a non empty
			-- one
		local
			index: INTEGER
		do
			index := first_child_table.item (active);
			if index > 0 then
				from
				until
					index < 0
				loop
					Result := Result + 1;
					index := next_sibling_table.item (index)
				end
			end
		end;

feature -- Cursor

	back is
			-- Move cursor one position backward.
		local
			index: INTEGER
		do
			if below then
					--| Here after is true, because:
					--| [(below -> (before or after))
					--| and ~before]
				after := false;
				before := true
			elseif after then
				after := false
			elseif isfirst then
				before := true
			else
				from
					index := next_sibling_table.item (active)
				until
					index < 0
				loop
					index := next_sibling_table.item (index)
				end;
				from
					index := first_child_table.item (-index)
				until
					next_sibling_table.item (index) = active
				loop
					index := next_sibling_table.item (index)
				end;
				active := index
			end
		end;

	forth is
			-- Move cursor one position forward.
		local
			index: INTEGER;
		do
			if below then
					-- Here before is true, because:
					-- [(below -> (before or after))
					-- and ~after]
				before := false;
				after := true
			elseif before then
				before := false
			elseif islast then
				after := true
			else
				active := next_sibling_table.item (active)
			end
		end;

	up is
			-- Move cursor one level upward:
			-- to parent of `Current',
			-- or `above' if `Current.is_root'
		local
			index: INTEGER
		do
			if below then
				below := false
			else
				from
					index := next_sibling_table.item (active)
				until
					index < 0
				loop
					index := next_sibling_table.item (index)
				end;
				active := -index
			end;
			after := false;
			before := false
		end;

	down (i: INTEGER) is
			-- Move cursor one level downward:
			-- to `i'-th child if there is one,
			-- or `after' if `i' = `arity' + 1,
			-- or `before' if `i' = 0.
		local
			index, counter: INTEGER
		do
			if i = 0 then
				if arity = 0 then
					below := true
				else
					active := first_child_table.item (active)
				end;
				before := true
			elseif i = arity + 1 then
				if arity = 0 then
					below := true
				else
						-- Search last child.
					from
						index := first_child_table.item (active)
					until
						next_sibling_table.item (index) < 0
					loop
						index := next_sibling_table.item (index)
					end;
					active := index
				end;
				after := true
			else
				from
					index := first_child_table.item (active)
				until
					counter = i - 1
				loop
					counter := counter + 1;
					index := next_sibling_table.item (index)
				end;
				active := index
			end
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			temp: COMPACT_TREE_CURSOR
		do
			temp ?= p;
				check
					temp /= Void
				end;
			active := temp.active;
			after := temp.after;
			before := temp.before;
			below := temp.below
		end;

	cursor: CURSOR is
			-- Current cursor position
		do
			!COMPACT_TREE_CURSOR! Result.make
				(active, after, before, below)
		end;

	after: BOOLEAN;
			-- Is there no position to the right of the cursor?

	before: BOOLEAN;
			-- Is there no position to the left of the cursor?

	above: BOOLEAN is
			-- Is there no position above the cursor?
		do
			if not below then
				Result := (next_sibling_table.item (active) = 0)
			end
		end;

	isfirst: BOOLEAN is
			-- Is cursor on first sibling?
		local
			index: INTEGER
		do
			if not off then
				from
					index := next_sibling_table.item (active)
				until
					index < 0
				loop
					index := next_sibling_table.item (index)
				end;
				Result := (first_child_table.item (-index) = active)
			end
		end;

	islast: BOOLEAN is
			-- Is cursor on last sibling?
		do
			if not off then
				Result := (next_sibling_table.item (active) < 0)
			end
		end;

	is_root: BOOLEAN is
			-- Is cursor on root?
		local
			index: INTEGER
	 	do
			if not off then
				index := next_sibling_table.item (active);
				Result := (index < 0) and then
					(next_sibling_table.item (-index) = 0)
			end
		end;

feature -- Deletion

	remove is
			-- Remove node at cursor position
			-- (and consequently the corresponding
			-- subtree). Cursor moved one level upward.
		local
			removed_entries: LINKED_LIST [INTEGER];
			removed, index, l: INTEGER;
			pos: CURSOR
		do
				-- Build list with indexes of removed entries
			from
				pos := cursor;
				!! removed_entries.make;
				removed_entries.add_right (active);
				l := level;
				preorder_forth
			until
				level <= l
			loop
				removed_entries.add_right (active);
				preorder_forth
			end;
			go_to (pos);
			removed := active;
			up;
			if first_child_table.item (active) = removed then
					-- The removed child is the first sibling
				index := next_sibling_table.item (removed);
				if index > 0 then
						-- There is more than one sibling
					first_child_table.put (index, active)
				else
					first_child_table.put (0, active)
				end
			else
				from
					index := first_child_table.item (active)
				until
					next_sibling_table.item (index) = removed
				loop
					index := next_sibling_table.item (index)
				end;
				next_sibling_table.put (next_sibling_table.item (removed), index)
			end;
				-- Add the removed nodes to the free list.
			from
				removed_entries.start
			until
				removed_entries.offright
			loop
				free_list_count := free_list_count + 1;
				first_child_table.put (Removed_mark, removed_entries.item);
				next_sibling_table.put (free_list_index, removed_entries.item);
				free_list_index := removed_entries.item;
				removed_entries.forth
			end
		ensure then
			not_off_unless_empty: empty or else not off
		end;

	wipe_out is
			-- Empty `Current'.
		do
			item_table.resize (1, Block_threshold + 1);
			next_sibling_table.resize (1, Block_threshold + 1);
			first_child_table.resize (1, Block_threshold + 1);
			last := 1;
			active := 1;
			free_list_count := 0;
			free_list_index := 0;
			after := false;
			before := false;
			below := false;
			item_table.clear_all;
			next_sibling_table.clear_all;
			first_child_table.clear_all
		ensure then
			cursor_above: above
		end;

feature -- Number of elements

	full: BOOLEAN is false;
			-- Is `Current' full?

feature -- Assertion check

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			temp: COMPACT_TREE_CURSOR
		do
			temp ?= p;
			if temp /= Void then
				Result := (first_child_table.item (temp.active) /= Removed_mark)
			end
		end;

feature {COMPACT_CURSOR_TREE} -- Creation

	new_tree: like Current is
			-- Instance of class `like Current'
			-- This feature should be implemented in
			-- every effective descendant of COMPACT_CURSOR_TREE,
			-- so as to return an adequately allocated and
			-- initialized object.
		do
			!! Result.make (Block_threshold)
		end;

feature {NONE} -- Representation

	item_table: ARRAY [G];
			-- Array containing the items

	first_child_table: ARRAY [INTEGER];
			-- Indices to the first child

	next_sibling_table: ARRAY [INTEGER];
			-- Indices to siblings

	active: INTEGER;
			-- Index into `item_table'; yields current item

	last: INTEGER;
			-- Index into `item_table'; yields last item

	free_list_index: INTEGER;
			-- Index to first empty space in `item_table'
			
	free_list_count: INTEGER;
			-- Number of empty spaces in `item_table'

	Block_threshold: INTEGER is 5;
			-- Minimum number of extra entries to allocate when resizing
			-- the tables.

	Extra_percentage: INTEGER is 10;
			-- Percentage used to determine how many extra entries to
			-- allocate when resizing the tables.

	Removed_mark: INTEGER is -1;
			-- Mark for removed child in `first_child_table'

end
