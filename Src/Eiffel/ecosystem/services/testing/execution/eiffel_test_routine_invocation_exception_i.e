indexing
	description: "[
		Represents an exception that occurred during the execution
		of an eiffel test
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_ROUTINE_INVOCATION_EXCEPTION_I

inherit

	EXCEP_CONST

feature -- Access

	code: INTEGER
			-- Exception code
		deferred
		ensure
			valid: valid_code (code)
		end

	recipient_name: !STRING
			-- Name of the feature that triggered the exception
		deferred
		end

	class_name: !STRING
			-- Name of the class in which the exception occurred
		deferred
		end

	tag_name: !STRING
			-- Tag describing the exception
		deferred
		end

	trace: !STRING
			-- Text based representation of the stack trace
		deferred
		end

	trace_depth: INTEGER
			-- Depth of exception trace stored in `exception_trace' (without interpreter frames)
		deferred
		ensure
			not_negative: Result >= 0
		end

end
