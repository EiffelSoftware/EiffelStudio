indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ELEMDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ELEMDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen tdesc: SYSTEM_RUNTIME_INTEROPSERVICES_TYPEDESC is
		external
			"IL field signature :System.Runtime.InteropServices.TYPEDESC use System.Runtime.InteropServices.ELEMDESC"
		alias
			"tdesc"
		end

	frozen desc: DESCUNION_IN_SYSTEM_RUNTIME_INTEROPSERVICES_ELEMDESC is
		external
			"IL field signature :System.Runtime.InteropServices.ELEMDESC+DESCUNION use System.Runtime.InteropServices.ELEMDESC"
		alias
			"desc"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ELEMDESC
