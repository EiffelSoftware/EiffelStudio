--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Deterministic finite automata implemented as lists

indexing

	date: "$Date$";
	revision: "$Revision$"

Class LINKED_DFA

inherit

	DFA;

	LINK_AUTOMAT [STATE_OF_DFA]
		rename
			set_final as l_set_final,
			make as link_make
		export
			{ANY} start, after, empty, item, first,
					last, forth, back, index,
					islast, go_i_th, finish
		end

creation

	make

feature

	make (i: INTEGER) is
			-- Create with inputs 0 to i possibles.
		require
			i_positive: i >= 0
		do
			link_make;
			greatest_input := i
		end; -- make

	set_state is
			-- Create a new state.
		local
			current_state: STATE_OF_DFA
		do
			nb_states := nb_states + 1;
			!!current_state.make (greatest_input);
			finish;
			add_right (current_state);
			finish
		ensure then
			current_state_is_last: islast
		end; -- set_state

	set_transition (source, inp_ut, target: INTEGER) is
			-- Set transition from source to target on inp_ut.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input
		local
			memory: INTEGER;
			target_state: STATE_OF_DFA
		do
			memory := index;
			go_i_th (target);
			target_state := item;
			go_i_th (source);
			item.append_transition (inp_ut, target_state);
			go_i_th (memory)
		ensure then
			same_index: old index = index
		end; -- set_transition

	find_successor (source, inp_ut: INTEGER): STATE_OF_DFA is
			-- Successor of source on inp_ut;
			-- void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input
		local
			memory: INTEGER
		do
			memory := index;
			go_i_th (source);
			Result := item.successor (inp_ut);
			go_i_th (memory)
		ensure then
			same_index: old index = index
		end; -- find_successor

	lcopy: FIXED_DFA is
			-- Copy of Current in a fixed_dfa
		do
			!!Result.make (greatest_input, nb_states);
			from
				start
			until
				after or empty
			loop
				Result.add_right (item);
				forth
			end
		end; -- copy

	set_final (state, f: INTEGER) is
			-- Assign f to the attribute "final" of state.
		do
			l_set_final (state, f)
		end -- set_final

feature {NONE}

	start_state: STATE_OF_DFA is
			-- Start_number-th state
			-- (Used for the beginning of the course
			-- through the automaton)
		local
			memory: INTEGER
		do
			memory := index;
			go_i_th (start_number);
			Result := item;
			go_i_th (memory)
		ensure then
			old index = index
		end -- start_state

invariant

	nb_states_right: nb_states = count

end -- class LINKED_DFA
