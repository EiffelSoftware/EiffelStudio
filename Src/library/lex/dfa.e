note
	description:
		"General deterministic finite automata"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class DFA inherit

	AUTOMATON

feature -- Access

	recognize (l: LINKED_LIST [INTEGER]): INTEGER
			-- `final' value for the state reached after
			-- making transitions from state to state on the
			-- inputs listed in `l'; 0 if not recognized.
		local
			state: ?STATE_OF_DFA;
		do
			from
				state := start_state;
				l.start
			until
				(l.after or l.is_empty) or else
				state = Void or else
				state.successor (l.item) = Void
			loop
				state := state.successor (l.item);
				l.forth
			end;
			if (l.after or l.is_empty) and then state /= Void then
				Result := state.final
			end
		end;

	possible_tokens (l: LINKED_LIST [INTEGER]): ?ARRAY [INTEGER]
			-- Attribute ``final_array'' of the state reached in Current after
			-- making transitions from state to state on the
			-- inputs listed in `l'; empty if not recognized
		local
			state: ?STATE_OF_DFA;
		do
			from
	   			state := start_state;
   				l.start
			until
   				(l.after or l.is_empty) or else
   				state = Void or else
   				state.successor(l.item) = Void
			loop
   				state := state.successor (l.item);
   				l.forth
			end;
			if (l.after or l.is_empty) and then state /= Void then
   				Result := state.final_array
			end
		end;

	find_successor (source, input_doc: INTEGER): ?STATE_OF_DFA
			-- Successor of source on `input_doc';
			-- void if no successor
		deferred
		end;

feature -- Status setting

	set_transition (source, input_doc, target: INTEGER)
			-- Set transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		deferred
		end;

feature {NONE} -- Implementation

	start_state: ?STATE_OF_DFA
			-- Start_number-th state
			-- (Used for the beginning of the course
			-- through the automaton)
		deferred
		end;

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

end
