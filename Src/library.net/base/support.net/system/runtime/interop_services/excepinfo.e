indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.EXCEPINFO"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	EXCEPINFO

inherit
	VALUE_TYPE

feature -- Access

	frozen w_code: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"wCode"
		end

	frozen w_reserved: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"wReserved"
		end

	frozen bstr_description: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"bstrDescription"
		end

	frozen bstr_source: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"bstrSource"
		end

	frozen bstr_help_file: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"bstrHelpFile"
		end

	frozen pfn_deferred_fill_in: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"pfnDeferredFillIn"
		end

	frozen dw_help_context: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"dwHelpContext"
		end

	frozen pv_reserved: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.EXCEPINFO"
		alias
			"pvReserved"
		end

end -- class EXCEPINFO
