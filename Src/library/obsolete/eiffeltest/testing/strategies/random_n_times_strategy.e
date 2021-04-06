note
	description: "Strategy executing all tests in the suite `n' times in random order."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RANDOM_N_TIMES_STRATEGY inherit

	RANDOM_ACCESS_STRATEGY
		redefine
			forth, reset, finish_run
		end

feature -- Cursor movement

	forth
			-- Select next test.
		local
			stop: BOOLEAN
		do
			from until stop loop
				random.forth
				if runs [selected_test] > 0 then stop := True end
			end
			suite.select_test (selected_test)
			tests := tests - 1
			is_reset := False
		end

	reset
			-- Reset strategy.
		local
			i: INTEGER
		do
			Precursor
			if runs = Void or else runs.capacity /= suite.test_count then
				create runs.make_filled (0, 1, suite.test_count)
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

	finish_run
			-- Execute post-run actions.
		local
			i: INTEGER
		do
			Precursor
			i := runs [suite.index]
			runs.put (i - 1, suite.index)
		end

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
