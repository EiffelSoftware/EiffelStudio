indexing

	description:
		"General finite-state automata";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	AUTOMATON

feature -- Access

	greatest_input: INTEGER;
			-- Greatest input used for the transitions from state
			-- to state (the smallest one is zero)

	start_number: INTEGER;
			-- Unique start state used for the beginning of
			-- the automaton's operation

feature -- Measurement

	nb_states: INTEGER;
			-- Number of states in the automaton

feature -- Status setting

	set_start (n: INTEGER) is
			-- Select state `n' as the starting state.
		require
			no_other_start: start_number = 0 or start_number = n;
			is_in_automaton: n <= nb_states and n >= 1
		do
			start_number := n
		end; 

	set_transition (source, input_doc, target: INTEGER) is
			-- Set transition from source to target on `input_doc'.
		deferred
		end; 

	set_final (state, f: INTEGER) is
			-- Make `state' final for regular expression `f'.
		deferred
		end; 

	set_state is
			-- Make a new state.
		deferred
		end 

end -- class AUTOMATON
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

