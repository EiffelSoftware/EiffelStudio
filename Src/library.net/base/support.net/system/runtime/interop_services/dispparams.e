indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.DISPPARAMS"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DISPPARAMS

inherit
	VALUE_TYPE

feature -- Access

	frozen c_named_args: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.DISPPARAMS"
		alias
			"cNamedArgs"
		end

	frozen rgdispid_named_args: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.DISPPARAMS"
		alias
			"rgdispidNamedArgs"
		end

	frozen c_args: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.DISPPARAMS"
		alias
			"cArgs"
		end

	frozen rgvarg: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.DISPPARAMS"
		alias
			"rgvarg"
		end

end -- class DISPPARAMS
