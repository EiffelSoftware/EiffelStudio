indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTryCatchFinallyStatement"

external class
	SYSTEM_CODEDOM_CODETRYCATCHFINALLYSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codetrycatchfinallystatement,
	make_codetrycatchfinallystatement_2,
	make_codetrycatchfinallystatement_1

feature {NONE} -- Initialization

	frozen make_codetrycatchfinallystatement is
		external
			"IL creator use System.CodeDom.CodeTryCatchFinallyStatement"
		end

	frozen make_codetrycatchfinallystatement_2 (try_statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]; catch_clauses: ARRAY [SYSTEM_CODEDOM_CODECATCHCLAUSE]; finally_statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement[], System.CodeDom.CodeCatchClause[], System.CodeDom.CodeStatement[]) use System.CodeDom.CodeTryCatchFinallyStatement"
		end

	frozen make_codetrycatchfinallystatement_1 (try_statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]; catch_clauses: ARRAY [SYSTEM_CODEDOM_CODECATCHCLAUSE]) is
		external
			"IL creator signature (System.CodeDom.CodeStatement[], System.CodeDom.CodeCatchClause[]) use System.CodeDom.CodeTryCatchFinallyStatement"
		end

feature -- Access

	frozen get_try_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeTryCatchFinallyStatement"
		alias
			"get_TryStatements"
		end

	frozen get_catch_clauses: SYSTEM_CODEDOM_CODECATCHCLAUSECOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeCatchClauseCollection use System.CodeDom.CodeTryCatchFinallyStatement"
		alias
			"get_CatchClauses"
		end

	frozen get_finally_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeTryCatchFinallyStatement"
		alias
			"get_FinallyStatements"
		end

end -- class SYSTEM_CODEDOM_CODETRYCATCHFINALLYSTATEMENT
