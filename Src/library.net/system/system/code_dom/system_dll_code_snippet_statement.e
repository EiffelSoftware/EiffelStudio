indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeSnippetStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_SNIPPET_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_snippet_statement,
	make_system_dll_code_snippet_statement_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_snippet_statement is
		external
			"IL creator use System.CodeDom.CodeSnippetStatement"
		end

	frozen make_system_dll_code_snippet_statement_1 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetStatement"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetStatement"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetStatement"
		alias
			"set_Value"
		end

end -- class SYSTEM_DLL_CODE_SNIPPET_STATEMENT
