indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.FUNCDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_FUNCDESC

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen funckind: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.FUNCKIND use System.Runtime.InteropServices.FUNCDESC"
		alias
			"funckind"
		end

	frozen lprg_elem_desc_Param: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.FUNCDESC"
		alias
			"lprgelemdescParam"
		end

	frozen invkind: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.INVOKEKIND use System.Runtime.InteropServices.FUNCDESC"
		alias
			"invkind"
		end

	frozen c_params_opt: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.FUNCDESC"
		alias
			"cParamsOpt"
		end

	frozen c_params: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.FUNCDESC"
		alias
			"cParams"
		end

	frozen o_vft: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.FUNCDESC"
		alias
			"oVft"
		end

	frozen lprg_scode: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.FUNCDESC"
		alias
			"lprgscode"
		end

	frozen c_scodes: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.FUNCDESC"
		alias
			"cScodes"
		end

	frozen memid: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.FUNCDESC"
		alias
			"memid"
		end

	frozen w_func_flags: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.FUNCDESC"
		alias
			"wFuncFlags"
		end

	frozen call_conv: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.FUNCDESC"
		alias
			"callconv"
		end

	frozen elem_desc_func: SYSTEM_RUNTIME_INTEROPSERVICES_ELEMDESC is
		external
			"IL field signature :System.Runtime.InteropServices.ELEMDESC use System.Runtime.InteropServices.FUNCDESC"
		alias
			"elemdescFunc"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_FUNCDESC
