indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogPermissionAccess"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen browse: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"2"
		end

	frozen none: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"0"
		end

	frozen audit: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"10"
		end

	frozen instrument: SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS is
		external
			"IL enum signature :System.Diagnostics.EventLogPermissionAccess use System.Diagnostics.EventLogPermissionAccess"
		alias
			"6"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DLL_EVENT_LOG_PERMISSION_ACCESS
