indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeDelegate"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_DELEGATE

inherit
	SYSTEM_DLL_CODE_TYPE_DECLARATION

create
	make_system_dll_code_type_delegate_1,
	make_system_dll_code_type_delegate

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_delegate_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeDelegate"
		end

	frozen make_system_dll_code_type_delegate is
		external
			"IL creator use System.CodeDom.CodeTypeDelegate"
		end

feature -- Access

	frozen get_return_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeDelegate"
		alias
			"get_ReturnType"
		end

	frozen get_parameters: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeParameterDeclarationExpressionCollection use System.CodeDom.CodeTypeDelegate"
		alias
			"get_Parameters"
		end

feature -- Element Change

	frozen set_return_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeDelegate"
		alias
			"set_ReturnType"
		end

end -- class SYSTEM_DLL_CODE_TYPE_DELEGATE
