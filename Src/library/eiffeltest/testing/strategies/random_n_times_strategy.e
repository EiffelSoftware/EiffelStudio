indexing
	description:
		"Strategy executing all tests in the suite `n' times in random order"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class RANDOM_N_TIMES_STRATEGY inherit

	RANDOM_ACCESS_STRATEGY
		redefine
			forth, reset, finish_run
		end

feature -- Cursor movement

	forth is
			-- Select next test.
		local
			stop: BOOLEAN
		do
			from until stop loop
				random.forth
				if runs @ selected_test > 0 then stop := True end
			end
			suite.select_test (selected_test)
			tests := tests - 1
			is_reset := False
		end

	reset is
			-- Reset strategy.
		local
			i: INTEGER
		do
			Precursor
			if runs = Void or else runs.capacity /= suite.test_count then
				create runs.make (1, suite.test_count)
			end
			from i := 1 until i > runs.capacity loop
				runs.put (context.item, i)
				i := i + 1
			end
			tests := suite.test_count * context.item - 1
		end

feature {NONE} -- Implementation

	runs: ARRAY [INTEGER] 
			-- Number of remaining runs for each test

	finish_run is
			-- Execute post-run actions.
		local
			i: INTEGER
		do
			Precursor
			i := runs @ suite.index
			runs.put (i - 1, suite.index)
		end

end -- class RANDOM_N_TIMES_STRATEGY

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
