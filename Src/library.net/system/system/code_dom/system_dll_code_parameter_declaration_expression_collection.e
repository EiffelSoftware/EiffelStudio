indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeParameterDeclarationExpressionCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION

inherit
	COLLECTION_BASE
	ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_dll_code_parameter_declaration_expression_collection_1,
	make_system_dll_code_parameter_declaration_expression_collection,
	make_system_dll_code_parameter_declaration_expression_collection_2

feature {NONE} -- Initialization

	frozen make_system_dll_code_parameter_declaration_expression_collection_1 (value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeParameterDeclarationExpressionCollection) use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		end

	frozen make_system_dll_code_parameter_declaration_expression_collection is
		external
			"IL creator use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		end

	frozen make_system_dll_code_parameter_declaration_expression_collection_2 (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeParameterDeclarationExpression[]) use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION is
		external
			"IL signature (System.Int32): System.CodeDom.CodeParameterDeclarationExpression use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression[], System.Int32): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Int32 use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Boolean use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpressionCollection): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Int32 use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Add"
		end

	frozen add_range_array_code_parameter_declaration_expression (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION]) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression[]): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION
