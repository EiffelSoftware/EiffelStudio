indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	ICOR_DEBUG_VALUE_WITH_VALUE

inherit
	ICOR_DEBUG_VALUE

feature {ICOR_EXPORTER} -- Access

	get_value (a_result: POINTER) is
			-- GetValue copies the value into the specified buffer
		require
			arg_not_void: a_result /= default_pointer
		deferred
		ensure
			success: last_call_success = 0
		end

end -- class ICOR_DEBUG_VALUE

