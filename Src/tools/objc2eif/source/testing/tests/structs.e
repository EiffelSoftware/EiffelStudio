note
	description: "Summary description for {STRUCTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCTS

inherit
	TESTS_COMMON
		redefine
			run
		end

feature -- Running

	run
			-- Run the tests
		do
			Precursor
			test1
			collect_garbage
		end

feature {NONE} -- Tests

	test1
			--
		local
			r: NS_RECT
			p: NS_POINT
		do
			create r.make
			create p.make
			p.x := 123
			p.y := 456
			r.origin := p
			assert (r.origin.x = 123)
			assert (r.origin.y = 456)
			-- The following does not work:
			-- r.origin.x := 123
			-- assert (r.origin.x = 123)
			-- To make this work we would need to use retain counts for structs as well,
			-- which is a bit harder than with objects.
			-- It was a design choice not to support this for now.
		end

end
