indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.DllImportAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_DLLIMPORTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_dllimportattribute

feature {NONE} -- Initialization

	frozen make_dllimportattribute (dll_name: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.DllImportAttribute"
		end

feature -- Access

	frozen calling_convention: SYSTEM_RUNTIME_INTEROPSERVICES_CALLINGCONVENTION is
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

	frozen char_set: SYSTEM_RUNTIME_INTEROPSERVICES_CHARSET is
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

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"get_Value"
		end

	frozen entry_point: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"EntryPoint"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_DLLIMPORTATTRIBUTE
