indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeNamespaceCollection"

external class
	SYSTEM_CODEDOM_CODENAMESPACECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			extend as system_collections_ilist_add,
			has as system_collections_ilist_contains,
			put_i_th as system_collections_ilist_set_item,
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
	make_codenamespacecollection,
	make_codenamespacecollection_1,
	make_codenamespacecollection_2

feature {NONE} -- Initialization

	frozen make_codenamespacecollection is
		external
			"IL creator use System.CodeDom.CodeNamespaceCollection"
		end

	frozen make_codenamespacecollection_1 (value: SYSTEM_CODEDOM_CODENAMESPACECOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeNamespaceCollection) use System.CodeDom.CodeNamespaceCollection"
		end

	frozen make_codenamespacecollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODENAMESPACE]) is
		external
			"IL creator signature (System.CodeDom.CodeNamespace[]) use System.CodeDom.CodeNamespaceCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODENAMESPACE is
		external
			"IL signature (System.Int32): System.CodeDom.CodeNamespace use System.CodeDom.CodeNamespaceCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeNamespace): System.Void use System.CodeDom.CodeNamespaceCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeNamespace): System.Void use System.CodeDom.CodeNamespaceCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODENAMESPACE]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeNamespace[], System.Int32): System.Void use System.CodeDom.CodeNamespaceCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODENAMESPACE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Int32 use System.CodeDom.CodeNamespaceCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.CodeNamespaceCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODENAMESPACE): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Boolean use System.CodeDom.CodeNamespaceCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODENAMESPACECOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeNamespaceCollection): System.Void use System.CodeDom.CodeNamespaceCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_CODENAMESPACE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Int32 use System.CodeDom.CodeNamespaceCollection"
		alias
			"Add"
		end

	frozen add_range_array_code_namespace (value: ARRAY [SYSTEM_CODEDOM_CODENAMESPACE]) is
		external
			"IL signature (System.CodeDom.CodeNamespace[]): System.Void use System.CodeDom.CodeNamespaceCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_CODEDOM_CODENAMESPACECOLLECTION
