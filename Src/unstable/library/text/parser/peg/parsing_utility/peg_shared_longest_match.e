note
	description: "[
		Sharing a PEG_LONGEST_MATCH object.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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
