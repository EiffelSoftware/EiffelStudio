indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeCastExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_CAST_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_cast_expression_1,
	make_system_dll_code_cast_expression,
	make_system_dll_code_cast_expression_3,
	make_system_dll_code_cast_expression_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_cast_expression_1 (target_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression) use System.CodeDom.CodeCastExpression"
		end

	frozen make_system_dll_code_cast_expression is
		external
			"IL creator use System.CodeDom.CodeCastExpression"
		end

	frozen make_system_dll_code_cast_expression_3 (target_type: TYPE; expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression) use System.CodeDom.CodeCastExpression"
		end

	frozen make_system_dll_code_cast_expression_2 (target_type: SYSTEM_STRING; expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeCastExpression"
		end

feature -- Access

	frozen get_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeCastExpression"
		alias
			"get_Expression"
		end

	frozen get_target_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeCastExpression"
		alias
			"get_TargetType"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeCastExpression"
		alias
			"set_Expression"
		end

	frozen set_target_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeCastExpression"
		alias
			"set_TargetType"
		end

end -- class SYSTEM_DLL_CODE_CAST_EXPRESSION
