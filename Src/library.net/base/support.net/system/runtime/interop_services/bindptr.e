indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.BINDPTR"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	BINDPTR

inherit
	VALUE_TYPE

feature -- Access

	frozen lpfuncdesc: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.BINDPTR"
		alias
			"lpfuncdesc"
		end

	frozen lptcomp: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.BINDPTR"
		alias
			"lptcomp"
		end

	frozen lpvardesc: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.BINDPTR"
		alias
			"lpvardesc"
		end

end -- class BINDPTR
