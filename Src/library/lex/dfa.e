indexing

	description:
		"General deterministic finite automata";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class DFA inherit

	AUTOMATON

feature -- Access

	recognize (l: LINKED_LIST [INTEGER]): INTEGER is
			-- `final' value for the state reached after
			-- making transitions from state to state on the
			-- inputs listed in `l'; 0 if not recognized.
		local
			state: STATE_OF_DFA;
		do
			from
				state := start_state;
				l.start
			until
				(l.after or l.is_empty) or else
					state.successor (l.item) = Void
			loop
				state := state.successor (l.item);
				l.forth
			end;
			if (l.after or l.is_empty) then
				Result := state.final
			end
		end; 

	possible_tokens (l: LINKED_LIST [INTEGER]): ARRAY [INTEGER] is
			-- Attribute ``final_array'' of the state reached in Current after
			-- making transitions from state to state on the
			-- inputs listed in `l'; empty if not recognized
		local
			state: STATE_OF_DFA;
		do
			from
	   			state := start_state;
   				l.start
			until
   				(l.after or l.is_empty) or else state.successor(l.item) = Void
			loop
   				state := state.successor (l.item);
   				l.forth
			end;
			if l.after or l.is_empty then
   				Result := state.final_array
			else
   				!!Result.make (0, -1)
			end
		end; 

	find_successor (source, input_doc: INTEGER): STATE_OF_DFA is
			-- Successor of source on `input_doc';
			-- void if no successor
		deferred
		end;

feature -- Status setting

	set_transition (source, input_doc, target: INTEGER) is
			-- Set transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end;

feature {NONE} -- Implementation

	start_state: STATE_OF_DFA is
			-- Start_number-th state
			-- (Used for the beginning of the course
			-- through the automaton)
		deferred
		end; 

end -- class DFA
 

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

