note
	description: "Summary description for {CLI_DEBUGGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLI_DEBUGGER

feature -- Status

	is_debugging: BOOLEAN
		deferred
		end

	last_call_success: INTEGER
		deferred
		end

	last_call_succeed: BOOLEAN
		deferred
		end

feature -- Factory		

	icor_debug_factory: ICOR_DEBUG_FACTORY_I
		deferred
		end

feature -- Execution

	create_process (a_command_line: READABLE_STRING_GENERAL; a_working_directory: PATH; a_ns_env: detachable NATIVE_STRING): POINTER
			-- Pointer on the freshly creared ICorDebugProcess
		deferred
		end

	clean_data
		deferred
		end

feature {ICOR_EXPORTER} -- Access

	last_icor_debug_process_handle: POINTER
		deferred
		end

end
