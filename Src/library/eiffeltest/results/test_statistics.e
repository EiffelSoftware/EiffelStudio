indexing
	description:
		"Statistical information about test results"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	TEST_STATISTICS

feature -- Access

	pass_percentage: DOUBLE is
			-- Percentage of passed tests
		do
			Result := passed_tests / count * 100
		end

	fail_percentage: DOUBLE is
			-- Percentage of failed tests
		do
			Result := failed_tests / count * 100
		end

feature -- Measurement

	count: INTEGER is
			-- Number of tests
		deferred
		end
	 
	passed_tests: INTEGER is
			-- Number of passed tests
		deferred
		end
	 
	failed_tests: INTEGER is
			-- Number of failed tests
		deferred
		end
	 
end -- class TEST_STATISTICS

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
