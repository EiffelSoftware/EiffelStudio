indexing
	description:
		"Strategy that executes a single test from a suite"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class SINGLE_TEST_STRATEGY inherit

	EXECUTION_STRATEGY
		redefine
			actual_context
		end
		
feature -- Status report

	Is_context_needed: BOOLEAN is True
			-- Does strategy need context? (Answer: yes)

	Is_last: BOOLEAN is True
			-- Is current test the last test? (Answer: yes)

	Has_random_generator: BOOLEAN is False
			-- Does current object have access to a random number generator?
			-- (Answer: no)
	 
	is_context_ok: BOOLEAN is
			-- Is context value ok?
		do
			Result := suite.valid_test_index (context.item)
		end

feature -- Cursor movement

	forth is
			-- Select next test.
		do
			is_reset := False
		end

	start is
			-- Select first test.
		do
			reset
			suite.select_test (context.item)
		end

feature {NONE} -- Inapplicable

	seed: INTEGER is
			-- Random seed
		do
		end
	 
	set_seed (s: INTEGER) is
			-- Set seed to `s'.
		do
		end

feature {NONE} -- Implementation

	actual_context: INTEGER_REF
			-- Argument context

end -- class SINGLE_TEST_STRATEGY

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
