indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ThreadPriorityLevel"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	THREADPRIORITYLEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen lowest: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-2"
		end

	frozen highest: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"2"
		end

	frozen above_normal: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"1"
		end

	frozen below_normal: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-1"
		end

	frozen idle: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-15"
		end

	frozen normal: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"0"
		end

	frozen time_critical: THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"15"
		end

end -- class THREADPRIORITYLEVEL
