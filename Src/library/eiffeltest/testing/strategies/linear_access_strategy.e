indexing
	description:
		"Strategy that executes tests in a suite linearly from first to last"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LINEAR_ACCESS_STRATEGY inherit

	EXECUTION_STRATEGY

feature -- Status report

	Is_context_needed: BOOLEAN is False
			-- Does strategy need context? (Answer: no)

	Is_context_ok: BOOLEAN is True
			-- Is context value ok? (Answer: yes)

	Has_random_generator: BOOLEAN is False
			-- Does current object have access to a random number generator?
			-- (Answer: no)
	 
	is_last: BOOLEAN is
			-- Is current test the last test?
		do
			Result := (suite.index = suite.test_count)
		end
		
feature -- Cursor movement

	forth is
			-- Select next test.
		do
			suite.select_test (suite.index + 1)
			is_reset := False
		end

	start is
			-- Select first test.
		do
			reset
			suite.select_test (1)
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

end -- class LINEAR_ACCESS_STRATEGY

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
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
