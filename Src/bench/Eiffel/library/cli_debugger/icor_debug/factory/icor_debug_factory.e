indexing
	description: "Create CorDebug instances."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FACTORY

inherit
	CLI_COM

feature {ICOR_EXPORTER} -- Initialization

	new_cordebug_pointer: POINTER is
			-- Create a new instance of ICOR_DEBUG.
		do
			initialize_com
			Result := c_new_cordebug
		end
		
	new_cordebug: ICOR_DEBUG is
			-- Create a new instance of ICOR_DEBUG.
		local
			p: POINTER
		do
			p := new_cordebug_pointer
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exist: Result /= Void
		end

feature {NONE} -- Externals

	c_new_cordebug: POINTER is
			-- New instance of ICorDebug
		external
			"C use %"cli_debugger.h%""
		alias
			"new_cordebug"
		end

end -- class ICOR_DEBUG_FACTORY

