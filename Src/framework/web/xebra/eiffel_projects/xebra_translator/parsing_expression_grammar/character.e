note
	description: "Summary description for {CHARACTER}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER [G]

inherit
	PARSING_EXPRESSION_GRAMMAR [G]

feature -- Access

		parser (s: PIVOT_STRING): G
			-- Parses the string s and generates a result {G}
		do
		end

end
