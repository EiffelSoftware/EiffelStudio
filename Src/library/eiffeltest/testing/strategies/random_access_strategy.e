indexing
	description:
		"Strategy executing `n' randomly chosen tests"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class RANDOM_ACCESS_STRATEGY inherit

	EXECUTION_STRATEGY
		redefine
			actual_context, reset
		end

	RANDOM_NUMBER_GENERATOR
	
feature -- Access

	seed: INTEGER is
			-- Random seed
		do
			Result := random.seed
		end
	 
feature -- Status report

	Is_context_needed: BOOLEAN is True
			-- Does strategy need context? (Answer: yes)

	Has_random_generator: BOOLEAN is True
			-- Does current object have access to a random number generator?
			-- (Answer: yes)
	 
	is_last: BOOLEAN is
			-- Is current test the last test?
		do
			Result := (tests = 0)
		end
		
	is_context_ok: BOOLEAN is
			-- Is context value ok?
		do
			Result := context.item > 0
		end

feature -- Status report

	set_seed (s: INTEGER) is
			-- Set seed to `s'.
		do
			random.set_seed (s)
		end

feature -- Cursor movement

	forth is
			-- Select next test.
		do
			random.forth
			suite.select_test (selected_test)
			tests := tests - 1
			is_reset := False
		ensure then
			test_counter_decreased: tests = old tests - 1
		end
	
	start is
			-- Select first test.
		do
			reset
			suite.select_test (selected_test)
		end

	reset is
			-- Reset strategy.
		do
			Precursor
			tests := context.item - 1
		end

feature {NONE} -- Implementation

	actual_context: INTEGER_REF
			-- Argument context

	tests: INTEGER
			-- Number of remaining tests

	selected_test: INTEGER is
			-- Index of selected test
		do
			Result := ((random.double_item * suite.test_count).floor) + 1
		ensure
			valid_test: suite.valid_test_index (Result)
		end

invariant

	test_counter_not_negative: tests >= 0
	
end -- class RANDOM_ACCESS_STRATEGY

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
