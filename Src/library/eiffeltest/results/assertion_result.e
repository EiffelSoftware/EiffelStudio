indexing
	description:
		"Assertion results"

	status:	"See note at end of class"
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


end -- class ASSERTION_RESULT

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
