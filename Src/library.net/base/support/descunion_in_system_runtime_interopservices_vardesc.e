indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.VARDESC+DESCUNION"

frozen expanded external class
	DESCUNION_IN_SYSTEM_RUNTIME_INTEROPSERVICES_VARDESC

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen lpvar_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.VARDESC+DESCUNION"
		alias
			"lpvarValue"
		end

	frozen o_inst: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.VARDESC+DESCUNION"
		alias
			"oInst"
		end

end -- class DESCUNION_IN_SYSTEM_RUNTIME_INTEROPSERVICES_VARDESC
