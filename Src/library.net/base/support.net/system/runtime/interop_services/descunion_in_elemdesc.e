indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ELEMDESC+DESCUNION"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DESCUNION_IN_ELEMDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen idldesc: IDLDESC is
		external
			"IL field signature :System.Runtime.InteropServices.IDLDESC use System.Runtime.InteropServices.ELEMDESC+DESCUNION"
		alias
			"idldesc"
		end

	frozen paramdesc: PARAMDESC is
		external
			"IL field signature :System.Runtime.InteropServices.PARAMDESC use System.Runtime.InteropServices.ELEMDESC+DESCUNION"
		alias
			"paramdesc"
		end

end -- class DESCUNION_IN_ELEMDESC
