indexing

	description:
		"Deterministic finite automata";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FIXED_DFA inherit

	DFA
		undefine
			copy, consistent, is_equal, setup
		end;

	FIX_AUTOMAT [STATE_OF_DFA]
		rename
			make as fixed_make,
			set_final as f_set_final
		export
			{ANY} add_right, item, put, upper, last_position
		end

creation

	make

feature

	make (i, s: INTEGER) is
			-- Make a dfa with 0 to i inputs possibles,
			-- and s states possibles.
		do
			fixed_make (i, s);
			greatest_input := i;
			nb_states := s
		end; -- make

	set_state is
			-- Make a new state.
		local
			current_state: STATE_OF_DFA
		do
			!!current_state.make (greatest_input);
			add_right (current_state)
		end; -- set_state

	set_transition (source, inp_ut, target: INTEGER) is
			-- Set transition from source to target on inp_ut.
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			target_in_automaton: target >= 1 and target <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input
		do
			item (source).append_transition (inp_ut, item (target))
		end; -- set_transition

	find_successor (source, inp_ut: INTEGER): STATE_OF_DFA is
			-- Successor of source on inp_ut;
			-- void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states;
			possible_inp_ut: inp_ut >= 0 and inp_ut <= greatest_input
		do
			Result := item (source).successor (inp_ut)
		end; -- find_successor

	set_final (state, f: INTEGER) is
			-- Set the attribute "final" of state as f.
		do
			f_set_final (state, f)
		end; -- set_final

	trace is
			-- List the states of Current.
		local
			i,j, index: INTEGER;
			value: STATE_OF_DFA
		do
			io.putstring (" FIXED_DFA%N");
			from
				j := 1
			until
				j = upper + 1
			loop
				io.putstring (" State #");
				io.putint (j);
				value := item (j);
				if value.final /= 0 then
					io.putstring (" final state of token_type ");
					io.putint (value.final);
					if value.final_array.count > 1 then
						io.putstring ("%N and also of token_types ");
						from
							i := value.final_array.lower + 1
						until
							i > value.final_array.upper
						loop
							io.putint (value.final_array.item (i));
							io.putstring (" ");
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
						io.putstring (" Input: ");
						io.putint (i);
						io.putstring (" Successor: ");
						from
							index := 0
						until
							index = upper
						loop
							index := index + 1;
							if
								item (index) = value.successor (i)
							then
								io.putint (index)
							end
						end;
						io.new_line
					end;
					i := i + 1
				end;
				j := j + 1;
				io.new_line
			end;
			io.putstring (" End FIXED DFA.%N")
		end -- trace

feature {NONE}

	start_state: STATE_OF_DFA is
			-- Start_number-th state
			-- (used for the beginning of the course
			-- through the automaton)
		do
			Result := item (start_number)
		end -- start_state

end -- class FIXED_DFA
 

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
