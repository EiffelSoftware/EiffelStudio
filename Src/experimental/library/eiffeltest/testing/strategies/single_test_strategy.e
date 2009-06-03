note
	description:
		"Strategy that executes a single test from a suite"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SINGLE_TEST_STRATEGY inherit

	EXECUTION_STRATEGY
		redefine
			actual_context
		end
		
feature -- Status report

	Is_context_needed: BOOLEAN = True
			-- Does strategy need context? (Answer: yes)

	Is_last: BOOLEAN = True
			-- Is current test the last test? (Answer: yes)

	Has_random_generator: BOOLEAN = False
			-- Does current object have access to a random number generator?
			-- (Answer: no)
	 
	is_context_ok: BOOLEAN
			-- Is context value ok?
		do
			Result := suite.valid_test_index (context.item)
		end

feature -- Cursor movement

	forth
			-- Select next test.
		do
			is_reset := False
		end

	start
			-- Select first test.
		do
			reset
			suite.select_test (context.item)
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

	actual_context: INTEGER_REF;
			-- Argument context

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SINGLE_TEST_STRATEGY

