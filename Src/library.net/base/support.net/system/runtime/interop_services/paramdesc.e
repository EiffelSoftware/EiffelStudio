indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.PARAMDESC"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	PARAMDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen lp_var_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.PARAMDESC"
		alias
			"lpVarValue"
		end

	frozen w_param_flags: PARAMFLAG is
		external
			"IL field signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMDESC"
		alias
			"wParamFlags"
		end

end -- class PARAMDESC
