indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.TYPEDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPEDESC

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen vt: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEDESC"
		alias
			"vt"
		end

	frozen lp_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.TYPEDESC"
		alias
			"lpValue"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPEDESC
