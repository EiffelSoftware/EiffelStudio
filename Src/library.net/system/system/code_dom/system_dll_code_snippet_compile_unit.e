indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeSnippetCompileUnit"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT

inherit
	SYSTEM_DLL_CODE_COMPILE_UNIT

create
	make_system_dll_code_snippet_compile_unit

feature {NONE} -- Initialization

	frozen make_system_dll_code_snippet_compile_unit (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetCompileUnit"
		end

feature -- Access

	frozen get_line_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA is
		external
			"IL signature (): System.CodeDom.CodeLinePragma use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"get_LinePragma"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_line_pragma (value: SYSTEM_DLL_CODE_LINE_PRAGMA) is
		external
			"IL signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"set_LinePragma"
		end

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetCompileUnit"
		alias
			"set_Value"
		end

end -- class SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT
