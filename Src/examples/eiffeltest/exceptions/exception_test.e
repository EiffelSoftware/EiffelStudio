indexing
	description:
		"Test demonstrating how to assert an exception"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
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

end -- class EXCEPTION_TEST

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
