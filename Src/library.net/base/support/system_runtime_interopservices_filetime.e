indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.FILETIME"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME

inherit
	SYSTEM_VALUETYPE

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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME
