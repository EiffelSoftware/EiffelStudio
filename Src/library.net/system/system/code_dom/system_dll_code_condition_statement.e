indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeConditionStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_CONDITION_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_condition_statement,
	make_system_dll_code_condition_statement_1,
	make_system_dll_code_condition_statement_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_condition_statement is
		external
			"IL creator use System.CodeDom.CodeConditionStatement"
		end

	frozen make_system_dll_code_condition_statement_1 (condition: SYSTEM_DLL_CODE_EXPRESSION; true_statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeStatement[]) use System.CodeDom.CodeConditionStatement"
		end

	frozen make_system_dll_code_condition_statement_2 (condition: SYSTEM_DLL_CODE_EXPRESSION; true_statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]; false_statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeStatement[], System.CodeDom.CodeStatement[]) use System.CodeDom.CodeConditionStatement"
		end

feature -- Access

	frozen get_condition: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeConditionStatement"
		alias
			"get_Condition"
		end

	frozen get_false_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeConditionStatement"
		alias
			"get_FalseStatements"
		end

	frozen get_true_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeConditionStatement"
		alias
			"get_TrueStatements"
		end

feature -- Element Change

	frozen set_condition (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeConditionStatement"
		alias
			"set_Condition"
		end

end -- class SYSTEM_DLL_CODE_CONDITION_STATEMENT
