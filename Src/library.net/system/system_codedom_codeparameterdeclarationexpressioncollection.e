indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeParameterDeclarationExpressionCollection"

external class
	SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
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
	SYSTEM_COLLECTIONS_COLLECTIONBASE
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create
	make_codeparameterdeclarationexpressioncollection,
	make_codeparameterdeclarationexpressioncollection_1,
	make_codeparameterdeclarationexpressioncollection_2

feature {NONE} -- Initialization

	frozen make_codeparameterdeclarationexpressioncollection is
		external
			"IL creator use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		end

	frozen make_codeparameterdeclarationexpressioncollection_1 (value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeParameterDeclarationExpressionCollection) use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		end

	frozen make_codeparameterdeclarationexpressioncollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION]) is
		external
			"IL creator signature (System.CodeDom.CodeParameterDeclarationExpression[]) use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION is
		external
			"IL signature (System.Int32): System.CodeDom.CodeParameterDeclarationExpression use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression[], System.Int32): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Int32 use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Boolean use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpressionCollection): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Int32 use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"Add"
		end

	frozen add_range_array_code_parameter_declaration_expression (value: ARRAY [SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION]) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression[]): System.Void use System.CodeDom.CodeParameterDeclarationExpressionCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION
