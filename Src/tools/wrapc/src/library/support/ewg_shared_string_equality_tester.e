note

	description:

		"Shared equality testers between strings that can be polymorphically unicode strings"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


-- Borrowed from GOBO CVS, when GOBO 3.4 comes out, remove this class
class EWG_SHARED_STRING_EQUALITY_TESTER

feature -- Access

	string_equality_tester: EWG_STRING_EQUALITY_TESTER
			-- String equality tester
		once
			create Result
		ensure
			string_equality_tester_not_void: Result /= Void
		end

end
