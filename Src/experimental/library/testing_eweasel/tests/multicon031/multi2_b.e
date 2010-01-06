indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI2[G ->{ANY rename default_create as unused end, NUMERIC rename is_equal as better_name end} create default_create end]

create
	default_create

feature -- do compuations

		test: MULTI[G] is
			-- for testing
		do
		end
end

