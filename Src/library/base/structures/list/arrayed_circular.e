indexing

	description:
		"Circular chains implemented by resizable array";

	copyright: "See notice at end of class";
	names: fixed_circular, ring, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class ARRAYED_CIRCULAR [G] inherit

	DYNAMIC_CIRCULAR [G]
		undefine
			readable, isfirst
		redefine
			start, islast
		select
			remove, go_i_th, after, before, off,
			prune_all, prune, first
		end;

	LIST [G]
		rename
			after as l_after,
			before as l_before,
			remove as l_remove,
			first as l_first,
			off as l_off, 
			prune as l_prune,
			prune_all as l_prune_all,
			go_i_th as l_go_i_th
		export {NONE}
			l_after, l_before, l_remove, l_first,
			l_off, l_prune, l_prune_all, l_go_i_th
		undefine
			last, exhausted, move, valid_cursor_index,
			isfirst, readable, islast, start
		end

creation

	make

feature -- Initialization

	make (n : INTEGER) is
			-- Create a circular chain with `n' items.
		require
			at_least_one: n >= 1
		do
			!!list.make (n)
		ensure
			new_count: count = n
		end

feature -- Measurement

	count : INTEGER is
			-- Number of items
		do
			Result := list.count
		end

feature -- Element change

	replace (v : G) is
			-- Replace current item by `v'.
		do
			list.replace (v)
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		do
			list.merge_right (other.list)
		end
	
	put_right (v : like item) is
			-- Put `v' to the right of cursor position.
			-- Do not move cursor.
		do
			list.put_right(v)
		end

	put_front (v : like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		do
			list.put_front (v)
		end

	extend (v : like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			list.extend (v)
		end

	merge_left (other : like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		do
			list.merge_left (other.list)
		end

	put_left (v : like item) is
			-- Put `v' to the left of cursor position.
			-- Do not move cursor.
		do
			list.put_left (v)
		end
	
feature --  Access 

	item : G is
			-- Current item
		do
			Result := list.item
		end

	cursor : CURSOR is
			-- Current cursor position
		do
			Result := list.cursor
		end

feature -- Status report

	full : BOOLEAN is
			-- Is structure filled to capacity? 
		do
			Result := list.full
		end

	readable : BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := list.readable
		end

	valid_cursor (p : CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		do
			Result := list.valid_cursor(p)
		end

	isfirst: BOOLEAN is
			-- Is cursor on first item?
		do
			if not empty then
				if starter = 0 then
					Result := list.isfirst
				else
					Result := (standard_index = starter)
				end
			end
		end;

	islast: BOOLEAN is
			-- Is cursor on last item?
		do
			if not empty then
				if (starter = 0) or (starter = 1) then
					Result := standard_islast
				else
					Result := (standard_index = starter-1)
				end
			end
		end;

feature -- Cursor movement

	go_to (p : CURSOR) is
			-- Move cursor to position `p'.
		do
			list.go_to(p)
		end

	set_start is
			-- Select current item as the first.
		do
			starter := standard_index
			internal_exhausted := false
		end;

	start is
			-- Move to position currently selected as first.
		do
			internal_exhausted := false
			if starter = 0 then
				standard_start;
				starter := 1
			else
				standard_go_i_th (starter)
				if standard_off then standard_start end
			end
		end

feature -- Element removal

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require else
			count > 1
		do
			if standard_isfirst then
				standard_finish; remove
			else
				standard_remove_left
			end
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require else
			count > 1
		do
			if standard_islast then
				standard_start; 
				remove;
				finish
			else
				standard_remove_right
			end
		end;

feature {ARRAYED_CIRCULAR} -- Implementation

	fix_start_for_remove is
			-- Before deletion, update starting position if necessary.
		do
			if count = 1 then
				starter := 0
			elseif starter = standard_index then
				if standard_islast then
					starter := 1
				else
					starter := starter + 1
				end
			end
		end;
		
	starter: INTEGER
			-- The position currently selected as first

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make (count)
		end;
	
	list : ARRAYED_LIST[G]
 
	standard_after : BOOLEAN is
			do
				Result := list.after
			end

	standard_back is
			do
				list.back
			end

	standard_before : BOOLEAN is
			do
				Result := list.before
			end

	standard_finish is
			do
				list.finish
			end

	standard_forth is
			do
				list.forth
			end

	standard_go_i_th (i : INTEGER) is
			do
				list.go_i_th (i)
			end

	standard_index : INTEGER is
			do
				Result := list.index
			end

	standard_isfirst: BOOLEAN is
			do
				Result := list.isfirst
			end

	standard_islast: BOOLEAN is
			do
				Result := list.islast
			end

	standard_move (i : INTEGER) is
			do
				list.move (i)
			end

	standard_off : BOOLEAN is
			do
				Result := list.off
			end

	standard_remove is
			do
				list.remove
			end

	standard_remove_left is
			do
				list.remove_left
			end

	standard_remove_right is
			do
				list.remove_right
			end

	standard_search (v: G) is
			do
				list.search (v)
			end

	standard_start is
			do
				list.start
			end

invariant
	count>= 0;
	starter >= 1;
	starter <= count

end -- class ARRAYED_CIRCUALR


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
