indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeBinaryOperatorExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_binary_operator_expression,
	make_system_dll_code_binary_operator_expression_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_binary_operator_expression is
		external
			"IL creator use System.CodeDom.CodeBinaryOperatorExpression"
		end

	frozen make_system_dll_code_binary_operator_expression_1 (left: SYSTEM_DLL_CODE_EXPRESSION; op: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE; right: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeBinaryOperatorType, System.CodeDom.CodeExpression) use System.CodeDom.CodeBinaryOperatorExpression"
		end

feature -- Access

	frozen get_right: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"get_Right"
		end

	frozen get_operator: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE is
		external
			"IL signature (): System.CodeDom.CodeBinaryOperatorType use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"get_Operator"
		end

	frozen get_left: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"get_Left"
		end

feature -- Element Change

	frozen set_right (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"set_Right"
		end

	frozen set_left (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"set_Left"
		end

	frozen set_operator (value: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE) is
		external
			"IL signature (System.CodeDom.CodeBinaryOperatorType): System.Void use System.CodeDom.CodeBinaryOperatorExpression"
		alias
			"set_Operator"
		end

end -- class SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION
