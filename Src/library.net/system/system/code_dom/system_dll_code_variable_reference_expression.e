indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeVariableReferenceExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_variable_reference_expression_1,
	make_system_dll_code_variable_reference_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_variable_reference_expression_1 (variable_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeVariableReferenceExpression"
		end

	frozen make_system_dll_code_variable_reference_expression is
		external
			"IL creator use System.CodeDom.CodeVariableReferenceExpression"
		end

feature -- Access

	frozen get_variable_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeVariableReferenceExpression"
		alias
			"get_VariableName"
		end

feature -- Element Change

	frozen set_variable_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeVariableReferenceExpression"
		alias
			"set_VariableName"
		end

end -- class SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
