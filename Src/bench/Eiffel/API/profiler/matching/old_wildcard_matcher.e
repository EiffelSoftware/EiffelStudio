class WILDCARD_MATCHER

inherit
	MATCHER

creation
	make

feature -- Initialization

	make (match_with: STRING) is
			-- Creates a matcher that can recognize strings matching
			-- with `match_with'.
		require
			valid_string: match_with /= Void
		do
			automaton_string := match_with
		end

feature -- Access

	match is
			-- Tries to match the string given by `set_input_string'
			-- and the automaton.
			-- `matched' has the answer.
		local
			automaton_area, input_area: SPECIAL [CHARACTER]
			automaton_index, automaton_count: INTEGER
			input_index, input_count: INTEGER
			next_automaton, automaton_char, input_char: CHARACTER
 		do
			if automaton_string.count > input_string.count then
				matching_strings := false
			else
				matching_strings := true
			end

			if automaton_string.is_equal("*") then
				matching_strings := true
			end

			from
				automaton_area := automaton_string.area
				input_area := input_string.area
				automaton_count := automaton_string.count
				input_count := input_string.count
			until
				automaton_index >= automaton_count or else input_index >= input_count
					or else not matching_strings
			loop
				automaton_char := automaton_area.item(automaton_index)
				input_char := input_area.item(input_index)
				if automaton_index + 1 < automaton_count then
					next_automaton := automaton_area.item(automaton_index + 1)
				else
					input_index := input_count
					automaton_index := automaton_count
				end

				if automaton_char = '*' then
					if next_automaton = Void then
						input_index := input_index + 1
					else
						if next_automaton /= input_char then
							input_index := input_index + 1
						end
						if input_index < input_count and then 
								input_area.item (input_index) = next_automaton then
							automaton_index := automaton_index + 1
						end
					end
				elseif automaton_char = '?' then
					automaton_index := automaton_index + 1
					input_index := input_index + 1
				else
					if automaton_char /= input_char then
						matching_strings := false
					else
						automaton_index := automaton_index + 1
						input_index := input_index + 1
					end
				end
			end
			if input_index >= input_count then
				if automaton_index + 1 = automaton_count then
					if automaton_area.item (automaton_index) /= '*' and automaton_area.item (automaton_index) /= '?' then
						matching_strings := false
					end
				elseif automaton_index < automaton_count then
					matching_strings := false
				end
			end
		end

end -- class WILDCARD_MATCHER
