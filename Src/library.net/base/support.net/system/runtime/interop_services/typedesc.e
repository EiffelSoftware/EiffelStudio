indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TYPEDESC"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	TYPEDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen lp_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.TYPEDESC"
		alias
			"lpValue"
		end

	frozen vt: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEDESC"
		alias
			"vt"
		end

end -- class TYPEDESC
