indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.SessionEndReasons"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_SESSION_END_REASONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen logoff: SYSTEM_DLL_SESSION_END_REASONS is
		external
			"IL enum signature :Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndReasons"
		alias
			"1"
		end

	frozen system_shutdown: SYSTEM_DLL_SESSION_END_REASONS is
		external
			"IL enum signature :Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndReasons"
		alias
			"2"
		end

end -- class SYSTEM_DLL_SESSION_END_REASONS
