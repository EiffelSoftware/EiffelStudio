indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeFieldReferenceExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_field_reference_expression,
	make_system_dll_code_field_reference_expression_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_field_reference_expression is
		external
			"IL creator use System.CodeDom.CodeFieldReferenceExpression"
		end

	frozen make_system_dll_code_field_reference_expression_1 (target_object: SYSTEM_DLL_CODE_EXPRESSION; field_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodeFieldReferenceExpression"
		end

feature -- Access

	frozen get_field_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"get_FieldName"
		end

	frozen get_target_object: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_field_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeFieldReferenceExpression"
		alias
			"set_FieldName"
		end

end -- class SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
