indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeIterationStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ITERATION_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_iteration_statement,
	make_system_dll_code_iteration_statement_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_iteration_statement is
		external
			"IL creator use System.CodeDom.CodeIterationStatement"
		end

	frozen make_system_dll_code_iteration_statement_1 (init_statement: SYSTEM_DLL_CODE_STATEMENT; test_expression: SYSTEM_DLL_CODE_EXPRESSION; increment_statement: SYSTEM_DLL_CODE_STATEMENT; statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement, System.CodeDom.CodeExpression, System.CodeDom.CodeStatement, System.CodeDom.CodeStatement[]) use System.CodeDom.CodeIterationStatement"
		end

feature -- Access

	frozen get_increment_statement: SYSTEM_DLL_CODE_STATEMENT is
		external
			"IL signature (): System.CodeDom.CodeStatement use System.CodeDom.CodeIterationStatement"
		alias
			"get_IncrementStatement"
		end

	frozen get_init_statement: SYSTEM_DLL_CODE_STATEMENT is
		external
			"IL signature (): System.CodeDom.CodeStatement use System.CodeDom.CodeIterationStatement"
		alias
			"get_InitStatement"
		end

	frozen get_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeIterationStatement"
		alias
			"get_Statements"
		end

	frozen get_test_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeIterationStatement"
		alias
			"get_TestExpression"
		end

feature -- Element Change

	frozen set_test_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeIterationStatement"
		alias
			"set_TestExpression"
		end

	frozen set_increment_statement (value: SYSTEM_DLL_CODE_STATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeIterationStatement"
		alias
			"set_IncrementStatement"
		end

	frozen set_init_statement (value: SYSTEM_DLL_CODE_STATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeIterationStatement"
		alias
			"set_InitStatement"
		end

end -- class SYSTEM_DLL_CODE_ITERATION_STATEMENT
