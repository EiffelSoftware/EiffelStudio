indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeIterationStatement"

external class
	SYSTEM_CODEDOM_CODEITERATIONSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codeiterationstatement,
	make_codeiterationstatement_1

feature {NONE} -- Initialization

	frozen make_codeiterationstatement is
		external
			"IL creator use System.CodeDom.CodeIterationStatement"
		end

	frozen make_codeiterationstatement_1 (init_statement: SYSTEM_CODEDOM_CODESTATEMENT; test_expression: SYSTEM_CODEDOM_CODEEXPRESSION; increment_statement: SYSTEM_CODEDOM_CODESTATEMENT; statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement, System.CodeDom.CodeExpression, System.CodeDom.CodeStatement, System.CodeDom.CodeStatement[]) use System.CodeDom.CodeIterationStatement"
		end

feature -- Access

	frozen get_increment_statement: SYSTEM_CODEDOM_CODESTATEMENT is
		external
			"IL signature (): System.CodeDom.CodeStatement use System.CodeDom.CodeIterationStatement"
		alias
			"get_IncrementStatement"
		end

	frozen get_init_statement: SYSTEM_CODEDOM_CODESTATEMENT is
		external
			"IL signature (): System.CodeDom.CodeStatement use System.CodeDom.CodeIterationStatement"
		alias
			"get_InitStatement"
		end

	frozen get_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeIterationStatement"
		alias
			"get_Statements"
		end

	frozen get_test_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeIterationStatement"
		alias
			"get_TestExpression"
		end

feature -- Element Change

	frozen set_test_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeIterationStatement"
		alias
			"set_TestExpression"
		end

	frozen set_increment_statement (value: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeIterationStatement"
		alias
			"set_IncrementStatement"
		end

	frozen set_init_statement (value: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.CodeIterationStatement"
		alias
			"set_InitStatement"
		end

end -- class SYSTEM_CODEDOM_CODEITERATIONSTATEMENT
