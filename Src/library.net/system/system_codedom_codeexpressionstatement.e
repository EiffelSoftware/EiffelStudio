indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeExpressionStatement"

external class
	SYSTEM_CODEDOM_CODEEXPRESSIONSTATEMENT

inherit
	SYSTEM_CODEDOM_CODESTATEMENT

create
	make_codeexpressionstatement,
	make_codeexpressionstatement_1

feature {NONE} -- Initialization

	frozen make_codeexpressionstatement is
		external
			"IL creator use System.CodeDom.CodeExpressionStatement"
		end

	frozen make_codeexpressionstatement_1 (expression: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeExpressionStatement"
		end

feature -- Access

	frozen get_expression: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeExpressionStatement"
		alias
			"get_Expression"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeExpressionStatement"
		alias
			"set_Expression"
		end

end -- class SYSTEM_CODEDOM_CODEEXPRESSIONSTATEMENT
