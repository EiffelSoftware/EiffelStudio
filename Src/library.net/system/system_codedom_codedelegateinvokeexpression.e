indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeDelegateInvokeExpression"

external class
	SYSTEM_CODEDOM_CODEDELEGATEINVOKEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codedelegateinvokeexpression,
	make_codedelegateinvokeexpression_1,
	make_codedelegateinvokeexpression_2

feature {NONE} -- Initialization

	frozen make_codedelegateinvokeexpression is
		external
			"IL creator use System.CodeDom.CodeDelegateInvokeExpression"
		end

	frozen make_codedelegateinvokeexpression_1 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression) use System.CodeDom.CodeDelegateInvokeExpression"
		end

	frozen make_codedelegateinvokeexpression_2 (target_object: SYSTEM_CODEDOM_CODEEXPRESSION; parameters: ARRAY [SYSTEM_CODEDOM_CODEEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeDelegateInvokeExpression"
		end

feature -- Access

	frozen get_parameters: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeDelegateInvokeExpression"
		alias
			"get_Parameters"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeDelegateInvokeExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeDelegateInvokeExpression"
		alias
			"set_TargetObject"
		end

end -- class SYSTEM_CODEDOM_CODEDELEGATEINVOKEEXPRESSION
