indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeCatchClauseCollection"

external class
	SYSTEM_CODEDOM_CODECATCHCLAUSECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as ilist_insert,
			index_of as ilist_index_of,
			remove as ilist_remove,
			extend as ilist_extend,
			has as ilist_has,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_COLLECTIONBASE
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end

create
	make_codecatchclausecollection_2,
	make_codecatchclausecollection_1,
	make_codecatchclausecollection

feature {NONE} -- Initialization

	frozen make_codecatchclausecollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODECATCHCLAUSE]) is
		external
			"IL creator signature (System.CodeDom.CodeCatchClause[]) use System.CodeDom.CodeCatchClauseCollection"
		end

	frozen make_codecatchclausecollection_1 (value: SYSTEM_CODEDOM_CODECATCHCLAUSECOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeCatchClauseCollection) use System.CodeDom.CodeCatchClauseCollection"
		end

	frozen make_codecatchclausecollection is
		external
			"IL creator use System.CodeDom.CodeCatchClauseCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODECATCHCLAUSE is
		external
			"IL signature (System.Int32): System.CodeDom.CodeCatchClause use System.CodeDom.CodeCatchClauseCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: SYSTEM_CODEDOM_CODECATCHCLAUSE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeCatchClause): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_code_catch_clause (value: ARRAY [SYSTEM_CODEDOM_CODECATCHCLAUSE]) is
		external
			"IL signature (System.CodeDom.CodeCatchClause[]): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODECATCHCLAUSE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeCatchClause): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODECATCHCLAUSE]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeCatchClause[], System.Int32): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODECATCHCLAUSE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Int32 use System.CodeDom.CodeCatchClauseCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODECATCHCLAUSE) is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Remove"
		end

	frozen has (value: SYSTEM_CODEDOM_CODECATCHCLAUSE): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Boolean use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODECATCHCLAUSECOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeCatchClauseCollection): System.Void use System.CodeDom.CodeCatchClauseCollection"
		alias
			"AddRange"
		end

	frozen extend (value: SYSTEM_CODEDOM_CODECATCHCLAUSE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeCatchClause): System.Int32 use System.CodeDom.CodeCatchClauseCollection"
		alias
			"Add"
		end

end -- class SYSTEM_CODEDOM_CODECATCHCLAUSECOLLECTION
