
-- 

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FONT_LIST_I 

inherit
	G_ANY_I
		export
			{NONE} all
		undefine
			copy,
			is_equal,
			consistent,
			setup
		end;

feature 

	count: INTEGER is
			-- Number of items in the chain
		deferred
		end;  -- count

	destroy is
			-- Destroy current font list.
		deferred
		end; -- destroy

	empty: BOOLEAN is
			-- Is the chain empty?
		deferred
		end; -- empty

	position: INTEGER is
			-- Current cursor position, 0 if empty
		deferred
		end; -- position

	off: BOOLEAN is
			-- Is cursor off?
		deferred
		end; -- off

	offleft: BOOLEAN is
			-- Is cursor off left edge?
		deferred
		end; -- offleft

	offright: BOOLEAN is
			-- Is cursor off right edge?
		deferred
		end; -- offright

	isfirst: BOOLEAN is
			-- Is cursor at first position in the chain?
		deferred
		ensure
			Result implies (not empty)
		end; -- isfirst

	islast: BOOLEAN is
			-- Is cursor at last position in the chain?
		deferred
		ensure
			Result implies (not empty)
		end; -- islast

	first: FONT is
			-- Item at first position
		require
			not_empty: not empty
		deferred
		end; -- first

	item: like first is
			-- Item at cursor position
		require
			not_off: not off
		deferred
		end; -- item

	i_th (i: INTEGER): like first is
			-- Item at `i'_th position
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		deferred
		end; -- i_th

	last: like first is
			-- Item at last position
		require
			not_empty: not empty
		deferred
		end; -- last

	start is
			-- Move cursor to first position.
		deferred
		ensure
			empty or isfirst
		end; -- start

	finish is
			-- Move cursor to last position
			-- (no effect if chain is empty).
		deferred
		ensure
			empty or islast
		end; -- finish

	forth is
			-- Move cursor forward one position.
		require
			not empty and then position <= count
		deferred
		ensure
			position >= 1 and position <= count + 1
		end; -- forth

	back is
			-- Move cursor backward one position.
		require
			not_offleft: position > 0
		deferred
		ensure
--			position = old position - 1
		end; -- back

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		require
			stay_right: position + i >= 0;
			stay_left: position + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
--			position = old position + i
		end; -- move

	go (i: INTEGER) is
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
			position = i
		end; -- go

	search_equal (v: like first) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			search_element_exists: not (v = Void)
		deferred
		ensure
			(not off) implies (v.is_equal (item))
		end; -- search_equal

	index_of (v: like first; i: INTEGER): INTEGER is
			-- Index of `i'-th item `v'; 0 if none
		require
			positive_occurrence: i > 0
		deferred
		ensure
			Result >= 0
		end; -- index_of

	has (v: like first): BOOLEAN is
			-- Does `v' appear in the chain ?
		deferred
		end -- has

invariant

		-- Definitions:

	empty_is_zero_cnt:
		empty = (count = 0);

	off_is_offleft_or_offright:
		off = ((position = 0) or else (position = count + 1));

	isfirst_is_pos_one:
		isfirst = (position = 1);

	islast_is_pos_cnt:
		islast = (not empty and (position = count));

		-- Axioms:

	non_negative_count:
		count >= 0;

	non_negative_position:
		position >= 0;

	stay_on:
		position <= count + 1;

	empty_implies_off:
		empty implies off;

	empty_implies_zero_pos:
		empty implies position = 0;

		-- Theorems:
	not_on_empty:
		empty implies not (isfirst or islast)

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
