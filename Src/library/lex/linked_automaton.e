
indexing

	description:
		"General finite state automata, implemented as lists";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LINKED_AUTOMATON [S -> STATE]

inherit
	LINKED_LIST [S]

creation
	make

feature -- Status setting

	set_final (state, f: INTEGER) is
			-- Make `state' a final state of regualr expression `f'.
		require
			is_in_automaton: state <= count and state >= 1
		local
			old_p: CURSOR
		do
			old_p := cursor;
			go_i_th (state);
			item.set_final (f);
			go_to (old_p)
		ensure
			same_index: index = old index 
		end 

end -- class LINKED_AUTOMATON
 

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
