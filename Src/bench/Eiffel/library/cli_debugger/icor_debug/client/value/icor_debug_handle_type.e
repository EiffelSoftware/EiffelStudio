indexing
	description: "enum ICorDebugHandleType"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_HANDLE_TYPE

feature {ICOR_EXPORTER} -- Enum ICorDebugHandleType

	frozen Handle_strong: INTEGER is
		external
			"C++ macro use %"cli_debugger_utils.h%" "
		alias
			"HANDLE_STRONG"
		end

	frozen Handle_weak_track_resurrection: INTEGER is
		external
			"C++ macro use %"cli_debugger_utils.h%" "
		alias
			"HANDLE_WEAK_TRACK_RESURRECTION"
		end

end
