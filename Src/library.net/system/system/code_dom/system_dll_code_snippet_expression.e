indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeSnippetExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_SNIPPET_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_snippet_expression_1,
	make_system_dll_code_snippet_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_snippet_expression_1 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeSnippetExpression"
		end

	frozen make_system_dll_code_snippet_expression is
		external
			"IL creator use System.CodeDom.CodeSnippetExpression"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeSnippetExpression"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeSnippetExpression"
		alias
			"set_Value"
		end

end -- class SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
