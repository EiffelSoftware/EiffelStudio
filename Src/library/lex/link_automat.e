
indexing

	description:
		"General finite state automata, implemented as lists";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LINK_AUTOMAT [S->STATE] inherit

	LINKED_LIST [S]

creation

	make

feature

	set_final (state, f: INTEGER) is
			-- Assign f to the attribute "final" of state.
		require
			is_in_automaton: state <= count and state >= 1
		local
			old_p: INTEGER
		do
			old_p := index;
			go_i_th (state);
			item.set_final (f);
			go_i_th (old_p)
		ensure
			same_index: old index = index
		end -- set_final

end -- class LINK_AUTOMAT
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
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
