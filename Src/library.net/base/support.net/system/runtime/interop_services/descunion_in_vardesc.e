indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.VARDESC+DESCUNION"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DESCUNION_IN_VARDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen o_inst: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.VARDESC+DESCUNION"
		alias
			"oInst"
		end

	frozen lpvar_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.VARDESC+DESCUNION"
		alias
			"lpvarValue"
		end

end -- class DESCUNION_IN_VARDESC
