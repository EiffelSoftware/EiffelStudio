indexing

	description:
		"Deterministic finite automata, implemented as lists";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LINKED_DFA inherit

	DFA
		undefine
			copy, is_equal
		end

	LINKED_AUTOMATON [STATE_OF_DFA]
		rename
			set_final as l_set_final,
			make as link_make
		export
			{ANY} start, after, is_empty, item, first,
					last, forth, back, index,
					islast, go_i_th, finish
		end

create

	make

feature -- Initialization

	make (i: INTEGER) is
			-- Create automaton, enabling 0 to `i' inputs.
		require
			i_positive: i >= 0
		do
			link_make;
			greatest_input := i
		end; 

feature -- Access

	find_successor (source, input_doc: INTEGER): STATE_OF_DFA is
			-- Successor of `source' for `input_doc';
			-- void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		local
			memory: INTEGER
		do
			memory := index;
			go_i_th (source);
			Result := item.successor (input_doc);
			go_i_th (memory)
		ensure then
			same_index: old index = index
		end; 

feature -- Status setting

	set_state is
			-- Create a new state.
		local
			current_state: STATE_OF_DFA
		do
			nb_states := nb_states + 1;
			create current_state.make (greatest_input);
			finish;
			put_right (current_state);
			finish
		ensure then
			current_state_is_last: islast
		end; 

	set_transition (source, input_doc, target: INTEGER) is
		-- Make a transition from `source' to `target'
		-- for `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		local
			memory: INTEGER;
			target_state: STATE_OF_DFA
		do
			memory := index;
			go_i_th (target);
			target_state := item;
			go_i_th (source);
			item.append_transition (input_doc, target_state);
			go_i_th (memory)
		ensure then
			same_index: old index = index
		end;

	set_final (state, f: INTEGER) is
			-- Make `state' a final state for regular expression `f'.
		do
			l_set_final (state, f)
		end 

feature -- Duplication

	lcopy: FIXED_DFA is
			-- Copy of Current in a fixed_dfa
		do
			create Result.make (greatest_input, nb_states);
			from
				start
			until
				after or is_empty
			loop
				Result.add_right (item);
				forth
			end
		end

feature {NONE} -- Implementation

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
			index_unchanged: index = old index
		end 

invariant

	nb_states_right: nb_states = count

end -- class LINKED_DFA


--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

