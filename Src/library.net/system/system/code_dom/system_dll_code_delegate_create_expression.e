indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeDelegateCreateExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_delegate_create_expression_1,
	make_system_dll_code_delegate_create_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_delegate_create_expression_1 (delegate_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; target_object: SYSTEM_DLL_CODE_EXPRESSION; method_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeDelegateCreateExpression"
		end

	frozen make_system_dll_code_delegate_create_expression is
		external
			"IL creator use System.CodeDom.CodeDelegateCreateExpression"
		end

feature -- Access

	frozen get_delegate_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"get_DelegateType"
		end

	frozen get_method_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"get_MethodName"
		end

	frozen get_target_object: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_delegate_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"set_DelegateType"
		end

	frozen set_target_object (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"set_TargetObject"
		end

	frozen set_method_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeDelegateCreateExpression"
		alias
			"set_MethodName"
		end

end -- class SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
