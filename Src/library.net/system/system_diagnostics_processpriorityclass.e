indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ProcessPriorityClass"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS

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

	frozen real_time: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"256"
		end

	frozen below_normal: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"16384"
		end

	frozen idle: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"64"
		end

	frozen normal: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"32"
		end

	frozen above_normal: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"32768"
		end

	frozen high: SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS is
		external
			"IL enum signature :System.Diagnostics.ProcessPriorityClass use System.Diagnostics.ProcessPriorityClass"
		alias
			"128"
		end

end -- class SYSTEM_DIAGNOSTICS_PROCESSPRIORITYCLASS
