indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeConditionStatement"

external class
	SYSTEM_CODEDOM_CODECONDITIONSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codeconditionstatement,
	make_codeconditionstatement_2,
	make_codeconditionstatement_1

feature {NONE} -- Initialization

	frozen make_codeconditionstatement is
		external
			"IL creator use System.CodeDom.CodeConditionStatement"
		end

	frozen make_codeconditionstatement_2 (condition: SYSTEM_CODEDOM_CODEEXPRESSION; true_statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]; false_statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeStatement[], System.CodeDom.CodeStatement[]) use System.CodeDom.CodeConditionStatement"
		end

	frozen make_codeconditionstatement_1 (condition: SYSTEM_CODEDOM_CODEEXPRESSION; true_statements: ARRAY [SYSTEM_CODEDOM_CODESTATEMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeStatement[]) use System.CodeDom.CodeConditionStatement"
		end

feature -- Access

	frozen get_condition: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeConditionStatement"
		alias
			"get_Condition"
		end

	frozen get_false_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeConditionStatement"
		alias
			"get_FalseStatements"
		end

	frozen get_true_statements: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeConditionStatement"
		alias
			"get_TrueStatements"
		end

feature -- Element Change

	frozen set_condition (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeConditionStatement"
		alias
			"set_Condition"
		end

end -- class SYSTEM_CODEDOM_CODECONDITIONSTATEMENT
