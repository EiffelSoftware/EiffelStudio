indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeMethodInvokeExpression"

external class
	SYSTEM_CODEDOM_CODEMETHODINVOKEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codemethodinvokeexpression,
	make_codemethodinvokeexpression_1,
	make_codemethodinvokeexpression_2

feature {NONE} -- Initialization

	frozen make_codemethodinvokeexpression is
		external
			"IL creator use System.CodeDom.CodeMethodInvokeExpression"
		end

	frozen make_codemethodinvokeexpression_1 (method: SYSTEM_CODEDOM_CODEMETHODREFERENCEEXPRESSION; parameters: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeMethodReferenceExpression, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeMethodInvokeExpression"
		end

	frozen make_codemethodinvokeexpression_2 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; method_name: STRING; parameters: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeMethodInvokeExpression"
		end

feature -- Access

	frozen get_parameters: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeMethodInvokeExpression"
		alias
			"get_Parameters"
		end

	frozen get_method: SYSTEM_CODEDOM_CODEMETHODREFERENCEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeMethodReferenceExpression use System.CodeDom.CodeMethodInvokeExpression"
		alias
			"get_Method"
		end

feature -- Element Change

	frozen set_method (value: SYSTEM_CODEDOM_CODEMETHODREFERENCEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeMethodReferenceExpression): System.Void use System.CodeDom.CodeMethodInvokeExpression"
		alias
			"set_Method"
		end

end -- class SYSTEM_CODEDOM_CODEMETHODINVOKEEXPRESSION
