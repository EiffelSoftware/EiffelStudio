indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeCatchClause"

external class
	SYSTEM_CODEDOM_CODECATCHCLAUSE

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (local_name: STRING; catch_exception_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeTypeReference, System.CodeDom.CodeStatement[]) use System.CodeDom.CodeCatchClause"
		end

	frozen make_2 (local_name: STRING; catch_exception_type: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeTypeReference) use System.CodeDom.CodeCatchClause"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.CodeCatchClause"
		end

	frozen make_1 (local_name: STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeCatchClause"
		end

feature -- Access

	frozen get_catch_exception_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeCatchClause"
		alias
			"get_CatchExceptionType"
		end

	frozen get_local_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeCatchClause"
		alias
			"get_LocalName"
		end

	frozen get_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeCatchClause"
		alias
			"get_Statements"
		end

feature -- Element Change

	frozen set_local_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeCatchClause"
		alias
			"set_LocalName"
		end

	frozen set_catch_exception_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeCatchClause"
		alias
			"set_CatchExceptionType"
		end

end -- class SYSTEM_CODEDOM_CODECATCHCLAUSE
