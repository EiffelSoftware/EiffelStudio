note
	description: "[
		{PEG_RANGE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_RANGE

inherit
	PEG_SINGLE_CHARACTER_PARSER

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

	parse (a_string: STRING): PEG_PARSER_RESULT
			-- <Precursor>
		do
			if not a_string.is_empty and then (a_string [1] >= lower and a_string [1] <= upper) then
				create Result.make (a_string.substring (2, a_string.count), True, a_string.substring (2, a_string.count))
				Result.append_result (a_string [1])
			else
				create Result.make (a_string, False, a_string)
			end
		end

	serialize: STRING
			-- <Precursor>
		do
			Result := "[" + lower.out + "-" + upper.out + "]"
		end

end
