indexing
	description:
		"Strategy executing `n' randomly chosen tests"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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




end -- class RANDOM_ACCESS_STRATEGY

