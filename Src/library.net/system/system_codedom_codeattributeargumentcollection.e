indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeAttributeArgumentCollection"

external class
	SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENTCOLLECTION

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
	make_codeattributeargumentcollection,
	make_codeattributeargumentcollection_1,
	make_codeattributeargumentcollection_2

feature {NONE} -- Initialization

	frozen make_codeattributeargumentcollection is
		external
			"IL creator use System.CodeDom.CodeAttributeArgumentCollection"
		end

	frozen make_codeattributeargumentcollection_1 (value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENTCOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeAttributeArgumentCollection) use System.CodeDom.CodeAttributeArgumentCollection"
		end

	frozen make_codeattributeargumentcollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT]) is
		external
			"IL creator signature (System.CodeDom.CodeAttributeArgument[]) use System.CodeDom.CodeAttributeArgumentCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT is
		external
			"IL signature (System.Int32): System.CodeDom.CodeAttributeArgument use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeAttributeArgument): System.Void use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_code_attribute_argument (value: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT]) is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument[]): System.Void use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeAttributeArgument): System.Void use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument[], System.Int32): System.Void use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT): INTEGER is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument): System.Int32 use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT) is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument): System.Void use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument): System.Boolean use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENTCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeArgumentCollection): System.Void use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT): INTEGER is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument): System.Int32 use System.CodeDom.CodeAttributeArgumentCollection"
		alias
			"Add"
		end

end -- class SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENTCOLLECTION
