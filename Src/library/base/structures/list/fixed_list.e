--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Lists with a fixed number of items, implemented as arrays

indexing

	names: fixed_list, sequence;
	representation: array;
	access: index, cursor, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class FIXED_LIST [G] inherit

	ARRAY [G]
		rename
			make as array_make,
			put as put_i_th,
			item as i_th,
			empty as array_empty,
			duplicate as array_duplicate
		export
			{} all;
			{FIXED_LIST}
				array_make
		undefine
			sequential_representation
		select
			array_empty
		end;

	LIST [G]
		export
			{NONE} add
		undefine
			valid_index, twin,
			has, infix "@", i_th, put_i_th
		redefine
			first, last, swap,
			go_i_th, move
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		undefine
			twin
		end

creation

	make

feature -- Creation

	make (n: INTEGER) is
			-- Allocate list with `n' elements.
			-- (`n' may be zero for empty list.)
		require
			valid_number_of_elements: n >= 0
		do
			array_make (1, n)
		ensure
			new_count: count = n
		end;

feature -- Access

	item: G is
			-- Current item
		require else
			index_is_valid: valid_index (index)
		do
			Result := i_th (index);
		end;

	first: G is
			-- Item at first position
		do
			Result := i_th (1);
		end;

	last: G is
			-- Item at last position
		do
			Result := i_th (count)
		end;

feature -- Insertion

	replace (v: G) is
			-- Replace current item by `v'.
		do
			put_i_th (v, index)
		end;

	extensible: BOOLEAN is false;
			-- May new items be added to current?

feature {NONE} -- Insertion

	add (v: like item) is
			-- Include `v' in `Current'.
			-- No sense in a fixed list because not extensible.
		do
		end;

feature -- Transformation

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-list beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		local
			pos: INTEGER
		do
			!! Result.make (min (count - index + 1, n));
			from
				Result.start;
				pos := index
			until
				Result.after
			loop
				Result.replace (item);
				forth;
				Result.forth
			end;
			Result.start;
			go_i_th (pos)
		end;

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			old_item: like item
		do
			old_item := item;
			replace (i_th (i));
			put_i_th (old_item, i)
		end;

feature -- Cursor

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

	forth is
			-- Move cursor one position forward.
		do
			move (1);
		end;

	back is
			-- Move cursor one position backward.
		do
			move (-1);
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			index := i
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			fl_c: FIXED_LIST_CURSOR
		do
			fl_c ?= p;
				check
					fl_c /= Void
				end;
			index := fl_c.index
		end;

	index: INTEGER;
			-- Index of `item', if valid.

	cursor: CURSOR is
			-- Current cursor position
		do
			!FIXED_LIST_CURSOR! Result.make (index)
		end;

feature -- Assertion check

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			fl_c: FIXED_LIST_CURSOR
		do
			fl_c ?= p;
			if fl_c /= Void then
				Result := valid_index (fl_c.index)
			end
		end;

end
