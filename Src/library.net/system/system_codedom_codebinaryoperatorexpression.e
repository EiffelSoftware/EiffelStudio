indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeBinaryOperatorExpression"

external class
	SYSTEM_CODEDOM_CODEBINARYOPERATOREXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codebinaryoperatorexpression,
	make_codebinaryoperatorexpression_1

feature {NONE} -- Initialization

	frozen make_codebinaryoperatorexpression is
		external
			"IL creator use System.CodeDom.CodeBinaryOperatorExpression"
		end

	frozen make_codebinaryoperatorexpression_1 (left: SYSTEM_CODEDOM_CODEEXPRESSION; op: SYSTEM_CODEDOM_CODEBINARYOPERATORTYPE; right: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeBinaryOperatorType, System.CodeDom.CodeExpression) use System.CodeDom.CodeBinaryOperatorExpression"
		end

feature -- Access

	frozen get_right: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"get_Right"
		end

	frozen get_operator: SYSTEM_CODEDOM_CODEBINARYOPERATORTYPE is
		external
			"IL signature (): System.CodeDom.CodeBinaryOperatorType use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"get_Operator"
		end

	frozen get_left: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"get_Left"
		end

feature -- Element Change

	frozen set_right (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"set_Right"
		end

	frozen set_left (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"set_Left"
		end

	frozen set_operator (value: SYSTEM_CODEDOM_CODEBINARYOPERATORTYPE) is
		external
			"IL signature (System.CodeDom.CodeBinaryOperatorType): System.Void use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"set_Operator"
		end

end -- class SYSTEM_CODEDOM_CODEBINARYOPERATOREXPRESSION
