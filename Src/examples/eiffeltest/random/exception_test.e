indexing
	description:
		"Test demonstrating how to assert an exception"

	status:	"See note at end of class"
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

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
