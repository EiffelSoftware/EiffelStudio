indexing

	description:
		"Circular chains, implemented as two way linked lists";

	copyright: "See notice at end of class";
	names: two_way_circular, ring, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_CIRCULAR [G] inherit

	DYNAMIC_CIRCULAR [G]
		undefine
			wipe_out,
			isfirst,
			readable, first ,
			islast, last
		select
			search, 
			remove,
			start, finish, back, forth, move, go_i_th
		end;


	TWO_WAY_LIST [G]
		rename
			search as standard_search,
			remove as standard_remove,
			forth as standard_forth,
			back as standard_back,
			move as standard_move,
			start as standard_start,
			finish as standard_finish,
			go_i_th as standard_go_i_th
		undefine
			valid_cursor_index, exhausted
		redefine
			new_chain
		end;

	TWO_WAY_LIST [G]
		undefine
			valid_cursor_index, exhausted,
			search, 
			remove,
			forth, back, move, start, finish, go_i_th
		redefine
			new_chain
		end

creation

	make

feature {TWO_WAY_CIRCULAR} -- Implementation

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make
		end;

end -- class TWO_WAY_CIRCULAR


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
