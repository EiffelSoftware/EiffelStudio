indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodePropertyReferenceExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_property_reference_expression,
	make_system_dll_code_property_reference_expression_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_property_reference_expression is
		external
			"IL creator use System.CodeDom.CodePropertyReferenceExpression"
		end

	frozen make_system_dll_code_property_reference_expression_1 (target_object: SYSTEM_DLL_CODE_EXPRESSION; property_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.String) use System.CodeDom.CodePropertyReferenceExpression"
		end

feature -- Access

	frozen get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"get_PropertyName"
		end

	frozen get_target_object: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"set_TargetObject"
		end

	frozen set_property_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodePropertyReferenceExpression"
		alias
			"set_PropertyName"
		end

end -- class SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
