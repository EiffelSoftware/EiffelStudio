indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ThreadState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_THREADSTATE

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

	frozen unknown: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"7"
		end

	frozen running: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"2"
		end

	frozen terminated: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"4"
		end

	frozen initialized: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"0"
		end

	frozen standby: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"3"
		end

	frozen wait: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"5"
		end

	frozen transition: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"6"
		end

	frozen ready: SYSTEM_DIAGNOSTICS_THREADSTATE is
		external
			"IL enum signature :System.Diagnostics.ThreadState use System.Diagnostics.ThreadState"
		alias
			"1"
		end

end -- class SYSTEM_DIAGNOSTICS_THREADSTATE
