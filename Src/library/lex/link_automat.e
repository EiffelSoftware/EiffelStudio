--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General finite state automata implemented as lists

indexing

	date: "$Date$";
	revision: "$Revision$"

class LINK_AUTOMAT [S->STATE]

inherit

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
