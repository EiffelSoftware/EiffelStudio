indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.PARAMDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_PARAMDESC

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen w_param_flags: INTEGER_16 is
		external
			"IL field signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMDESC"
		alias
			"wParamFlags"
		end

	frozen lp_var_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.PARAMDESC"
		alias
			"lpVarValue"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_PARAMDESC
