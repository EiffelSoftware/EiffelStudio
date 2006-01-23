indexing
	description:
		"Assertion results"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	ASSERTION_RESULT

create

	make_true, make_false, make_exception

feature {NONE} -- Initialization

	make_true is
			-- Create a pass.
		do
			passed := True
		ensure
			pass: passed
		end

	make_false (reason: STRING) is
			-- Create a no pass with `reason'.
		require
			non_empty: reason /= Void and then not reason.is_empty
		do
			failure_reason := reason
		ensure
			no_pass: not passed
			reason_set: failure_reason = reason
			failure_state: is_failure
		end

	make_exception (e: EXCEPTION_INFO) is
			-- Create a no pass with exception `e'.
		require
			exception_info_exists: e /= Void
			complete_info: e.complete
		do
			exception_info := e
			failure_reason := Exception_text
		ensure
			exception_info_set: exception_info = e
			exception_state: is_exception
		end
		
feature -- Access

	failure_reason: STRING
			-- Reason of failure

	exception_info: EXCEPTION_INFO
			-- Information on thrown exception

feature -- Status report

	passed: BOOLEAN
			-- Is result `True'?

	is_failure: BOOLEAN is
			-- Is record in failure state?
		do
			Result := not passed and then failure_reason /= Void and then
				not failure_reason.is_empty and not 
				equal (failure_reason, Exception_text)
		end

	is_exception: BOOLEAN is
			-- Is record in exception state?
		do
			Result := not passed and then exception_info /= Void and then
				exception_info.complete and 
				equal (failure_reason, Exception_text)
		end

feature {NONE} -- Constants

	Exception_text: STRING is "Exception thrown"
			-- Failure reason when exception is thrown
			
invariant

	well_defined_state: passed xor is_failure xor is_exception
	reason_not_empty: failure_reason /= Void implies not failure_reason.is_empty
	exception_info_complete: exception_info /= Void implies 
			exception_info.complete


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




end -- class ASSERTION_RESULT

