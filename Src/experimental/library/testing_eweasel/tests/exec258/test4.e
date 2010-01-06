indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST4 [G]

inherit
	TEST3 [INTEGER_16]
		redefine
			expected_type
		end

feature

	expected_type: STRING is "INTEGER_16"
	
end
