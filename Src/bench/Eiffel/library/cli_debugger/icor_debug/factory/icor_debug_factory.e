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

feature {NONE} -- Externals

	c_get_cordebug (a_dbg_version: POINTER; a_cor_debug: POINTER): INTEGER is
			-- New instance of ICorDebug
		external
			"C signature (LPWSTR, EIF_POINTER **): EIF_INTEGER use %"cli_debugger.h%""
		alias
			"get_cordebug"
		end

end -- class ICOR_DEBUG_FACTORY

