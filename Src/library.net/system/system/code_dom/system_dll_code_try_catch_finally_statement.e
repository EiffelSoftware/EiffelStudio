indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTryCatchFinallyStatement"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT

inherit
	SYSTEM_DLL_CODE_STATEMENT

create
	make_system_dll_code_try_catch_finally_statement_2,
	make_system_dll_code_try_catch_finally_statement_1,
	make_system_dll_code_try_catch_finally_statement

feature {NONE} -- Initialization

	frozen make_system_dll_code_try_catch_finally_statement_2 (try_statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]; catch_clauses: NATIVE_ARRAY [SYSTEM_DLL_CODE_CATCH_CLAUSE]; finally_statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement[], System.CodeDom.CodeCatchClause[], System.CodeDom.CodeStatement[]) use System.CodeDom.CodeTryCatchFinallyStatement"
		end

	frozen make_system_dll_code_try_catch_finally_statement_1 (try_statements: NATIVE_ARRAY [SYSTEM_DLL_CODE_STATEMENT]; catch_clauses: NATIVE_ARRAY [SYSTEM_DLL_CODE_CATCH_CLAUSE]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement[], System.CodeDom.CodeCatchClause[]) use System.CodeDom.CodeTryCatchFinallyStatement"
		end

	frozen make_system_dll_code_try_catch_finally_statement is
		external
			"IL creator use System.CodeDom.CodeTryCatchFinallyStatement"
		end

feature -- Access

	frozen get_try_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeTryCatchFinallyStatement"
		alias
			"get_TryStatements"
		end

	frozen get_catch_clauses: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeCatchClauseCollection use System.CodeDom.CodeTryCatchFinallyStatement"
		alias
			"get_CatchClauses"
		end

	frozen get_finally_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeTryCatchFinallyStatement"
		alias
			"get_FinallyStatements"
		end

end -- class SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT
