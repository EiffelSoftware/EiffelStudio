indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.TraceLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_TRACELEVEL

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

	frozen error: SYSTEM_DIAGNOSTICS_TRACELEVEL is
		external
			"IL enum signature :System.Diagnostics.TraceLevel use System.Diagnostics.TraceLevel"
		alias
			"1"
		end

	frozen warning: SYSTEM_DIAGNOSTICS_TRACELEVEL is
		external
			"IL enum signature :System.Diagnostics.TraceLevel use System.Diagnostics.TraceLevel"
		alias
			"2"
		end

	frozen verbose: SYSTEM_DIAGNOSTICS_TRACELEVEL is
		external
			"IL enum signature :System.Diagnostics.TraceLevel use System.Diagnostics.TraceLevel"
		alias
			"4"
		end

	frozen off: SYSTEM_DIAGNOSTICS_TRACELEVEL is
		external
			"IL enum signature :System.Diagnostics.TraceLevel use System.Diagnostics.TraceLevel"
		alias
			"0"
		end

	frozen info: SYSTEM_DIAGNOSTICS_TRACELEVEL is
		external
			"IL enum signature :System.Diagnostics.TraceLevel use System.Diagnostics.TraceLevel"
		alias
			"3"
		end

end -- class SYSTEM_DIAGNOSTICS_TRACELEVEL
