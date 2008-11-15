indexing

	description:

		"Equality testers between strings that can be polymorphically unicode strings"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_STRING_EQUALITY_TESTER_A [G -> READABLE_STRING_GENERAL]

inherit
	KL_EQUALITY_TESTER_A [G]
		redefine
			test
		end

feature -- Status report

	test (v, u: !G): BOOLEAN is
			-- <Precursor>
		do
			Result := v.same_string (u)
		end

end
