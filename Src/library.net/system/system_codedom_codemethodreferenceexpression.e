indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeMethodReferenceExpression"

external class
	SYSTEM_CODEDOM_CODEMETHODREFERENCEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codemethodreferenceexpression_1,
	make_codemethodreferenceexpression

feature {NONE} -- Initialization

	frozen make_codemethodreferenceexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; method_name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeMethodReferenceExpression"
		end

	frozen make_codemethodreferenceexpression is
		external
			"IL creator use System.CodeDom.CodeMethodReferenceExpression"
		end

feature -- Access

	frozen get_method_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"get_MethodName"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_method_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"set_MethodName"
		end

end -- class SYSTEM_CODEDOM_CODEMETHODREFERENCEEXPRESSION
