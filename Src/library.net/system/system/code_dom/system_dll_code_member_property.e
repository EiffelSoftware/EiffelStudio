indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMemberProperty"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_MEMBER_PROPERTY

inherit
	SYSTEM_DLL_CODE_TYPE_MEMBER

create
	make_system_dll_code_member_property

feature {NONE} -- Initialization

	frozen make_system_dll_code_member_property is
		external
			"IL creator use System.CodeDom.CodeMemberProperty"
		end

feature -- Access

	frozen get_parameters: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeParameterDeclarationExpressionCollection use System.CodeDom.CodeMemberProperty"
		alias
			"get_Parameters"
		end

	frozen get_has_get: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeMemberProperty"
		alias
			"get_HasGet"
		end

	frozen get_has_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeMemberProperty"
		alias
			"get_HasSet"
		end

	frozen get_type_code_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberProperty"
		alias
			"get_Type"
		end

	frozen get_set_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeMemberProperty"
		alias
			"get_SetStatements"
		end

	frozen get_implementation_types: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeReferenceCollection use System.CodeDom.CodeMemberProperty"
		alias
			"get_ImplementationTypes"
		end

	frozen get_private_implementation_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberProperty"
		alias
			"get_PrivateImplementationType"
		end

	frozen get_get_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeMemberProperty"
		alias
			"get_GetStatements"
		end

feature -- Element Change

	frozen set_has_set (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeMemberProperty"
		alias
			"set_HasSet"
		end

	frozen set_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberProperty"
		alias
			"set_Type"
		end

	frozen set_has_get (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.CodeMemberProperty"
		alias
			"set_HasGet"
		end

	frozen set_private_implementation_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberProperty"
		alias
			"set_PrivateImplementationType"
		end

end -- class SYSTEM_DLL_CODE_MEMBER_PROPERTY
