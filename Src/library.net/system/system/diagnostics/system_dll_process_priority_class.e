indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.ProcessPriorityClass"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_PROCESS_PRIORITY_CLASS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen real_time: SYSTEM_DLL_PROCESS_PRIORITY_CLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"256"
		end

	frozen below_normal: SYSTEM_DLL_PROCESS_PRIORITY_CLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"16384"
		end

	frozen idle: SYSTEM_DLL_PROCESS_PRIORITY_CLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"64"
		end

	frozen normal: SYSTEM_DLL_PROCESS_PRIORITY_CLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"32"
		end

	frozen above_normal: SYSTEM_DLL_PROCESS_PRIORITY_CLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"32768"
		end

	frozen high: SYSTEM_DLL_PROCESS_PRIORITY_CLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"128"
		end

end -- class SYSTEM_DLL_PROCESS_PRIORITY_CLASS
