--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General Deterministic Finite Automata

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class DFA

inherit

	AUTOMATON

feature

	recognize (l: LINKED_LIST [INTEGER]): INTEGER is
			-- Attribute ``final'' of the state reached in Current after
			-- making transitions from state to state on the
			-- inputs listed in l; 0 if not recognized
		local
			state: STATE_OF_DFA;
			index: INTEGER
		do
			from
				state := start_state;
				l.start
			until
				(l.after or l.empty) or else
					state.successor (l.item) = Void
			loop
				state := state.successor (l.item);
				l.forth
			end;
			if (l.after or l.empty) then
				Result := state.final
			end
		end; -- recognize

	possible_tokens (l: LINKED_LIST [INTEGER]): ARRAY [INTEGER] is
			-- Attribute ``final_array'' of the state reached in Current after
			-- making transitions from state to state on the
			-- inputs listed in l; empty if not recognized
		local
			state: STATE_OF_DFA;
			index: INTEGER
		do
			from
   			state := start_state;
   			l.start
			until
   			(l.after or l.empty) or else state.successor(l.item) = Void
			loop
   			state := state.successor (l.item);
   			l.forth
			end;
			if l.after or l.empty then
   			Result := state.final_array
			else
   			!!Result.make (0, -1)
			end
		end; -- possible_tokens

	set_transition (source, inp_ut, target: INTEGER) is
			-- Set transition from source to target on inp_ut.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input
		deferred
		end; -- set_transition

	find_successor (source, inp_ut: INTEGER): STATE_OF_DFA is
			-- Successor of source on inp_ut;
			-- void if no successor
		deferred
		end -- find_successor

feature {NONE}

	start_state: STATE_OF_DFA is
			-- Start_number-th state
			-- (Used for the beginning of the course
			-- through the automaton)
		deferred
		end -- start_state

end -- class DFA
