indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeVariableDeclarationStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_variable_declaration_statement,
	make_system_dll_code_variable_declaration_statement_4,
	make_system_dll_code_variable_declaration_statement_5,
	make_system_dll_code_variable_declaration_statement_6,
	make_system_dll_code_variable_declaration_statement_3,
	make_system_dll_code_variable_declaration_statement_1,
	make_system_dll_code_variable_declaration_statement_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_variable_declaration_statement is
		external
			"IL creator use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_system_dll_code_variable_declaration_statement_4 (type: SYSTEM_DLL_CODE_TYPE_REFERENCE; name: SYSTEM_STRING; init_expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_system_dll_code_variable_declaration_statement_5 (type: SYSTEM_STRING; name: SYSTEM_STRING; init_expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.String, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_system_dll_code_variable_declaration_statement_6 (type: TYPE; name: SYSTEM_STRING; init_expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.Type, System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_system_dll_code_variable_declaration_statement_3 (type: TYPE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_system_dll_code_variable_declaration_statement_1 (type: SYSTEM_DLL_CODE_TYPE_REFERENCE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String) use System.CodeDom.CodeVariableDeclarationStatement"
		end

	frozen make_system_dll_code_variable_declaration_statement_2 (type: SYSTEM_STRING; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.CodeDom.CodeVariableDeclarationStatement"
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"get_Name"
		end

	frozen get_type_code_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"get_Type"
		end

	frozen get_init_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"get_InitExpression"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"set_Name"
		end

	frozen set_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"set_Type"
		end

	frozen set_init_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeVariableDeclarationStatement"
		alias
			"set_InitExpression"
		end

end -- class SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT
