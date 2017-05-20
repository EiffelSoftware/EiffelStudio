note

	description: "Deterministic finite automata"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FIXED_DFA inherit

	DFA
		undefine
			copy, is_equal
		end;

	FIXED_AUTOMATON [detachable STATE_OF_DFA]
		rename
			make as fixed_make,
			make_filled as fixed_make_filled,
			set_final as f_set_final
		export
			{ANY} add_right, item, put, upper, last_position
		end

create

	make

feature {NONE} -- Initialization

	make (i, s: INTEGER)
			-- Make a dfa with 0 to `i' possible inputs
			-- and `s' possible states.
		do
			fixed_make_filled (Void, i, s)
			greatest_input := i
			nb_states := s
		end

feature -- Access

	find_successor (source, input_doc: INTEGER): detachable STATE_OF_DFA
			-- Successor of source on `input_doc';
			-- void if no successor
		require else
			source_in_automaton: source >= 1 and source <= nb_states
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		do
			if attached item (source) as l_item then
				Result := l_item.successor (input_doc)
			end
		end

feature -- Status setting

	set_state
			-- Make a new state.
		do
			add_right (create {STATE_OF_DFA}.make (greatest_input))
		end

	set_transition (source, input_doc, target: INTEGER)
			-- Set transition from `source' to `target' on `input_doc'.
		require else
			source_in_automaton: source >= 1 and source <= nb_states
			target_in_automaton: target >= 1 and target <= nb_states
			possible_input_doc: input_doc >= 0 and input_doc <= greatest_input
		do
			if attached item (source) as l_item then
				l_item.append_transition (input_doc, item (target))
			end
		end

	set_final (state, f: INTEGER)
			-- Make `state' final for regular expression `f'.
		do
			f_set_final (state, f)
		end

feature -- Output

	trace
			-- Print information about the automaton's states.
		local
			i,j, index: INTEGER
		do
			io.put_string (" FIXED_DFA%N")
			from
				j := 1
			until
				j = upper + 1
			loop
				io.put_string (" State #")
				io.put_integer (j);
				if attached item (j) as l_value then
					if l_value.final /= 0 and attached l_value.final_array as l_array then
						io.put_string (" final state of token type ")
						io.put_integer (l_value.final)
						if l_array.count > 1 then
							io.put_string ("%N and also of token types ")
							from
								i := l_array.lower + 1
							until
								i > l_array.upper
							loop
								io.put_integer (l_array.item (i))
								io.put_string (" ")
								i := i + 1
							end
						end
					end
					io.new_line
					from
						i := 0
					until
						i = greatest_input + 1
					loop
						if l_value.successor (i) /= Void then
							io.put_string (" Input: ")
							io.put_integer (i)
							io.put_string (" Successor: ")
							from
								index := 0
							until
								index = upper
							loop
								index := index + 1
								if
									item (index) = l_value.successor (i)
								then
									io.put_integer (index)
								end
							end
							io.new_line
						end;
						i := i + 1
					end
				end
				j := j + 1
				io.new_line
			end
			io.put_string (" End FIXED DFA.%N")
		end

feature {NONE} -- Implementation

	start_state: detachable STATE_OF_DFA
			-- Start_number-th state
			-- (used for the beginning of the course
			-- through the automaton)
		do
			Result := item (start_number)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class FIXED_DFA
