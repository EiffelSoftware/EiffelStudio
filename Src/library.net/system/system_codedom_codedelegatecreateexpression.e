indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeDelegateCreateExpression"

external class
	SYSTEM_CODEDOM_CODEDELEGATECREATEEXPRESSION

inherit
	SYSTEM_CODEDOM_CODEEXPRESSION

create
	make_codedelegatecreateexpression,
	make_codedelegatecreateexpression_1

feature {NONE} -- Initialization

	frozen make_codedelegatecreateexpression is
		external
			"IL creator use System.CodeDom.CodeDelegateCreateExpression"
		end

	frozen make_codedelegatecreateexpression_1 (delegate_type: SYSTEM_CODEDOM_CODETYPEREFERENCE; target_object: SYSTEM_CODEDOM_CODEEXPRESSION; method_name: STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeDelegateCreateExpression"
		end

feature -- Access

	frozen get_delegate_type: SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"get_DelegateType"
		end

	frozen get_method_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"get_MethodName"
		end

	frozen get_target_object: SYSTEM_CODEDOM_CODEEXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_delegate_type (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"set_DelegateType"
		end

	frozen set_target_object (value: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"set_TargetObject"
		end

	frozen set_method_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"set_MethodName"
		end

end -- class SYSTEM_CODEDOM_CODEDELEGATECREATEEXPRESSION
