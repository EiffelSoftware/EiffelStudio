note
	description: "[
		Works as {PEG_CHARACTER} but instead of one single character it parses a range of characters.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_RANGE

inherit
	PEG_ABSTRACT_PEG

create
	make_with_range

feature -- Initialization

	make_with_range (a_lower, a_upper: CHARACTER)
			-- `a_lower': lower bound
			-- `a_upper': upper bound
		require
			lower_attached: attached a_lower
			upper_attached: attached a_upper
			lower_is_lower_as_upper: a_lower <= a_upper
		do
			lower := a_lower
			upper := a_upper
		ensure
			lower_set: lower = a_lower
			upper_set: upper = a_upper
		end

feature {NONE} -- Access

	lower, upper: CHARACTER
			-- Boundaries for the allowed characters

feature -- Implementation

	internal_parse (a_string: PEG_PARSER_STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			if not a_string.is_empty and then (a_string [1] >= lower and a_string [1] <= upper) then
				create Result.make (a_string.substring_index (2), True)
				if not ommit then
					Result.append_result (a_string [1])
				end
				Result := build_result (Result)
			else
				create Result.make (a_string, False)
				Result := fix_result (Result)
			end
		end

	default_parse_info: READABLE_STRING_8
			-- <Precursor>	
		do
			Result := "[" + lower.out + "-" + upper.out + "]"
		end

	short_debug_info: READABLE_STRING_8
			-- <Precursor>		
		do
			Result := default_parse_info
		end

feature {PEG_ABSTRACT_PEG} -- Serialization

	internal_serialize (a_already_visited: LIST [PEG_ABSTRACT_PEG]): READABLE_STRING_8
			-- <Precursor>
		do
			if not already_serialized (a_already_visited, Current) then
				Result := "[" + lower.out + "-" + upper.out + "]"
			else
				Result := "recursion"
			end
		end

end
