indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.ThreadPriorityLevel"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_THREAD_PRIORITY_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen lowest: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-2"
		end

	frozen highest: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"2"
		end

	frozen above_normal: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"1"
		end

	frozen below_normal: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-1"
		end

	frozen idle: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-15"
		end

	frozen normal: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"0"
		end

	frozen time_critical: SYSTEM_DLL_THREAD_PRIORITY_LEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"15"
		end

end -- class SYSTEM_DLL_THREAD_PRIORITY_LEVEL
