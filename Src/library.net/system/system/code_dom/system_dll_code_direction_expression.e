indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeDirectionExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_DIRECTION_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_direction_expression,
	make_system_dll_code_direction_expression_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_direction_expression is
		external
			"IL creator use System.CodeDom.CodeDirectionExpression"
		end

	frozen make_system_dll_code_direction_expression_1 (direction: SYSTEM_DLL_FIELD_DIRECTION; expression: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.FieldDirection, System.CodeDom.CodeExpression) use System.CodeDom.CodeDirectionExpression"
		end

feature -- Access

	frozen get_direction: SYSTEM_DLL_FIELD_DIRECTION is
		external
			"IL signature (): System.CodeDom.FieldDirection use System.CodeDom.CodeDirectionExpression"
		alias
			"get_Direction"
		end

	frozen get_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeDirectionExpression"
		alias
			"get_Expression"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeDirectionExpression"
		alias
			"set_Expression"
		end

	frozen set_direction (value: SYSTEM_DLL_FIELD_DIRECTION) is
		external
			"IL signature (System.CodeDom.FieldDirection): System.Void use System.CodeDom.CodeDirectionExpression"
		alias
			"set_Direction"
		end

end -- class SYSTEM_DLL_CODE_DIRECTION_EXPRESSION
