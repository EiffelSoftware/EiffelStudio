indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeParameterDeclarationExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_parameter_declaration_expression_3,
	make_system_dll_code_parameter_declaration_expression,
	make_system_dll_code_parameter_declaration_expression_1,
	make_system_dll_code_parameter_declaration_expression_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_parameter_declaration_expression_3 (type: TYPE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.CodeDom.CodeParameterDeclarationExpression"
		end

	frozen make_system_dll_code_parameter_declaration_expression is
		external
			"IL creator use System.CodeDom.CodeParameterDeclarationExpression"
		end

	frozen make_system_dll_code_parameter_declaration_expression_1 (type: SYSTEM_DLL_CODE_TYPE_REFERENCE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.String) use System.CodeDom.CodeParameterDeclarationExpression"
		end

	frozen make_system_dll_code_parameter_declaration_expression_2 (type: SYSTEM_STRING; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.CodeDom.CodeParameterDeclarationExpression"
		end

feature -- Access

	frozen get_direction: SYSTEM_DLL_FIELD_DIRECTION is
		external
			"IL signature (): System.CodeDom.FieldDirection use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_Direction"
		end

	frozen get_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_CustomAttributes"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_Name"
		end

	frozen get_type_code_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_Name"
		end

	frozen set_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_Type"
		end

	frozen set_direction (value: SYSTEM_DLL_FIELD_DIRECTION) is
		external
			"IL signature (System.CodeDom.FieldDirection): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_Direction"
		end

	frozen set_custom_attributes (value: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.CodeParameterDeclarationExpression"
		alias
			"set_CustomAttributes"
		end

end -- class SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
