indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeCatchClauseCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION

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
	make_system_dll_code_catch_clause_collection_1,
	make_system_dll_code_catch_clause_collection_2,
	make_system_dll_code_catch_clause_collection

feature {NONE} -- Initialization

	frozen make_system_dll_code_catch_clause_collection_1 (value: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeCatchClauseCollection) use System.CodeDom.CodeCatchClauseCollection"
		end

	frozen make_system_dll_code_catch_clause_collection_2 (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_CATCH_CLAUSE]) is
		external
			"IL creator signature (System.CodeDom.CodeCatchClause[]) use System.CodeDom.CodeCatchClauseCollection"
		end

	frozen make_system_dll_code_catch_clause_collection is
		external
			"IL creator use System.CodeDom.CodeCatchClauseCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_CODE_CATCH_CLAUSE is
		external
			"IL signature (System.Int32): System.CodeDom.CodeCatchClause use System.CodeDom.CodeCatchClauseCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_CODE_CATCH_CLAUSE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeCatchClause): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_code_catch_clause (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_CATCH_CLAUSE]) is
		external
			"IL signature (System.CodeDom.CodeCatchClause[]): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_DLL_CODE_CATCH_CLAUSE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeCatchClause): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_CODE_CATCH_CLAUSE]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeCatchClause[], System.Int32): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DLL_CODE_CATCH_CLAUSE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Int32 use System.CodeDom.CodeCatchClauseCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_DLL_CODE_CATCH_CLAUSE) is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_CODE_CATCH_CLAUSE): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Boolean use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeCatchClauseCollection): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DLL_CODE_CATCH_CLAUSE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Int32 use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Add"
		end

end -- class SYSTEM_DLL_CODE_CATCH_CLAUSE_COLLECTION
