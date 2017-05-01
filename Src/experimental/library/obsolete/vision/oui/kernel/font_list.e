note

	description: "A list of fonts"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	FONT_LIST 

inherit

	G_ANY
		export
			{NONE} all
		end;

create

	make

feature -- Initialization

	make (a_screen: SCREEN)
			-- Create a font list corresponding to `a_screen'.
		do
			screen := a_screen;
			create {FONT_LIST_IMP} implementation.make (Current)
		end;
	
feature -- Access

	last: like first
			-- Item at last position
		require
			exists: not destroyed;
			not_empty: not empty
		do
			Result := implementation.last
		end;

	first: FONT
			-- Item at first position
		require
			exists: not destroyed;
			not_empty: not empty
		do
			Result := implementation.first
		end;

	i_th (i: INTEGER): like first
			-- Item at `i'_th position
		require
			exists: not destroyed;
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		do
			Result := implementation.i_th (i)
		end;

	index_of (v: like first; i: INTEGER): INTEGER
			-- Index of `i'-th item `v'; 0 if none
		require
			exists: not destroyed;
			positive_occurrence: i > 0
		do
			Result := implementation.index_of (v, i)
		ensure
			Result >= 0
		end;

	item: like first
			-- Item at cursor position
		require
			exists: not destroyed;
			not_off: not off
		do
			Result := implementation.item
		end;

	position: INTEGER
			-- Current cursor position, 0 if empty
		require
			exists: not destroyed
		do
			Result := implementation.position
		end;

	screen: SCREEN;
			-- Screen used to get the font list

feature -- Cursor movement

	finish
			-- Move cursor to last position
			-- (no effect if series is empty).
		require
			exists: not destroyed
		do
			implementation.finish
		ensure
			empty or islast
		end;

	back
			-- Move cursor backward one position.
		require
			exists: not destroyed;
			not_offleft: position > 0
		do
			implementation.back
		ensure
			position = old position - 1
		end;

	forth
			-- Move cursor forward one position.
		require
			exists: not destroyed;
			not empty and then position <= count
		do
			implementation.forth
		ensure
			position >= 1 and position <= count + 1
		end;

	go (i: INTEGER)
			-- Move cursor to position `i'.
		require
			exists: not destroyed;
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			implementation.go (i)
		ensure
			position = i
		end;

	search_equal (v: like first)
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			exists: not destroyed;
			search_element_exists: v /= Void
		do
			implementation.search_equal (v)
		ensure
			(not off) implies (v.is_equal (item))
		end;

	start
			-- Move cursor to first position.
		require
			exists: not destroyed
		do
			implementation.start
		ensure
			empty or isfirst
		end 

	move (i: INTEGER)
			-- Move cursor `i' positions.
		require
			exists: not destroyed;
			stay_right: position + i >= 0;
			stay_left: position + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		do
			implementation.move (i)
		ensure
			position = old position + i
		end;

feature -- Measurement

	count: INTEGER
			-- Number of items in current series
		require
			exists: not destroyed
		do
			Result := implementation.count
		end;

feature -- Status report

	off: BOOLEAN
			-- Is cursor off?
		require
			exists: not destroyed
		do
			Result := implementation.off
		end;

	offleft: BOOLEAN
			-- Is cursor off left edge?
		require
			exists: not destroyed
		do
			Result := implementation.offleft
		end;

	offright: BOOLEAN
			-- Is cursor off right edge?
		require
			exists: not destroyed
		do
			Result := implementation.offright
		end;

	empty: BOOLEAN
			-- Is current series empty?
		require
			exists: not destroyed
		do
			Result := implementation.empty
		end;

	has (v: like first): BOOLEAN
			-- Does `v' appear in current series?
		require
			exists: not destroyed
		do
			Result := implementation.has (v)
		end;

	destroyed: BOOLEAN
		do
			Result := implementation = Void
		end;

	is_destroyed: BOOLEAN obsolete "Use `destroyed' [2017-05-31]"
			-- Is current implementation destroyed?
		do
			Result := destroyed
		end;

	isfirst: BOOLEAN
			-- Is cursor at first position in current series?
		require
			exists: not destroyed
		do
			Result := implementation.isfirst
		ensure
			Result implies (not empty)
		end;

	islast: BOOLEAN
			-- Is cursor at last position in current series?
		require
			exists: not destroyed
		do
			Result := implementation.islast
		ensure
			Result implies (not empty)
		end;

feature -- Status setting

	destroy
			-- Destroy current font list implementation.
		do
			implementation.destroy;
			implementation := Void;
		end;

feature {NONE} -- Implementation

	implementation: FONT_LIST_I;
			-- Implementation of current font list

invariant
			-- Definitions:
	empty_is_zero_cnt: not destroyed implies (empty = (count = 0));
	off_is_offleft_or_offright: not destroyed implies (off = 
		((position = 0) or else (position = count + 1)));
	isfirst_is_pos_one: not destroyed implies (isfirst = (position = 1));
	islast_is_pos_cnt: not destroyed implies (islast = (not empty and (position = count)));
			-- Axioms:
	non_negative_count: not destroyed implies count >= 0;
	non_negative_position: not destroyed implies position >= 0;
	stay_on: not destroyed implies position <= count + 1;
	empty_implies_off: not destroyed implies (empty implies off);
	empty_implies_zero_pos: not destroyed implies (empty implies position = 0);
			-- Theorems:
	not_on_empty: not destroyed implies (empty implies not (isfirst or islast));
	not_on_destroy: not destroyed implies implementation /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FONT_LIST

