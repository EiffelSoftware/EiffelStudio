indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.VARDESC"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	VARDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen memid: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.VARDESC"
		alias
			"memid"
		end

	frozen lpstr_schema: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.VARDESC"
		alias
			"lpstrSchema"
		end

	frozen w_var_flags: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.VARDESC"
		alias
			"wVarFlags"
		end

	frozen varkind: VAR_ENUM is
		external
			"IL field signature :System.Runtime.InteropServices.VarEnum use System.Runtime.InteropServices.VARDESC"
		alias
			"varkind"
		end

	frozen elemdesc_var: ELEMDESC is
		external
			"IL field signature :System.Runtime.InteropServices.ELEMDESC use System.Runtime.InteropServices.VARDESC"
		alias
			"elemdescVar"
		end

end -- class VARDESC
