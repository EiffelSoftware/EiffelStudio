indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMethodInvokeExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_method_invoke_expression,
	make_system_dll_code_method_invoke_expression_2,
	make_system_dll_code_method_invoke_expression_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_method_invoke_expression is
		external
			"IL creator use System.CodeDom.CodeMethodInvokeExpression"
		end

	frozen make_system_dll_code_method_invoke_expression_2 (target_object: SYSTEM_DLL_CODE_EXPRESSION; method_name: SYSTEM_STRING; parameters: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeMethodInvokeExpression"
		end

	frozen make_system_dll_code_method_invoke_expression_1 (method: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION; parameters: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeMethodReferenceExpression, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeMethodInvokeExpression"
		end

feature -- Access

	frozen get_parameters: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeMethodInvokeExpression"
		alias
			"get_Parameters"
		end

	frozen get_method: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeMethodReferenceExpression use System.CodeDom.CodeMethodInvokeExpression"
		alias
			"get_Method"
		end

feature -- Element Change

	frozen set_method (value: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeMethodReferenceExpression): System.Void use System.CodeDom.CodeMethodInvokeExpression"
		alias
			"set_Method"
		end

end -- class SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
