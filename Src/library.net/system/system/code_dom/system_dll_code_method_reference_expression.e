indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMethodReferenceExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_method_reference_expression_1,
	make_system_dll_code_method_reference_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_method_reference_expression_1 (target_object: SYSTEM_DLL_CODE_EXPRESSION; method_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeMethodReferenceExpression"
		end

	frozen make_system_dll_code_method_reference_expression is
		external
			"IL creator use System.CodeDom.CodeMethodReferenceExpression"
		end

feature -- Access

	frozen get_method_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"get_MethodName"
		end

	frozen get_target_object: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_method_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeMethodReferenceExpression"
		alias
			"set_MethodName"
		end

end -- class SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
