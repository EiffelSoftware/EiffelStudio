indexing
	description:
		"Records storing the result of a single test run of a test case"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CASE_RESULT_RECORD [G -> ASSERTION_RESULT] inherit

	BASIC_CONTAINER [G]
		rename
			count as assertion_count, valid_index as valid_assertion_index
		undefine
			copy, is_equal
		end
	
	ARRAYED_ADAPTER [G]
		rename
			make as list_make, count as assertion_count, 
			valid_index as valid_assertion_index
		export
			{NONE} all
		end

	COMPARATOR_FACILITY
		undefine
			copy, is_equal
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create record.
		do
			list_make (0)
		end

feature -- Access

	execution_time: TIME_DURATION
			-- Execution time of test
			
	failure_reason (i: INTEGER): STRING is
			-- Failure reason of `i'-th assertion
		require
			valid_index: valid_assertion_index (i)
			not_passed: not is_assertion_pass (i)
		do
			Result := i_th (i).failure_reason
		ensure
			non_empty_reason: Result /= Void and then not Result.empty
		end

	exception_info (i: INTEGER): EXCEPTION_INFO is
			-- Exception info of `i'-th assertion
		require
			valid_index: valid_assertion_index (i)
			is_exception: is_assertion_exception (i)
		do
			Result := i_th (i).exception_info
		ensure
			complete_info: Result /= Void and then Result.complete
		end

feature -- Status report

	passed: BOOLEAN is
			-- Is result a pass?
		require
			not_empty: not empty
		local
			c: COMPARATOR
		do
			create {PASSED_COMPARATOR} c.make (Current)
			Result := comparator.compare_range (c, 1, assertion_count, True)
		end

	is_exception: BOOLEAN is
			-- Was exception thrown in this run?
		require
			not_empty: not empty
		local
			c: COMPARATOR
		do
			create {EXCEPTION_COMPARATOR} c.make (Current)
			Result := comparator.compare_range (c, 1, assertion_count, True)
		end
	
	is_assertion_pass (i: INTEGER): BOOLEAN is
			-- Is `i'-th assertion a pass?
		require
			valid_index: valid_assertion_index (i)
		do
			Result := i_th (i).passed
		end

	is_assertion_failure (i: INTEGER): BOOLEAN is
			-- Is `i'-th assertion a failure?
		require
			valid_index: valid_assertion_index (i)
		do
			Result := i_th (i).is_failure
		end

	is_assertion_exception (i: INTEGER): BOOLEAN is
			-- Is `i'-th assertion an exception?
		require
			valid_index: valid_assertion_index (i)
		do
			Result := i_th (i).is_exception
		end

	insertable (v: G): BOOLEAN is
			-- Can `v' be inserted?
		do
			Result := True
		end

	has_execution_time: BOOLEAN is
			-- Has execution time been recorded?
		do
			Result := execution_time /= Void
		end
		
feature -- Status setting

	set_execution_time (t: like execution_time) is
			-- Set execution time to `t'.
		do
			execution_time := t
		ensure
			time_set: execution_time = t
		end

invariant

	empty_definition: empty = (assertion_count = 0)
		
end -- class CASE_RESULT_RECORD

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
