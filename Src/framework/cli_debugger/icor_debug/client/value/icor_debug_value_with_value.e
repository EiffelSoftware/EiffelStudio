note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_VALUE_WITH_VALUE

inherit
	ICOR_DEBUG_VALUE

feature {ICOR_EXPORTER} -- Access

	get_value (a_result: POINTER)
			-- GetValue copies the value into the specified buffer
		require
			arg_not_void: a_result /= default_pointer
		deferred
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

end
