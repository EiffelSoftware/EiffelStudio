indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeExpressionStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_EXPRESSION_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_expression_statement,
	make_system_dll_code_expression_statement_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_expression_statement is
		external
			"IL creator use System.CodeDom.CodeExpressionStatement"
		end

	frozen make_system_dll_code_expression_statement_1 (expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeExpressionStatement"
		end

feature -- Access

	frozen get_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeExpressionStatement"
		alias
			"get_Expression"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeExpressionStatement"
		alias
			"set_Expression"
		end

end -- class SYSTEM_DLL_CODE_EXPRESSION_STATEMENT
