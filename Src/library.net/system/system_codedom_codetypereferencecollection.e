indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeReferenceCollection"

external class
	SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION

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
	make_codetypereferencecollection,
	make_codetypereferencecollection_1,
	make_codetypereferencecollection_2

feature {NONE} -- Initialization

	frozen make_codetypereferencecollection is
		external
			"IL creator use System.CodeDom.CodeTypeReferenceCollection"
		end

	frozen make_codetypereferencecollection_1 (value: SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReferenceCollection) use System.CodeDom.CodeTypeReferenceCollection"
		end

	frozen make_codetypereferencecollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODETYPEREFERENCE]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference[]) use System.CodeDom.CodeTypeReferenceCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODETYPEREFERENCE is
		external
			"IL signature (System.Int32): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODETYPEREFERENCE]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeTypeReference[], System.Int32): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"CopyTo"
		end

	frozen add_code_type_reference (value: SYSTEM_CODEDOM_CODETYPEREFERENCE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Int32 use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Add"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODETYPEREFERENCE): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Boolean use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeTypeReferenceCollection): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Add"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODETYPEREFERENCE): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Int32 use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"IndexOf"
		end

	frozen add_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"Add"
		end

	frozen add_range_array_code_type_reference (value: ARRAY [SYSTEM_CODEDOM_CODETYPEREFERENCE]) is
		external
			"IL signature (System.CodeDom.CodeTypeReference[]): System.Void use System.CodeDom.CodeTypeReferenceCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_CODEDOM_CODETYPEREFERENCECOLLECTION
