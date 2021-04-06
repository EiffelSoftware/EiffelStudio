note
	description: "Strategy executing tests in the suite in a specified order"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SEQUENTIAL_EXECUTION_STRATEGY inherit

	EXECUTION_STRATEGY
		redefine
			is_ready, reset, actual_context
		end

feature -- Status report

	Is_context_needed: BOOLEAN = True
			-- Does strategy need context? (Answer: yes)

	is_last: BOOLEAN
			-- Is current test the last test?
		do
			Result := (index = context.count)
		end

	is_ready: BOOLEAN
			-- Is strategy ready for execution?
		do
			Result := Precursor and then not context.is_empty and then
				all_indices_valid
		end

	is_context_ok: BOOLEAN
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
				Result := suite.valid_test_index (context [i])
				i := i + 1
			end
		end

	Has_random_generator: BOOLEAN = False
			-- Does current object have access to a random number generator?
			-- (Answer: no)

feature -- Cursor movement

	forth
			-- Select next test.
		do
			index := index + 1
			suite.select_test (context [index])
			is_reset := False
		end

	start
			-- Select first test.
		do
			reset
			suite.select_test (context [index])
		ensure then
			index_reset: index = 1
		end

	reset
			-- Reset strategy.
		do
			Precursor
			index := 1
		end

feature {NONE} -- Inapplicable

	seed: INTEGER
			-- Random seed
		do
		end

	set_seed (s: INTEGER)
			-- Set seed to `s'.
		do
		end

feature {NONE} -- Implementation

	actual_context: ARRAY [INTEGER]
			-- Argument context

	index: INTEGER
			-- Current index

	all_indices_valid: BOOLEAN
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
				val := context [i]
				if val < min then min := val end
				if val > max then max := val end
				i := i + 1
			end
			Result := min <= max and then (1 <= min and max <= suite.test_count)
		end

invariant

	valid_index_constraint: is_test_selected implies
			(1 <= index and index <= context.count)

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
