indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeObjectCreateExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_object_create_expression,
	make_system_dll_code_object_create_expression_1,
	make_system_dll_code_object_create_expression_2,
	make_system_dll_code_object_create_expression_3

feature {NONE} -- Initialization

	frozen make_system_dll_code_object_create_expression is
		external
			"IL creator use System.CodeDom.CodeObjectCreateExpression"
		end

	frozen make_system_dll_code_object_create_expression_1 (create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; parameters: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeObjectCreateExpression"
		end

	frozen make_system_dll_code_object_create_expression_2 (create_type: SYSTEM_STRING; parameters: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeObjectCreateExpression"
		end

	frozen make_system_dll_code_object_create_expression_3 (create_type: TYPE; parameters: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeObjectCreateExpression"
		end

feature -- Access

	frozen get_parameters: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeObjectCreateExpression"
		alias
			"get_Parameters"
		end

	frozen get_create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeObjectCreateExpression"
		alias
			"get_CreateType"
		end

feature -- Element Change

	frozen set_create_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeObjectCreateExpression"
		alias
			"set_CreateType"
		end

end -- class SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION
