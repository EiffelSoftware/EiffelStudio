indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodePrimitiveExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_primitive_expression_1,
	make_system_dll_code_primitive_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_primitive_expression_1 (value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.CodeDom.CodePrimitiveExpression"
		end

	frozen make_system_dll_code_primitive_expression is
		external
			"IL creator use System.CodeDom.CodePrimitiveExpression"
		end

feature -- Access

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.CodeDom.CodePrimitiveExpression"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.CodePrimitiveExpression"
		alias
			"set_Value"
		end

end -- class SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
