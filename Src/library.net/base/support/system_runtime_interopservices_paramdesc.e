indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.PARAMDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_PARAMDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen lp_var_value: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.PARAMDESC"
		alias
			"lpVarValue"
		end

	frozen w_param_flags: SYSTEM_RUNTIME_INTEROPSERVICES_PARAMFLAG is
		external
			"IL field signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMDESC"
		alias
			"wParamFlags"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_PARAMDESC
