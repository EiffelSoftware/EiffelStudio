indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeMemberMethod"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_MEMBER_METHOD

inherit
	SYSTEM_DLL_CODE_TYPE_MEMBER

create
	make_system_dll_code_member_method

feature {NONE} -- Initialization

	frozen make_system_dll_code_member_method is
		external
			"IL creator use System.CodeDom.CodeMemberMethod"
		end

feature -- Access

	frozen get_return_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberMethod"
		alias
			"get_ReturnType"
		end

	frozen get_parameters: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeParameterDeclarationExpressionCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_Parameters"
		end

	frozen get_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeStatementCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_Statements"
		end

	frozen get_private_implementation_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeMemberMethod"
		alias
			"get_PrivateImplementationType"
		end

	frozen get_implementation_types: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeTypeReferenceCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_ImplementationTypes"
		end

	frozen get_return_type_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.CodeDom.CodeMemberMethod"
		alias
			"get_ReturnTypeCustomAttributes"
		end

feature -- Element Change

	frozen remove_populate_implementation_types (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"remove_PopulateImplementationTypes"
		end

	frozen remove_populate_parameters (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"remove_PopulateParameters"
		end

	frozen set_private_implementation_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"set_PrivateImplementationType"
		end

	frozen add_populate_statements (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"add_PopulateStatements"
		end

	frozen add_populate_implementation_types (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"add_PopulateImplementationTypes"
		end

	frozen set_return_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"set_ReturnType"
		end

	frozen remove_populate_statements (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"remove_PopulateStatements"
		end

	frozen add_populate_parameters (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.CodeDom.CodeMemberMethod"
		alias
			"add_PopulateParameters"
		end

end -- class SYSTEM_DLL_CODE_MEMBER_METHOD
