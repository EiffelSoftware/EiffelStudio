indexing
	description: "Create CorDebug instances."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_UNMANAGED_CALLBACK_FACTORY

inherit
	CLI_COM

feature -- Initialization

	new_cordebug_unmanaged_callback: ICOR_DEBUG_UNMANAGED_CALLBACK is
			-- Create a new instance of ICOR_DEBUG_MUNANAGED_CALLBACK.
		local
			p: POINTER
		do
			initialize_com
			p := cpp_new_cordebug_unmanaged_callback
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Externals

	cpp_new_cordebug_unmanaged_callback (): POINTER is 
			-- create an instance of DebuggerUnmanagedCallback
		external
			"[
				C++ creator DebuggerUnmanagedCallback
				signature () 
				use %"cli_debugger_callback.h%"
				]"
		end

end -- class ICOR_DEBUG_UNMANAGED_CALLBACK_FACTORY

