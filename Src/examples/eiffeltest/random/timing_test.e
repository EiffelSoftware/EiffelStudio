indexing
	description:
		"Test demonstrating how to assert an execution timing"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TIMING_TEST inherit

	TEST_CASE

create

	make

feature -- Access

	Name: STRING is "Timing test"

feature -- Basic operations

	do_test is
			-- Do test action.
		local
			s: LINKED_STACK [INTEGER]
			i: INTEGER
		do
			create s.make
			from i := 1 until i > Repetitions loop
				s.put (1)
				s.remove
				i := i + 1
			end
			assert (s.empty, "Stack empty")
			assert_timing (15)
		end

feature {NONE} -- Constants

	Repetitions: INTEGER is 100;
			-- Number of repetitions

indexing

	library: "[
			EiffelTest: Library of reusable components for developping unit
			tests.
			]"

	status: "[
			Copyright 2000-2001 Interactive Software Engineering (ISE).
			]"

	license: "[
			EiffelTest may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class TIMING_TEST
