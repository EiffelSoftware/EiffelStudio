indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.DllImportAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DLL_IMPORT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_dll_import_attribute

feature {NONE} -- Initialization

	frozen make_dll_import_attribute (dll_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.DllImportAttribute"
		end

feature -- Access

	frozen calling_convention: CALLING_CONVENTION is
		external
			"IL field signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"CallingConvention"
		end

	frozen set_last_error: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"SetLastError"
		end

	frozen char_set: CHAR_SET is
		external
			"IL field signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"CharSet"
		end

	frozen exact_spelling: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"ExactSpelling"
		end

	frozen preserve_sig: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"PreserveSig"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"get_Value"
		end

	frozen entry_point: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"EntryPoint"
		end

end -- class DLL_IMPORT_ATTRIBUTE
