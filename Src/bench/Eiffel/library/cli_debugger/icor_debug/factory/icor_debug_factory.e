indexing
	description: "Create CorDebug instances."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FACTORY

inherit
	CLI_COM

feature {ICOR_EXPORTER} -- Initialization
		
	new_cordebug_pointer_for (a_dbg_version: STRING): POINTER is
			-- Create a new instance of ICorDebug for `a_dbg_version'.
		local
			l_hr: INTEGER
			l_version: UNI_STRING
		do
			initialize_com
			if a_dbg_version = Void then
				create l_version.make ((create {IL_ENVIRONMENT}).default_version)
			else
				create l_version.make (a_dbg_version)
			end		
			l_hr := c_get_cordebug (l_version.item, $Result)	
		end

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

	c_get_cordebug (a_dbg_version: POINTER; a_cor_debug: POINTER): INTEGER is
			-- New instance of ICorDebug
		external
			"C signature (LPWSTR, EIF_POINTER **): EIF_INTEGER use %"cli_debugger.h%""
		alias
			"get_cordebug"
		end

	cpp_new_cordebug_managed_callback (): POINTER is 
			-- create an instance of DebuggerManagedCallback
		external
			"[
				C++ creator DebuggerManagedCallback
				signature () 
				use %"cli_debugger_callback.h%"
				]"
		end

	cpp_new_cordebug_unmanaged_callback (): POINTER is 
			-- create an instance of DebuggerUnmanagedCallback
		external
			"[
				C++ creator DebuggerUnmanagedCallback
				signature () 
				use %"cli_debugger_callback.h%"
				]"
		end		

end -- class ICOR_DEBUG_FACTORY

