indexing

	description:
		"Compact trees as active structures that may be traversed using a cursor";

	copyright: "See notice at end of class";
	names: compact_cursor_tree, cursor_tree;
	representation: array;
	access: cursor, membership;
	size: resizable;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class COMPACT_CURSOR_TREE [G] inherit

	CURSOR_TREE [G]
		rename
			index as linear_index
		redefine
			put_left, put_right, extend
		end

creation

	make

feature -- Initialization

	make (i: INTEGER) is
			-- Create an empty tree.
			-- `i' is an estimate of the number of nodes.
		do
			last := 0;
			active := 0;
			above := true;
			!! item_table.make (1, i);
			!! next_sibling_table.make (1, i);
			!! first_child_table.make (1, i)
		ensure
			is_above: above;
			is_empty: empty
		end;

feature -- Access

	item: G is
			-- Current item
		do
			Result := item_table.item (active);
		end;

	cursor: CURSOR is
			-- Current cursor position
		do
			!COMPACT_TREE_CURSOR! Result.make
				(active, after, before, below, above)
		end;

	arity: INTEGER is
			-- Number of children
		local
			index: INTEGER
		do
			index := first_child_table.item (active);
			from
			until
				index <= 0
			loop
				Result := Result + 1;
				index := next_sibling_table.item (index)
			end
		end;

feature -- Measurement

	count: INTEGER is
			-- Number of elements in subtree
		do
			Result := last - free_list_count - 1
		end;

feature -- Status report

	after: BOOLEAN;
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN;
			-- Is there no valid cursor position to the left of cursor?

	above: BOOLEAN;
			-- Is there no valid cursor position above the cursor?
	
	isfirst: BOOLEAN is
			-- Is cursor on first sibling?
		local
			index, next: INTEGER
		do
			if not off then
				from
					index := next_sibling_table.item (active)
				until
					index <= 0
				loop
					index := next_sibling_table.item (index)
				end;
				Result := (index = 0) or else (first_child_table.item (-index) = active)
			end
		end;

	islast: BOOLEAN is
			-- Is cursor on last sibling?
		do
			if not off then
				Result := (next_sibling_table.item (active) <= 0)
			end
		end;

	is_root: BOOLEAN is
			-- Is cursor on root?
		local
			index: INTEGER
	 	do
			if not off then
				Result := next_sibling_table.item (active) = 0
			end
		end;


	full: BOOLEAN is false;
			-- Is tree filled to capacity? (Answer: no.)

	empty: BOOLEAN is
		do
			Result := count = 0
		end;

	prunable: BOOLEAN is
		do
			Result := true
		end;


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

feature -- Cursor movement

	back is
			-- Move cursor one position backward.
		local
			index, next: INTEGER
		do
			if below then
					--| Here after is true, because:
					--| [(below => (before or after))
					--| and not before]
				after := false;
				before := true
			elseif after then
				after := false
			else
				from
					index := next_sibling_table.item (active);
				until
					index <= 0
				loop
					index := next_sibling_table.item (index)
				end;
				if index = 0 then -- is_root
					before := true
				elseif first_child_table.item (-index) = active then	-- is_first
					before := true
				else
					from
						index := first_child_table.item (-index);
						next := next_sibling_table.item (index)
					until
						next = active
					loop
						index := next;
						next := next_sibling_table.item (index)
					end;
					active := index
				end
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
					-- and not after]
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
			-- Move cursor one level upward, to parent
			-- or `above' if `is_root' holds.
		local
			index: INTEGER
		do
			if below then
				below := false
			else
				from
					index := next_sibling_table.item (active)
				until
					index <= 0
				loop
					index := next_sibling_table.item (index)
				end;
				if index = 0 then
					above := true
				else
					active := -index
				end;
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
			index, next, counter: INTEGER
		do
			index := first_child_table.item (active);
			if above then
				above := false
			elseif index <= 0 then
				below := true;
				if i = 0 then
					before := true
				else
					after := true
				end
			else
				from
					counter := 1;
					next := next_sibling_table.item (index)
				until
					counter = i or next <= 0
				loop
					index := next;
					next := next_sibling_table.item (index);
					counter := counter + 1
				end;
				active := index;
				if i = 0 then
					before := true
				elseif counter < i then
					after := true
				end
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

feature -- Element change

	replace (v: G) is
			-- Replace current item by `v'
		require else
			is_writable: writable
		do
			item_table.put (v, active)
		end;

	put_right (v: G) is
			-- Put a leaf `v' to the right of cursor position.
		local
			index, new: INTEGER;
			extra_block_size: INTEGER
		do
			new := new_cell_index;
			first_child_table.put (0, new);
			if below then
				first_child_table.put (new, active);
				next_sibling_table.put (-active, new);
				item_table.put (v, new);
				active := new
			elseif before then
				item_table.put (item_table.item (active), new);
				next_sibling_table.put (next_sibling_table.item (active), new);
				first_child_table.put (first_child_table.item (active), new);
				item_table.put (v, active);
				next_sibling_table.put (new, active);
				first_child_table.put (0, active);
				active := new			
			else
				next_sibling_table.put (next_sibling_table.item (active), new);
				next_sibling_table.put (new, active);
			end;
		end;
		
	put_left (v: G) is
			-- Put `v' at the left of current position.
		local
			new: INTEGER;
		do
			new := new_cell_index;
			if below then
				first_child_table.put (new, active);
				next_sibling_table.put (-active, new);
				item_table.put (v, new)
			else
				item_table.put (item_table.item (active), new);
				next_sibling_table.put (next_sibling_table.item (active), new);
				first_child_table.put (first_child_table.item (active), new);
				item_table.put (v, active);
				next_sibling_table.put (new, active);
				first_child_table.put (0, active);
			end;
			active := new
		end;
		
	put_front (v: G) is
			-- Insert a leaf `v' as first child.
			-- If `above' and `empty', make `v' the root value
		local
			old_active: like active;
			new: INTEGER;
		do
			new := new_cell_index;
			if below then
				item_table.put (v, new);
				first_child_table.put (0, new);
				next_sibling_table.put (-active, new);
				active := new
			elseif before then
				item_table.put (item_table.item (active), new);
				next_sibling_table.put (next_sibling_table.item (active), new);
				first_child_table.put (first_child_table.item (active), new);
				item_table.put (v, active);
				next_sibling_table.put (new, active);
				first_child_table.put (0, active);
				active := new
			else
				old_active := active;
				up;
				item_table.put (v, new);
				next_sibling_table.put (first_child_table.item (active), new);
				first_child_table.put (new, active);
				active := old_active
			end;
		end;

	put_parent (v: G) is
			-- insert a new node, with value v, as parent of
			-- current node and 
			-- with the same position
			--if above or on root, add a new root 
		require
			not after;
			not before
		local
			new, old_index: INTEGER
		do
			new := new_cell_index;
			old_index := active;
			if empty then
				active := new;
				item_table.put (v, new);
				next_sibling_table.put (0, new);
				first_child_table.put (0, new);
			else
				item_table.put (item, new);
				first_child_table.put (first_child_table.item (active), new);
				next_sibling_table.put (-active, new);
				item_table.put (v, active);
			end
		end;

			
	extend (v: G) is
		local
			new, index, next: INTEGER;
		do
			new := new_cell_index;
			if below then
				item_table.put (v, new);
				first_child_table.put (0, new);
				next_sibling_table.put (-active, new);
				active := new
			else
				from
					index := active;
					next := next_sibling_table.item (index)
				until
					next <= 0
				loop
					index := next;
					next := next_sibling_table.item (index)
				end;
				check
					next < 0 -- parent exist
				end;
				next_sibling_table.put (next, new);
				next_sibling_table.put (new, index);
			end;
		end;
				
feature -- Removal

	remove is
			-- Remove node at cursor position
			-- (and consequently the corresponding
			-- subtree). Cursor moved to the next sibiling or after.
			-- Beyond if no sibling
		local
			removed, index, next: INTEGER;
		do
			removed := active;
			up;
			if first_child_table.item (active) = removed then
					-- The removed child is the first sibling
				index := next_sibling_table.item (removed);
				if index > 0 then
						-- There is more than one sibling
					first_child_table.put (index, active);
					active := index
				else
					first_child_table.put (0, active);
					below := true;
					after := true
				end
			else
				from
					index := first_child_table.item (active);
					next := next_sibling_table.item (index)
				until
					next = removed
				loop
					index := next;
					next := next_sibling_table.item (index)
				end;
				next_sibling_table.put (next_sibling_table.item (removed), index);
				if next_sibling_table.item (removed) > 0 then
					active := next_sibling_table.item (removed)
				else
					active := index;
					after := true
				end
			end;
			remove_subtree (removed)
		ensure then
			not_before: not before
		end;

	remove_node is
			-- Remove node at cursor position.
			-- Insert its child among the child of parent,
			-- at current position.
			-- If current is the root node, it must not have more
			-- than one child.
			-- Move the cursor up
		require
			not off;
			is_root implies arity <= 1
		local
			old_active, next, index,
			first_child_index: INTEGER;
			default_value: G
		do
			old_active := active;
			first_child_index := first_child_table.item (old_active);
			up;
			next := first_child_table.item (active);
			if next = old_active then
				first_child_table.put
					 (next_sibling_table.item (old_active), active);
			else
				from
				until
					next = old_active
				loop
					index := next;
					next :=	next_sibling_table.item (index)
				end;
				next_sibling_table.put (first_child_index, index);
				from
					next := first_child_index
				until
					next <= 0
				loop
					index := next;
					next := next_sibling_table.item (index)
				end;
				next_sibling_table.put (next_sibling_table.item (old_active), index);
			end;
			if old_active = last then
				last := last - 1
			else
				item_table.put (default_value, old_active);
				first_child_table.put (Removed_mark, old_active);
				next_sibling_table.put (free_list_index, old_active);
				free_list_index := old_active;
				free_list_count := free_list_count + 1
			end
		end;

	wipe_out is
			-- Remove all elements.
		do
			item_table.wipe_out;
			next_sibling_table.wipe_out;
			first_child_table.wipe_out;
			last := 0;
			active := 0;
			free_list_count := 0;
			free_list_index := 0;
			above := true;
			after := false;
			before := false;
			below := false;
		ensure then
			cursor_above: above
		end;

feature {COMPACT_CURSOR_TREE} -- Implementation

	new_tree: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make (Block_threshold)
		end;

feature {NONE} -- Implementation

	item_table: ARRAY [G];
			-- Array containing the items

	first_child_table: ARRAY [INTEGER];
			-- Indices to the first child

	next_sibling_table: ARRAY [INTEGER];
			-- Indices to siblings

	active: INTEGER;
			-- Index of current item

	Removed_mark: INTEGER is -1;
			-- Mark for removed child in `first_child_table'

	last: INTEGER;
			-- Index into `item_table'; yields last item

	free_list_index: INTEGER;
			-- Index to first empty space in `item_table'
			
	free_list_count: INTEGER;
			-- Number of empty spaces in `item_table'
			
	remove_subtree (i: INTEGER) is
		local
			index, next: INTEGER;
			default_value: G;
		do
			from
				index := first_child_table.item (i);
			until
				index <= 0
			loop
				next := next_sibling_table.item (index);
				remove_subtree (index);
				index := next
			end;
			if i = last then
				last := last - 1
			else
				item_table.put (default_value, i);
				first_child_table.put(Removed_mark, i);
				next_sibling_table.put (free_list_index, i);
				free_list_index := i;
				free_list_count := free_list_count + 1;
			end;
		end;

	new_cell_index: INTEGER is
		local
			default_value: like item	
		do
			if free_list_index > 0 then
				Result := free_list_index;
				free_list_index := next_sibling_table.item (Result);
				free_list_count := free_list_count - 1
			else
				last := last + 1;
				item_table.force (default_value, last);
				next_sibling_table.force (0, last);
				first_child_table.force (0, last);
				Result := last
			end
		end;

	block_threshold: INTEGER is
		do
			Result := 10
		end;


end -- class COMPACT_CURSOR_TREE


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
