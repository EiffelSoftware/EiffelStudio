indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeNamespaceImport"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_NAMESPACE_IMPORT

inherit
	SYSTEM_DLL_CODE_OBJECT

create
	make_system_dll_code_namespace_import_1,
	make_system_dll_code_namespace_import

feature {NONE} -- Initialization

	frozen make_system_dll_code_namespace_import_1 (name_space: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeNamespaceImport"
		end

	frozen make_system_dll_code_namespace_import is
		external
			"IL creator use System.CodeDom.CodeNamespaceImport"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeNamespaceImport"
		alias
			"get_LinePragma"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeNamespaceImport"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_DLL_CODE_LINE_PRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeNamespaceImport"
		alias
			"set_LinePragma"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeNamespaceImport"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_DLL_CODE_NAMESPACE_IMPORT
