indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeArrayCreateExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_array_create_expression_5,
	make_system_dll_code_array_create_expression_6,
	make_system_dll_code_array_create_expression,
	make_system_dll_code_array_create_expression_1,
	make_system_dll_code_array_create_expression_2,
	make_system_dll_code_array_create_expression_3,
	make_system_dll_code_array_create_expression_8,
	make_system_dll_code_array_create_expression_9,
	make_system_dll_code_array_create_expression_7,
	make_system_dll_code_array_create_expression_4

feature {NONE} -- Initialization

	frozen make_system_dll_code_array_create_expression_5 (create_type: SYSTEM_STRING; size: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_6 (create_type: TYPE; size: INTEGER) is
		external
			"IL creator signature (System.Type, System.Int32) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression is
		external
			"IL creator use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_1 (create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; initializers: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_2 (create_type: SYSTEM_STRING; initializers: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_3 (create_type: TYPE; initializers: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_8 (create_type: SYSTEM_STRING; size: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.String, System.CodeDom.CodeExpression) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_9 (create_type: TYPE; size: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.Type, System.CodeDom.CodeExpression) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_7 (create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; size: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.CodeDom.CodeExpression) use System.CodeDom.CodeArrayCreateExpression"
		end

	frozen make_system_dll_code_array_create_expression_4 (create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; size: INTEGER) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference, System.Int32) use System.CodeDom.CodeArrayCreateExpression"
		end

feature -- Access

	frozen get_size_expression: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_SizeExpression"
		end

	frozen get_initializers: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_Initializers"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_Size"
		end

	frozen get_create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeArrayCreateExpression"
		alias
			"get_CreateType"
		end

feature -- Element Change

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeArrayCreateExpression"
		alias
			"set_Size"
		end

	frozen set_size_expression (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeArrayCreateExpression"
		alias
			"set_SizeExpression"
		end

	frozen set_create_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeArrayCreateExpression"
		alias
			"set_CreateType"
		end

end -- class SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION
