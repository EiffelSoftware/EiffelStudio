indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMethodReturnStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_method_return_statement_1,
	make_system_dll_code_method_return_statement

feature {NONE} -- Initialization

	frozen make_system_dll_code_method_return_statement_1 (expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeMethodReturnStatement"
		end

	frozen make_system_dll_code_method_return_statement is
		external
			"IL creator use System.CodeDom.CodeMethodReturnStatement"
		end

feature -- Access

	frozen get_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeMethodReturnStatement"
		alias
			"get_Expression"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeMethodReturnStatement"
		alias
			"set_Expression"
		end

end -- class SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT
