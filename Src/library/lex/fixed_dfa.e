indexing

	description:
		"Deterministic finite automata";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FIXED_DFA inherit

	DFA
		undefine
			copy, consistent, is_equal, setup
		end;

	FIXED_AUTOMATON [STATE_OF_DFA]
		rename
			make as fixed_make,
			set_final as f_set_final
		export
			{ANY} add_right, item, put, upper, last_position
		end

create

	make

feature -- Initialization

	make (i, s: INTEGER) is
			-- Make a dfa with 0 to `i' possible inputs
			-- and `s' possible states.
		do
			fixed_make (i, s);
			greatest_input := i;
			nb_states := s
		end; 

feature -- Access

	find_successor (source, input_doc: INTEGER): STATE_OF_DFA is
			-- Successor of source on `input_doc';
			-- void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		do
			Result := item (source).successor (input_doc)
		end;

feature -- Status setting

	set_state is
			-- Make a new state.
		local
			current_state: STATE_OF_DFA
		do
			create current_state.make (greatest_input);
			add_right (current_state)
		end; 

	set_transition (source, input_doc, target: INTEGER) is
			-- Set transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		do
			item (source).append_transition (input_doc, item (target))
		end;

	set_final (state, f: INTEGER) is
			-- Make `state' final for regular expression `f'.
		do
			f_set_final (state, f)
		end; 

feature -- Output

	trace is
			-- Print information about the automaton's states.
		local
			i,j, index: INTEGER;
			value: STATE_OF_DFA
		do
			io.put_string (" FIXED_DFA%N");
			from
				j := 1
			until
				j = upper + 1
			loop
				io.put_string (" State #");
				io.put_integer (j);
				value := item (j);
				if value.final /= 0 then
					io.put_string (" final state of token type ");
					io.put_integer (value.final);
					if value.final_array.count > 1 then
						io.put_string ("%N and also of token types ");
						from
							i := value.final_array.lower + 1
						until
							i > value.final_array.upper
						loop
							io.put_integer (value.final_array.item (i));
							io.put_string (" ");
							i := i + 1
						end
					end
				end;
				io.new_line;
				from
					i := 0
				until
					i = greatest_input + 1
				loop
					if value.successor (i) /= Void then
						io.put_string (" Input: ");
						io.put_integer (i);
						io.put_string (" Successor: ");
						from
							index := 0
						until
							index = upper
						loop
							index := index + 1;
							if
								item (index) = value.successor (i)
							then
								io.put_integer (index)
							end
						end;
						io.new_line
					end;
					i := i + 1
				end;
				j := j + 1;
				io.new_line
			end;
			io.put_string (" End FIXED DFA.%N")
		end; 

feature {NONE} -- Implementation

	start_state: STATE_OF_DFA is
			-- Start_number-th state
			-- (used for the beginning of the course
			-- through the automaton)
		do
			Result := item (start_number)
		end; 

end -- class FIXED_DFA

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

