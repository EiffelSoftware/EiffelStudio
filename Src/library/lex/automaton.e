indexing

	description:
		"General finite-state automata";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	AUTOMATON

feature

	greatest_input: INTEGER;
			-- Greatest input used for the transitions from state
			-- to state (the smallest one is zero)

	start_number: INTEGER;
			-- Unique start state used for the beginning of
			-- the course through the automaton

	nb_states: INTEGER;
			-- Number of states in the automaton

	set_start (n: INTEGER) is
			-- Set the nth state as start.
		require
			no_other_start: start_number = 0 or start_number = n;
			is_in_automaton: n <= nb_states and n >= 1
		do
			start_number := n
		end; -- set_start

	set_transition (source, inp_ut, target: INTEGER) is
			-- Set transition from source to target on inp_ut.
		deferred
		end; -- set_transition

	set_final (state, f: INTEGER) is
			-- Set the attribute "final" of state as f.
		deferred
		end; -- set_final

	set_state is
			-- Make a new state.
		deferred
		end -- set_state

end -- class AUTOMATON
 

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
