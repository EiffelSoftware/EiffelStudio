indexing
	description: "Create CorDebug instances."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_MANAGED_CALLBACK_FACTORY

inherit
	CLI_COM


feature -- Initialization

	new_cordebug_managed_callback: ICOR_DEBUG_MANAGED_CALLBACK is
			-- Create a new instance of ICOR_DEBUG_MANAGED_CALLBACK.
		local
			p: POINTER
		do
			initialize_com
			p := cpp_new_cordebug_managed_callback
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exist: Result /= Void
		end

feature {NONE} -- Externals


	cpp_new_cordebug_managed_callback (): POINTER is 
			-- create an instance of DebuggerManagedCallback
		external
			"[
				C++ creator DebuggerManagedCallback
				signature () 
				use %"cli_debugger_callback.h%"
				]"
		end

end -- class ICOR_DEBUG_MANAGED_CALLBACK_FACTORY

