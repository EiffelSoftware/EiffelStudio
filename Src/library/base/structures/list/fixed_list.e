indexing

	description:
		"Lists with fixed numbers of items, implemented by arrays";

	copyright: "See notice at end of class";
	names: fixed, sequence;
	representation: array;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class FIXED_LIST [G] inherit

	LIST [G]
		export
			{NONE}
				force, extend, 
				put, fill,
				prune, prune_all;
		undefine
			force, prune, infix "@", is_equal, setup, put_i_th, occurrences,
			valid_index, prune_all, copy, has, consistent, i_th
		redefine
			first,
			last,
			swap,
			duplicate,
			move,
			start,
			finish,
			go_i_th
		end;
	
	ARRAY [G]
		rename
			make as array_make,
			put as put_i_th,
			item as i_th,
			duplicate as array_duplicate,
			force as force_i_th,
			bag_put as put
		export
			{NONE}
				all;
			{ANY}
				i_th,
				put_i_th,
				infix "@",
				is_equal,
				setup,
				occurrences,
				valid_index,
				copy,
				has,
				consistent;
			{FIXED_LIST}
				array_make
		undefine
			linear_representation, put, resizable
		redefine
			extendible
		end;

	FIXED [G]
		undefine
			copy, consistent, is_equal, setup,
			full
		end;

creation

	make
	
feature -- Initialization

	make (n: INTEGER) is
			-- Create an empty list.
		do
			array_make (1, n);
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
		
feature -- Status report

	extendible: BOOLEAN is false;
	
	valid_cursor (p: CURSOR): BOOLEAN is
			-- Is `p' a valid cursor?
		local
			fl_c: ARRAYED_LIST_CURSOR
		do
			fl_c ?= p;
			if fl_c /= Void then
				Result := valid_index (fl_c.index)
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

	replace (v: like first) is
			-- Replace current item by `v'.
		do
			put_i_th (v, index)
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
			!!Result.make (min (count - index + 1, n));
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
		
feature {NONE} 	-- Inapplicable

	force (v: like item) is
		do
			-- Inapplicable: requires extendible
		end;


end -- class FIXED_LIST	


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
