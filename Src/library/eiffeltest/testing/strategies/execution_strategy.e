indexing
	description:
		"Execution strategies for test suites"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EXECUTION_STRATEGY inherit

	ARGUMENT_CONTEXT
		rename
			set_context as original_set
		end

	RANDOMIZABLE

feature -- Status report

	is_context_needed: BOOLEAN is
			-- Does strategy need a context for execution?
		deferred
		end
	 
	is_suite_set: BOOLEAN is
			-- Has test suite callback been set?
		do
			Result := (suite /= Void)
		end
		
	is_ready: BOOLEAN is
	 		-- Is strategy ready for execution?
		do
			Result := is_suite_set and then (not suite.is_empty and
					(is_context_needed implies is_context_set))
		end

	is_context_ok: BOOLEAN is
			-- Is context value ok?
		require
			context_set: is_context_set
		deferred
		end
	
	is_finished: BOOLEAN
			-- Has test run been finished?

	is_last: BOOLEAN is
			-- Is current test the last test?
		require
			ready: is_ready
	 	deferred
		end
	 
	is_reset: BOOLEAN
	 		-- Is strategy reset to start?
	 
	is_test_selected: BOOLEAN
			-- Is a test selected?
	 
	is_enabled: BOOLEAN is
			-- Is selected test enabled?
		require
			ready: is_ready
			test_selected: is_test_selected
		do
			Result := suite.selected_test.is_test_enabled
		end
	 
feature -- Status setting

	set_suite (s: like suite) is
			-- Set test suite callback to `s'.
		require
			suite_exists: s /= Void
		do
			suite := s
		ensure
			suite_set: suite = s
		end
		
	set_context (c: ANY) is
			-- Set context to `c'.
		require
			context_needed: is_context_needed
			context_exists: c /= Void
			suite_set: is_suite_set
		do
			original_set (c)
		ensure
			context_set: context = c
		end

feature -- Cursor movement

	forth is
			-- Select next test.
		require
			ready: is_ready
			context_ok: is_context_ok
			not_finished: not is_finished
		deferred
		ensure
			not_reset: not is_reset
			last_yields_finish: old is_last = is_finished
		end
	 
	start is
	 		-- Select first test.
		require
			ready: is_ready
			context_ok: is_context_ok
		deferred
		ensure
			selected: is_test_selected
			reset: is_reset
		end
		
	 reset is
	 		-- Reset strategy.
		do
			is_reset := True
			is_test_selected := True
			is_finished := False
		ensure
			reset: is_reset
			test_selected: is_test_selected
			not_finished: not is_finished
		end
	 
feature -- Basic operations

	execute is
			-- Run strategy on test suite.
		require
			not_finished: not is_finished
			test_selected: is_test_selected
			enabled: is_enabled
			ready: is_ready
			context_ok: is_context_ok
		do
			suite.selected_test.execute
			finish_run
			if is_finished then is_test_selected := False end
		end
	 
feature {NONE} -- Implementation

	suite: TEST_SUITE
			-- Callback reference to test suite

	finish_run is
			-- Execute post-run actions.
		do
			if is_last then is_finished := True end
		ensure
			last_yields_finish: old is_last = is_finished
		end
	 
invariant

	finished_implies_is_last: is_finished implies is_last
	context_validity_constraint: not is_context_needed implies is_context_ok
	
end -- class EXECUTION_STRATEGY

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
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
--|----------------------------------------------------------------
