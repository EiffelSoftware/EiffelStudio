indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeArgumentReferenceExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_argument_reference_expression_1,
	make_system_dll_code_argument_reference_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_argument_reference_expression_1 (parameter_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeArgumentReferenceExpression"
		end

	frozen make_system_dll_code_argument_reference_expression is
		external
			"IL creator use System.CodeDom.CodeArgumentReferenceExpression"
		end

feature -- Access

	frozen get_parameter_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeArgumentReferenceExpression"
		alias
			"get_ParameterName"
		end

feature -- Element Change

	frozen set_parameter_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeArgumentReferenceExpression"
		alias
			"set_ParameterName"
		end

end -- class SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION
