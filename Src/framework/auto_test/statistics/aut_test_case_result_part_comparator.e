indexing
	description:

		"Partial order comparator for test case result"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_TEST_CASE_RESULT_PART_COMPARATOR

inherit

	KL_PART_COMPARATOR [AUT_TEST_CASE_RESULT]

create

	make

feature {NONE} -- Initialization

	make is
			-- Create new comparator.
		do
		end

feature -- Status report

	less_than (u, v: AUT_TEST_CASE_RESULT): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			Result := u.witness.count < v.witness.count
		end

end
