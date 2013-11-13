note
	description: "Summary description for {EXPANDED_PERSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	EXPANDED_PERSON

inherit
	TEST_PERSON
		redefine
			default_create
		end

create
	default_create, make

feature {NONE}

	default_create
		do
			make ("a", "b", 0)
		end

end
