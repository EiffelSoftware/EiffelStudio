indexing
	description: "Create CorDebug instances."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FACTORY

inherit
	CLI_COM

feature {ICOR_EXPORTER} -- Initialization

-- NOTA jfiat: removed for now, let's keep this commented for now
--	new_cordebug_pointer: POINTER is
--			-- Create a new instance of ICorDebug.
--		do
--			initialize_com
--			Result := c_new_cordebug
--		end
		
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

-- NOTA jfiat: removed for now, let's keep this commented for now		
--	new_cordebug: ICOR_DEBUG is
--			-- Create a new instance of ICOR_DEBUG.
--		local
--			p: POINTER
--		do
--			p := new_cordebug_pointer
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--			end
--		ensure
--			result_exist: Result /= Void
--		end

feature {NONE} -- Externals

-- NOTA jfiat: removed for now, let's keep this commented for now
--	c_new_cordebug: POINTER is
--			-- New instance of ICorDebug
--		external
--			"C use %"cli_debugger.h%""
--		alias
--			"new_cordebug"
--		end

	c_get_cordebug (a_dbg_version: POINTER; a_cor_debug: POINTER): INTEGER is
			-- New instance of ICorDebug
		external
			"C use %"cli_debugger.h%""
		alias
			"get_cordebug"
		end

end -- class ICOR_DEBUG_FACTORY

