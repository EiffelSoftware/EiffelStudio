indexing

	description:
		"Lists with fixed maximum numbers of items, implemented by arrays";

	status: "See notice at end of class";
	names: fixed, sequence;
	representation: array;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class FIXED_LIST [G] inherit

	LIST [G]
		export
			{ANY}
				put
			{NONE}
				force, extend,
				fill,
				prune, prune_all;
		undefine
			force, prune, infix "@", is_equal, put_i_th, occurrences,
			valid_index, prune_all, copy, has, i_th
		redefine
			first,
			last,
			swap,
			duplicate,
			move,
			start,
			finish,
			go_i_th,
			put,
			remove
		select
			extendible, index_set
		end;

	ARRAY [G]
		rename
			make as array_make,
			put as put_i_th,
			item as i_th,
			force as force_i_th,
			bag_put as put,
			index_set as array_index_set,
			extendible as array_extendible
		export
			{NONE}
				all;
			{ANY}
				i_th,
				put_i_th,
				infix "@",
				is_equal,
				occurrences,
				valid_index,
				copy,
				area,
				has
			{FIXED_LIST}
				array_make
		undefine
			count, linear_representation, put, resizable
		redefine
			full, extend, prunable
		end;

	FIXED [G]
		undefine
			copy, is_equal,
			full
		end;

creation

	make, make_filled

feature -- Initialization

	make (n: INTEGER) is
			-- Create an empty list.
		do
			array_make (1, n);
		ensure
			is_before: before;
			new_count: count = 0
		end;

	make_filled (n: INTEGER) is
			-- Create a list with `n' void elements.
		do
			array_make (1, n);
			count := n;
		ensure
			is_before: before;
			new_count: count = n
		end;

feature -- Access

	index: INTEGER;
		-- Current position in the list

	item: G is
			-- Current item
		do
			Result := area.item (index - 1)
		end;

	first: G is
			-- Item at first position
		do
			Result := area.item (0)
		end;

	last: like first is
			-- Item at last position
		do
			Result := area.item (count - 1)
		end;

	cursor: CURSOR is
			-- Current cursor position
		do
			!ARRAYED_LIST_CURSOR! Result.make (index)
		end;

	count: INTEGER

feature -- Status report

	extendible: BOOLEAN is
			-- May new items be added?
		do
			Result := (count < capacity)
		end

	prunable: BOOLEAN is
			-- May items be removed?
		do
			Result := not empty
		end

	full: BOOLEAN is
			-- Is the list full?
		do
			Result := count = capacity
		end

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Is `p' a valid cursor?
		local
			fl_c: ARRAYED_LIST_CURSOR
		do
			fl_c ?= p;
			if fl_c /= Void then
				Result := valid_cursor_index (fl_c.index)
			end
		end;

feature -- Cursor movement

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			index := index + i;
			if (index > count + 1) then
				index := count + 1
			elseif index < 0 then
				index := 0
			end
		end;

	start is
			-- Move cursor to first position.
		do
			index := 1
		end;

	finish is
			-- Move cursor to last position.
		do
			index := count
		end;

	forth is
			-- Move cursor to next position, if any.
		do
			index := index + 1
		end;

	back is
			-- Move cursor to previous position, if any.
		do
			index := index - 1
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			index := i
		end;

	go_to (p: CURSOR) is
			-- Move cursor to element remembered in `p'.
		local
			fl_c: ARRAYED_LIST_CURSOR
		do
			fl_c ?= p;
			check
				fl_c /= Void
			end;
			index := fl_c.index
		end;

feature -- Element change

	put (v: like first) is
			-- Replace current item by `v'.
			-- (Synonym for `replace')
		require else
			true
		do
			replace (v)
		end

	replace (v: like first) is
			-- Replace current item by `v'.
		do
			put_i_th (v, index)
		end;

	extend (v: like item) is
			-- Add `v' to end.
			-- Move index to the current item.
		do
			count := count + 1
			index := count
			force_i_th (v, count)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor)
		local
			i,j: INTEGER;
			default_value: G;
		do
			if not off then
				from
					i := index - 1;
				until
					i >= count - 1
				loop
					j := i + 1;
					area.put (area.item (j), i);
					i := j;
				end;
				put_i_th (default_value, count);
				count := count - 1
			end
		end;

feature -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			old_item: like item;
		do
			old_item := item;
			replace (i_th (i));
			put_i_th (old_item, i)
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-list beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		local
			pos: INTEGER
		do
			!!Result.make_filled (n.min (count - index + 1));
			from
				Result.start;
				pos := index
			until
				Result.exhausted
			loop
				Result.replace (item);
				forth;
				Result.forth
			end;
			Result.start;
			index := pos;
		end;

feature {NONE} -- Implementation

	force (v: like item) is
			-- Not used since extend is not always applicable.
		do
		end;

end -- class FIXED_LIST


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

