indexing
	description:
		"Test demonstrating how to assert an execution timing"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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

	Repetitions: INTEGER is 100000;
			-- Number of repetitions

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TIMING_TEST

