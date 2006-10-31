indexing
	description:
		"Test demonstrating how to assert an exception"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTION_TEST inherit

	TEST_CASE

create

	make

feature -- Access

	Name: STRING is "Exception test"

feature -- Basic operations

	do_test is
			-- Do test action.
		local
			s: LINKED_STACK [INTEGER]
		do
			assert_exception
			create s.make
			s.put (1)
			s.remove
			s.remove
		end

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


end -- class EXCEPTION_TEST

