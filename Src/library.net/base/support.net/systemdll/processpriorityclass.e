indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ProcessPriorityClass"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PROCESSPRIORITYCLASS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen real_time: PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"256"
		end

	frozen below_normal: PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"16384"
		end

	frozen idle: PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"64"
		end

	frozen normal: PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"32"
		end

	frozen above_normal: PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"32768"
		end

	frozen high: PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"128"
		end

end -- class PROCESSPRIORITYCLASS
