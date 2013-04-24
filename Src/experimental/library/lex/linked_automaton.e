
note

	description:
		"General finite state automata, implemented as lists"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class LINKED_AUTOMATON [S -> STATE] inherit

	LINKED_LIST [S]

create

	make

feature -- Status setting

	set_final (state, f: INTEGER)
			-- Make `state' a final state for regular expression `f'.
		require
			is_in_automaton: state <= count and state >= 1
		local
			old_p: CURSOR
			l_item: S
		do
			old_p := cursor;
			go_i_th (state);
			l_item := item
			check l_item_attached: l_item /= Void end
			l_item.set_final (f);
			go_to (old_p)
		ensure
			same_index: index = old index
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class LINKED_AUTOMATON

