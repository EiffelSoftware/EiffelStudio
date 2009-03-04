note
	description: "Summary description for {PARSING_EXPRESSION_GRAMMAR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PARSING_EXPRESSION_GRAMMAR [G]

feature -- Access

	parser (s: PIVOT_STRING): G
			-- Parses the string s and generates a result {G}
		deferred
		end

end
