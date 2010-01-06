indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI[G -> {COMPARABLE rename internal_correct_mismatch as blubb, default_create as default_create2 end, NUMERIC} create default_create end]

create
	default_create

feature -- do compuations

		test: G is
			-- for testing
		do
			create Result
			$COMMENT_LINE_1 Result.foo -- VTMC(1) (does not exist)
			$COMMENT_LINE_2 Result.internal_correct_mismatch -- VTMC(1) (export status)
			$COMMENT_LINE_3 Result.is_equal (Result) -- VTMC(2)
			
		end
end
