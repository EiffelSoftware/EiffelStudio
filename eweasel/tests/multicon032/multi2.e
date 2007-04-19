indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI2[G -> NUMERIC rename is_equal as better_name end create default_create end]

create
	default_create

feature -- do compuations

		test: MULTI[G] is
			-- for testing
		local
			l_g: G
			l_any: ANY
		do
			create Result
			l_any := Result.test

			create l_g
			if l_g.better_name (l_g) then
				print ("{MULTI2}.test is_equal was true%N")
			end
		end
end

