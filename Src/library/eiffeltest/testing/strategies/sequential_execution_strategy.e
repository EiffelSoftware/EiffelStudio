indexing
	description:
		"Strategy executing tests in the suite in a specified order"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SEQUENTIAL_EXECUTION_STRATEGY inherit

	EXECUTION_STRATEGY
		redefine
			is_ready, reset, actual_context
		end

feature -- Status report

	Is_context_needed: BOOLEAN is True
			-- Does strategy need context? (Answer: yes)

	is_last: BOOLEAN is
			-- Is current test the last test?
		do
			Result := (index = context.count)
		end

	is_ready: BOOLEAN is
			-- Is strategy ready for execution?
		do
			Result := Precursor and then not context.is_empty and then 
				all_indices_valid
		end

	is_context_ok: BOOLEAN is
			-- Is context value ok?
		local
			i: INTEGER
		do
			from 
				i := 1
				Result := True
			until
				not Result or i > context.count
			loop
				Result := suite.valid_test_index (context @ i)
				i := i + 1
			end
		end

	Has_random_generator: BOOLEAN is False
			-- Does current object have access to a random number generator?
			-- (Answer: no)
	 
feature -- Cursor movement

	forth is
			-- Select next test.
		do
			index := index + 1
			suite.select_test (context @ index)
			is_reset := False
		end

	start is
			-- Select first test.
		do
			reset
			suite.select_test (context @ index)
		ensure then
			index_reset: index = 1
		end

	reset is
			-- Reset strategy.
		do
			Precursor
			index := 1
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

	actual_context: ARRAY [INTEGER]
			-- Argument context

	index: INTEGER
			-- Current index
	
	all_indices_valid: BOOLEAN is
			-- Are all test indices in context valid?
		require
			context_not_empty: not context.is_empty
		local
			i: INTEGER
			min: INTEGER
			max: INTEGER
			val: INTEGER
		do
			min := suite.test_count + 1
			from i := 1 until i > context.count loop
				val := context @ i
				if val < min then min := val end
				if val > max then max := val end
				i := i + 1
			end
			Result := min <= max and then (1 <= min and max <= suite.test_count)
		end
	
invariant

	valid_index_constraint: is_test_selected implies
			(1 <= index and index <= context.count)
			
end -- class SEQUENTIAL_EXECUTION_STRATEGY

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
