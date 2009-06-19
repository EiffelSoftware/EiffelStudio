note
	description: "[
		{PEG_SHARED_LONGEST_MATCH}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_SHARED_LONGEST_MATCH

feature -- Access

	longest_match: PEG_LONGEST_MATCH
			-- Captures the furthest index the parser could get to
		once
			create Result.make
		end

end
