indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.FILETIME"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	FILETIME

inherit
	VALUE_TYPE

feature -- Access

	frozen dw_high_date_time: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.FILETIME"
		alias
			"dwHighDateTime"
		end

	frozen dw_low_date_time: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.FILETIME"
		alias
			"dwLowDateTime"
		end

end -- class FILETIME
