indexing

	description:
		"Lists implemented by resizable arrays";

	status: "See notice at end of class";
	names: sequence;
	representation: array;
	access: index, cursor, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class ARRAYED_LIST [G] inherit

	ARRAY [G]
		rename
			force as force_i_th,
			item as i_th,
			make as array_make,
			put as put_i_th,
			wipe_out as array_wipe_out,
			count as array_count,
			bag_put as put,
			copy as array_copy
		export
			{NONE}
				all;
			{ARRAYED_LIST}
				array_make;
			{ANY}
				capacity
		undefine
			linear_representation, prunable, put,
			prune, consistent, occurrences,
			extendible, has, is_equal
		redefine
			extend, setup, prune_all, full, valid_index
		end;

	ARRAY [G]
		rename
			force as force_i_th,
			item as i_th,
			make as array_make,
			put as put_i_th,
			count as array_count,
			bag_put as put,
			copy as array_copy
		export
			{NONE}
				all;
			{ARRAYED_LIST}
				array_make;
			{ANY}
				capacity
		undefine
			linear_representation, prunable, full, put,
			prune, consistent, occurrences,
			extendible, has, is_equal
		redefine
			wipe_out, extend,
			setup, prune_all, valid_index
		select
			wipe_out
		end;

	DYNAMIC_LIST [G]
		undefine
			valid_index, infix "@", i_th, put_i_th,
			force, is_equal
		redefine
			first, last, swap, wipe_out,
			go_i_th, move, prunable, start, finish,
			count, prune, remove,
			setup, copy, put_left, merge_left,
			merge_right, duplicate, prune_all
		select
			count, copy
		end;

creation

	make, make_filled

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate list with `n' items.
			-- (`n' may be zero for empty list.)
		require
			valid_number_of_items: n >= 0
		do
			array_make (1, n)
		ensure
			correct_position: before
		end;

	make_filled (n: INTEGER) is
			-- Allocate list with `n' items.
			-- (`n' may be zero for empty list.)
			-- This list will be full.
		require
			valid_number_of_items: n >= 0
		do
			array_make (1, n)
			count := n
		ensure
			correct_position: before
			filled: full
		end;

feature -- Access

	item: like first is
			-- Current item
		require else
			index_is_valid: valid_index (index)
		do
			Result := area.item (index - 1);
		end;

	first: G is
			-- Item at first position
		do
			Result := area.item (0);
		end;

	last: like first is
			-- Item at last position
		do
			Result := area.item (count - 1)
		end;

	index: INTEGER;
			-- Index of `item', if valid.

	cursor: CURSOR is
			-- Current cursor position
		do
			!ARRAYED_LIST_CURSOR! Result.make (index)
		end;

feature -- Measurement

	count: INTEGER;
		-- Number of items.

feature -- Status report

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := true
		end;

	full: BOOLEAN is
			-- Is structure filled to capacity? (Answer: no.)
		do
			Result := (count = capacity)
		end;

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			al_c: ARRAYED_LIST_CURSOR
		do
			al_c ?= p;
			if al_c /= Void then
				Result := valid_cursor_index (al_c.index)
			end
		end;

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid index?
		do
			Result := (1 <= i) and (i <= count)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			--Is other equal to Current?
	local
			c1,c2: like cursor;
		do
			if (count = other.count) and 
			   (object_comparison = other.object_comparison) then
					--Count and comparison_criterium have to be the same
				c1 := cursor;
				c2 := other.cursor;
				other.start
				start
				Result := True
				if object_comparison then
					from
					until
						after or not Result
					loop
						Result := equal (item, other.item)
						forth
						other.forth
					end
				else
					from
					until
						after or not Result
					loop
						Result := item = other.item
						forth
						other.forth
					end
				end		
				go_to (c1);
				other.go_to (c2);
			end
		end;

			
feature -- Cursor movement

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			index := index + i;
			if (index > count + 1) then
				index := count + 1
			elseif (index < 0) then
				index := 0
			end
		end;

	start is
			-- Move cursor to first position if any.
		do
			index := 1
		ensure then
			after_when_empty: empty implies after
		end;

	finish is
			-- Move cursor to last position if any.
		do
			index := count
		--| Temporary patch. Start moves the cursor
		--| to the first element. If the list is empty
		--| the cursor is before. The parents (CHAIN, LIST...)
		--| and decendants (ARRAYED_TREE...) need to be revised.
		ensure then
			before_when_empty: empty implies before
		end;

	forth is
			-- Move cursor one position forward.
		do
			index := index + 1
		end;

	back is
			-- Move cursor one position backward.
		do
			index := index - 1
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			index := i;
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			al_c: ARRAYED_LIST_CURSOR
		do
			al_c ?= p;
				check
					al_c /= Void
				end;
			index := al_c.index
		end;

feature -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			old_item: like item
		do
			old_item := item;
			replace (area.item (i - 1));
			area.put (old_item, i - 1);
		end;

feature -- Element change

	put_front (v: like item) is
			-- Add `v' to the beginning.
			-- Do not move cursor.
		do
			if empty then
				extend (v)
			else
				insert (v, 1)
			end;
		end;

	force, extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			count := count + 1;
			force_i_th (v, count)
		end;

	put_left (v: like item) is
			-- Add `v' to the left of current position.
			-- Do not move cursor.
		do
			if after or empty then
				extend (v);
				index := index + 1
			else
				insert (v, index)
			end
		end;

	put_right (v: like item) is
			-- Add `v' to the right of current position.
			-- Do not move cursor.
		do
			if index = count then
				extend (v)
			else
				insert (v, index + 1)
			end;
		end;


	replace (v: like first) is
			-- Replace current item by `v'.
		do
			put_i_th (v, index)
		end;

	merge_left (other: ARRAYED_LIST [G]) is
		local
			i, l_count: INTEGER;
		do
			if not other.empty then
				resize (1, count + other.count);
				from
					i := count - 1;
					l_count := other.count
				until
					i < index - 1
				loop
					area.put (area.item (i), i + l_count);
					i := i - 1
				end;
				from
					other.start;
					i := index - 1
				until
					other.after
				loop
					area.put (other.item, i);
					i := i + 1;
					other.forth
				end;
				index := index + l_count;
				count := count + l_count;
				other.wipe_out
			end
		end;

	merge_right (other: ARRAYED_LIST [G]) is
		local
			old_index: INTEGER;
		do
			old_index := index;
			index := index + 1;
			merge_left (other);
			index := old_index
		end;

feature -- Removal

	prune (v: like item) is
			-- Remove first occurrence of `v', if any,
			-- after cursor position.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor or `v'does not occur)
		do
			if before then index := 1 end;
			if object_comparison then
				if v /= Void then
					from
					until
						after or else (item /= Void and then v.is_equal (item))
					loop
						forth;
					end
				end
			else
				from
				until
					after or else item = v
				loop
					forth;
				end
			end;
			if not after then remove end;
		end;

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor)
		local
			i,j: INTEGER
			default_value: G
			l_count: INTEGER
		do
			if not off then
				from
					i := index - 1
					l_count := count - 1
				until
					i >= l_count
				loop
					j := i + 1
					area.put (area.item (j), i)
					i := j
				end;
				put_i_th (default_value, count)
				count := count - 1
			end
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave cursor `after'.
		local
			i: INTEGER;
			val, default_value: like item;
		do
			if object_comparison then
				if v /= void then
					from
						start
					until
						after or else (item /= Void and then v.is_equal (item))
					loop
						index := index + 1;
					end;
					from
						if not after then
							i := index;
							index := index + 1
						end
					until
						after
					loop
						val := item;
						if val /= Void and then not v.is_equal (val) then
							put_i_th (val, i);
							i := i + 1
						end;
						index := index + 1;
					end
				end
			else
				from
					start
				until
					after or else (item = v)
				loop
					index := index + 1;
				end;
				from
					if not after then
						i := index;
						index := index + 1
					end
				until
					after
				loop
					val := item;
					if val /= v then
						put_i_th (val, i);
						i := i + 1;
					end;
					index := index + 1
				end
			end;
			if i > 0 then
				index := i
				from
				until
					i >= count
				loop
					put_i_th (default_value, i);
					i := i + 1;
				end;
				count := index - 1;
			end
		ensure then
			is_after: after;
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			index := index - 1;
			remove;
		end;

	remove_right is
			-- Remove item to the right of cursor position
			-- Do not move cursor
		do
			index := index + 1;
			remove;
			index := index - 1;
		end;

	wipe_out is
			-- Remove all items.
		do
			count := 0;
			index := 0;
			array_wipe_out;
		end;

feature -- Duplication

	setup (other: like Current) is
			-- Prepare current object so that `other'
			-- can be easily copied into it.
			-- It is not necessary to call `setup'
			-- (since `consistent' is always true)
			-- but it will make copying quicker.
		do
			if other.empty then
				wipe_out
			else
				resize (1, other.count)
			end
		end;

	copy (other: like Current) is
		do
			if capacity < other.count then
				make_area (other.count)
				 	--lower for arrayed list always 1
				upper := other.count
			else
				make_area (capacity)
			end
			count := other.count
			object_comparison := other.object_comparison
			subcopy (other, 1, other.count, 1)
		end;

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-list beginning at current position
			-- and having min (`n', `count' - `index' + 1) items.
		local
			pos: INTEGER
		do
			!! Result.make (n.min (count - index + 1));
			from
				Result.start;
				pos := index
			until
				Result.count = Result.capacity
			loop
				Result.extend (item);
				forth;
			end;
			Result.start;
			go_i_th (pos);
		end;


feature {NONE} --Internal

	insert (v: like item; pos: INTEGER) is
			-- Add `v' at `pos', moving subsequent items
			-- to the right.
		require
			index_small_enough: pos <= count;
			index_large_enough: pos >= 1;
		local
			i,j: INTEGER;
			p : INTEGER;
			last_value: like item;
			last_item: like item;
		do
			if index >= pos then
				index := index + 1
			end;
			last_item := last;
			count := count + 1;
			force_i_th (last_item, count);
			from
				i := count - 2
			until
				i < pos
			loop
				j := i - 1;
				area.put (area.item (j), i);
				i := j;
			end;
			put_i_th (v, pos);
		ensure
			new_count: count = old count + 1;
			insertion_done: i_th (pos) = v
		end;

	new_chain: like Current is
			-- unused
		do
		end;

invariant

	prunable: prunable;
	starts_from_one: lower = 1;

end -- class ARRAYED_LIST

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

