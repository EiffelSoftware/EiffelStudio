indexing

	description:
		"Circular chains implemented by resizable arrays";

	copyright: "See notice at end of class";
	names: fixed_circular, ring, sequence;
	representation: array;
	access: index, cursor, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class ARRAYED_CIRCULAR [G] inherit

	CIRCULAR [G]
		undefine
			infix "@", readable,
			put_i_th, valid_index,
			i_th, swap, prune_all
		redefine
			start
		select
			search,
			remove, 
			isfirst, islast, index,
			start, finish, back, forth, move, go_i_th,
			after, before, off
		end;

	ARRAYED_LIST [G]
		rename
			after as standard_after,
			back as standard_back,
			before as standard_before,
			finish as standard_finish,
			forth as standard_forth,
			go_i_th as standard_go_i_th,
			index as standard_index,
			isfirst as standard_isfirst,
			islast as standard_islast,
			make as al_make,
			move as standard_move,
			off as standard_off,
			remove as standard_remove,
			remove_left as standard_remove_left,
			remove_right as standard_remove_right,
			search as standard_search,
			start as standard_start
		export {NONE}
			al_make,
			standard_after, standard_back, standard_before,
			standard_finish, standard_forth, standard_go_i_th,
			standard_index, standard_isfirst, standard_islast,
			standard_move, standard_off, standard_remove,
			standard_remove_left, standard_remove_right, standard_search,
			standard_start
		undefine
			has, valid_cursor_index, bag_put, prune, is_equal,
			setup, occurrences, copy, consistent, force,
			first, last,
			exhausted
		end;

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create a circular chain with `n' items.
		require
			at_least_one: n >= 1
		do
			al_make (n);
			starter := 1
		ensure
			new_count: count = n
		end;

feature -- Access

	starter: INTEGER;
			-- Index of item currently selected as first

feature -- Status setting

	set_start is
			-- Designate current position as the starting position
		do
			starter := standard_index
		end;

feature -- Cursor movement

	start is
			-- Move to position currently selected as first.
		do
			standard_move (starter)
		end;

feature {NONE} -- Implementation

	fix_start_for_remove is
			-- Before deletion, update starting position if necessary.
		do
			if (starter = standard_index) and standard_islast then
				starter := 1
			end
		end;

invariant

	count >= 0;
	starter >= 1; starter <= count

end -- class ARRAYED_CIRCULAR


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
