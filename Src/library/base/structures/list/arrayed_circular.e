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
			infix "@", first, readable,
			put_i_th, valid_index, last,
			i_th, swap, prune_all
		select
			search,
			remove, 
			start, finish, back, forth, move, go_i_th	
		end;

	ARRAYED_LIST [G]
		rename
			make as al_make,
			search as standard_search,
			remove as standard_remove,
			forth as standard_forth,
			back as standard_back,
			move as standard_move,
			start as standard_start,
			finish as standard_finish,
			go_i_th as standard_go_i_th
		export
			{NONE}
				al_make
		undefine
			has, valid_cursor_index, exhausted, bag_put, prune, is_equal,
			setup, occurrences, copy, consistent, force
		end;

	ARRAYED_LIST [G]
		rename
			make as al_make
		export 
			{NONE}
				al_make
		undefine
			has, valid_cursor_index, exhausted,
			search, 
			remove, bag_put, prune, is_equal,
			setup, occurrences, copy, consistent,
			forth, back, move, start, finish, go_i_th, force
		end
			
creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create a circular with `n' items.
		require
			at_least_one: n >= 1
		do
			al_make (n)
		ensure
			new_count: count = n
		end;

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
