indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeCatchClause"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_CATCH_CLAUSE

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (local_name: SYSTEM_STRING; catch_exception_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeTypeReference, System.CodeDom.CodeStatement[]) use System.CodeDom.CodeCatchClause"
		end

	frozen make_2 (local_name: SYSTEM_STRING; catch_exception_type: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeTypeReference) use System.CodeDom.CodeCatchClause"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.CodeCatchClause"
		end

	frozen make_1 (local_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeCatchClause"
		end

feature -- Access

	frozen get_catch_exception_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeCatchClause"
		alias
			"get_CatchExceptionType"
		end

	frozen get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeCatchClause"
		alias
			"get_LocalName"
		end

	frozen get_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeCatchClause"
		alias
			"get_Statements"
		end

feature -- Element Change

	frozen set_local_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeCatchClause"
		alias
			"set_LocalName"
		end

	frozen set_catch_exception_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeCatchClause"
		alias
			"set_CatchExceptionType"
		end

end -- class SYSTEM_DLL_CODE_CATCH_CLAUSE
