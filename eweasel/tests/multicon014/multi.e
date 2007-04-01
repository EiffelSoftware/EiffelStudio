indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI[G->{COMPARABLE rename default_create as default_create2 end, NUMERIC} create default_create, default_create2 end]

create
	default_create

feature -- do compuations

		test: G is
			-- for testing
		do
				-- Abstract creation should not be possible as it is not known which version
				-- of default_create should be taken.
			create Result
		end
end
