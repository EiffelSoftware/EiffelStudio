
indexing

	date: "$Date$";
	revision: "$Revision$"

class FONT_LIST 

inherit

	G_ANY
		export
			{NONE} all
		end;

	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

creation

	make

feature 

	back is
			-- Move cursor backward one position.
		require
			not_offleft: position > 0
		do
			implementation.back
		ensure
			position = old position - 1
		end;

	count: INTEGER is
			-- Number of items in current series
		do
			Result := implementation.count
		end;

	make (a_screen: SCREEN) is
			-- Create a font list corresponding to `a_screen'.
		do
			screen := a_screen;
			implementation := toolkit.font_list (Current)
		end;

	
feature {NONE}

	destroy is
			-- Destroy current font list implementation.
		do
			implementation.destroy;
			implementation := Void;
			is_destroyed := true
		end;

	dispose is
			-- Garbage Collector routine for current font list.
		do
			destroy
		end;

	
feature 

	empty: BOOLEAN is
			-- Is current series empty?
		do
			Result := implementation.empty
		end;

	finish is
			-- Move cursor to last position
			-- (no effect if series is empty).
		do
			implementation.finish
		ensure
			empty or islast
		end;

	first: FONT is
			-- Item at first position
		require
			not_empty: not empty
		do
			Result := implementation.first
		end;

	forth is
			-- Move cursor forward one position.
		require
			not empty and then position <= count
		do
			implementation.forth
		ensure
			position >= 1 and position <= count + 1
		end;

	go (i: INTEGER) is
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			implementation.go (i)
		ensure
			position = i
		end;

	has (v: like first): BOOLEAN is
			-- Does `v' appear in current series?
		do
			Result := implementation.has (v)
		end;

	i_th (i: INTEGER): like first is
			-- Item at `i'_th position
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		do
			Result := implementation.i_th (i)
		end;

	
feature {NONE}

	implementation: FONT_LIST_I;
			-- Implementation of current font list

	
feature 

	index_of (v: like first; i: INTEGER): INTEGER is
			-- Index of `i'-th item `v'; 0 if none
		require
			positive_occurrence: i > 0
		do
			Result := implementation.index_of (v, i)
		ensure
			Result >= 0
		end;

	is_destroyed: BOOLEAN;
			-- Is current implementation destroyed?

	isfirst: BOOLEAN is
			-- Is cursor at first position in current series?
		do
			Result := implementation.isfirst
		ensure
			Result implies (not empty)
		end;

	islast: BOOLEAN is
			-- Is cursor at last position in current series?
		do
			Result := implementation.islast
		ensure
			Result implies (not empty)
		end;

	item: like first is
			-- Item at cursor position
		require
			not_off: not off
		do
			Result := implementation.item
		end;

	last: like first is
			-- Item at last position
		require
			not_empty: not empty
		do
			Result := implementation.last
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require
			stay_right: position + i >= 0;
			stay_left: position + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			implementation.move (i)
		ensure
			position = old position + i
		end;

	off: BOOLEAN is
			-- Is cursor off?
		do
			Result := implementation.off
		end;

	offleft: BOOLEAN is
			-- Is cursor off left edge?
		do
			Result := implementation.offleft
		end;

	offright: BOOLEAN is
			-- Is cursor off right edge?
		do
			Result := implementation.offright
		end;

	position: INTEGER is
			-- Current cursor position, 0 if empty
		do
			Result := implementation.position
		end;

	screen: SCREEN;
			-- Screen used to get the font list

	search_equal (v: like first) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			search_element_exists: not (v = Void)
		do
			implementation.search_equal (v)
		ensure
			(not off) implies (v.is_equal (item))
		end;

	start is
			-- Move cursor to first position.
		do
			implementation.start
		ensure
			empty or isfirst
		end 

invariant
			-- Definitions:
	empty_is_zero_cnt: empty = (count = 0);
	off_is_offleft_or_offright: off = 
		((position = 0) or else (position = count + 1));
	isfirst_is_pos_one: isfirst = (position = 1);
	islast_is_pos_cnt: islast = (not empty and (position = count));
			-- Axioms:
	non_negative_count: count >= 0;
	non_negative_position: position >= 0;
	stay_on: position <= count + 1;
	empty_implies_off: empty implies off;
	empty_implies_zero_pos: empty implies position = 0;
			-- Theorems:
	not_on_empty: empty implies not (isfirst or islast);
	not_on_destroy: not is_destroyed implies not (implementation = Void)

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
