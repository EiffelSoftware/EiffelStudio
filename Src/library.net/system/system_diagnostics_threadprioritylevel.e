indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ThreadPriorityLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen lowest: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-2"
		end

	frozen highest: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"2"
		end

	frozen above_normal: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"1"
		end

	frozen below_normal: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-1"
		end

	frozen idle: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"-15"
		end

	frozen normal: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"0"
		end

	frozen time_critical: SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL is
		external
			"IL enum signature :System.Diagnostics.ThreadPriorityLevel use System.Diagnostics.ThreadPriorityLevel"
		alias
			"15"
		end

end -- class SYSTEM_DIAGNOSTICS_THREADPRIORITYLEVEL
