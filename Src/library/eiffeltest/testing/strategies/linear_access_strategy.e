indexing
	description:
		"Strategy that executes tests in a suite linearly from first to last"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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




end -- class LINEAR_ACCESS_STRATEGY

