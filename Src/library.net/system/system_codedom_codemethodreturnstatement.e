indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeMethodReturnStatement"

external class
	SYSTEM_CODEDOM_CODEMETHODRETURNSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codemethodreturnstatement_1,
	make_codemethodreturnstatement

feature {NONE} -- Initialization

	frozen make_codemethodreturnstatement_1 (expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeMethodReturnStatement"
		end

	frozen make_codemethodreturnstatement is
		external
			"IL creator use System.CodeDom.CodeMethodReturnStatement"
		end

feature -- Access

	frozen get_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeMethodReturnStatement"
		alias
			"get_Expression"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeMethodReturnStatement"
		alias
			"set_Expression"
		end

end -- class SYSTEM_CODEDOM_CODEMETHODRETURNSTATEMENT
