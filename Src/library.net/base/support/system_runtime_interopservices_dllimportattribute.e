indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.DllImportAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_DLLIMPORTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_dll_import_attribute

feature {NONE} -- Initialization

	frozen make_dll_import_attribute (dllName: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.DllImportAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"get_Value"
		end

	frozen preserve_sig: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"PreserveSig"
		end

	frozen entry_point: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"EntryPoint"
		end

	frozen exact_spelling: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"ExactSpelling"
		end

	frozen calling_convention: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"CallingConvention"
		end

	frozen char_set: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"CharSet"
		end

	frozen set_last_error: BOOLEAN is
		external
			"IL field signature :System.Boolean use System.Runtime.InteropServices.DllImportAttribute"
		alias
			"SetLastError"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_DLLIMPORTATTRIBUTE
