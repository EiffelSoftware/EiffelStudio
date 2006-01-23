indexing
	description:
		"Records storing the result of a test run"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TEST_RUN_RESULT inherit

	RESULT_STATE_CONSTANTS
	
create

	make_pass, make_failure, make_exception

feature {NONE} -- Initialization

	make_pass is
			-- Create a pass result.
		do
			has_passed := True
			passed_tests := 1
			state := Passed_state
		ensure
			passed_state: has_passed
			pass_count_set: passed_tests = 1
			state_ok: state = Passed_state
		end

	make_failure is
			-- Create a failure result.
		do
			failed_tests := 1
			state := Failure_state
		ensure
			failed_state: not has_passed and not is_exception
			failed_count_set: failed_tests = 1
			state_ok: state = Failure_state
		end
		
	make_exception is
			-- Create an exception.
		do
			is_exception := True
			failed_tests := 1
			exceptions := 1
			state := Exception_state
		ensure
			exception_state: not has_passed and is_exception
			exception_count_set: failed_tests = 1 and exceptions = 1
			state_ok: state = Exception_state
		end

feature -- Access

	passed_tests: INTEGER
			-- Number of passes

	failed_tests: INTEGER
			-- Number of failures

	exceptions: INTEGER
			-- Number of exceptions
			
	state: INTEGER
			-- Result state
			
feature -- Status report

	has_passed: BOOLEAN
			-- Has test passed?

	is_exception: BOOLEAN
			-- Did test throw an exception?

invariant

	consistency_rule: not has_passed or not is_exception
	valid_state: Passed_state <= state and state <= Exception_state

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




end -- class TEST_RUN_RESULT

