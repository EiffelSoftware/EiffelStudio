indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ELEMDESC"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	ELEMDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen tdesc: TYPEDESC is
		external
			"IL field signature :System.Runtime.InteropServices.TYPEDESC use System.Runtime.InteropServices.ELEMDESC"
		alias
			"tdesc"
		end

	frozen desc: DESCUNION_IN_ELEMDESC is
		external
			"IL field signature :System.Runtime.InteropServices.ELEMDESC+DESCUNION use System.Runtime.InteropServices.ELEMDESC"
		alias
			"desc"
		end

end -- class ELEMDESC
