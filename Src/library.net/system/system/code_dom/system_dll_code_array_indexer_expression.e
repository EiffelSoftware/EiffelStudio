indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeArrayIndexerExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_array_indexer_expression,
	make_system_dll_code_array_indexer_expression_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_array_indexer_expression is
		external
			"IL creator use System.CodeDom.CodeArrayIndexerExpression"
		end

	frozen make_system_dll_code_array_indexer_expression_1 (target_object: SYSTEM_DLL_CODE_EXPRESSION; indices: NATIVE_ARRAY [SYSTEM_DLL_CODE_EXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeExpression, System.CodeDom.CodeExpression[]) use System.CodeDom.CodeArrayIndexerExpression"
		end

feature -- Access

	frozen get_indices: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeExpressionCollection use System.CodeDom.CodeArrayIndexerExpression"
		alias
			"get_Indices"
		end

	frozen get_target_object: SYSTEM_DLL_CODE_EXPRESSION is
		external
			"IL signature (): System.CodeDom.CodeExpression use System.CodeDom.CodeArrayIndexerExpression"
		alias
			"get_TargetObject"
		end

feature -- Element Change

	frozen set_target_object (value: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.CodeArrayIndexerExpression"
		alias
			"set_TargetObject"
		end

end -- class SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION
