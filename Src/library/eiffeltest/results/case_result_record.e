indexing
	description:
		"Records storing the result of a single test run of a test case"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
			non_empty_reason: Result /= Void and then not Result.is_empty
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
			not_empty: not is_empty
		local
			c: COMPARATOR
		do
			create {PASSED_COMPARATOR} c.make (Current)
			Result := comparator.compare_range (c, 1, assertion_count, True)
		end

	is_exception: BOOLEAN is
			-- Was exception thrown in this run?
		require
			not_empty: not is_empty
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

	empty_definition: is_empty = (assertion_count = 0)
		
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




end -- class CASE_RESULT_RECORD

