indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeAttributeDeclarationCollection"

external class
	SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION

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
	make_codeattributedeclarationcollection_1,
	make_codeattributedeclarationcollection_2,
	make_codeattributedeclarationcollection

feature {NONE} -- Initialization

	frozen make_codeattributedeclarationcollection_1 (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeAttributeDeclarationCollection) use System.CodeDom.CodeAttributeDeclarationCollection"
		end

	frozen make_codeattributedeclarationcollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION]) is
		external
			"IL creator signature (System.CodeDom.CodeAttributeDeclaration[]) use System.CodeDom.CodeAttributeDeclarationCollection"
		end

	frozen make_codeattributedeclarationcollection is
		external
			"IL creator use System.CodeDom.CodeAttributeDeclarationCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION is
		external
			"IL signature (System.Int32): System.CodeDom.CodeAttributeDeclaration use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeAttributeDeclaration): System.Void use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeAttributeDeclaration): System.Void use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"Insert"
		end

	frozen add_range_array_code_attribute_declaration (value: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION]) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclaration[]): System.Void use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"AddRange"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclaration[], System.Int32): System.Void use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclaration): System.Int32 use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclaration): System.Void use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclaration): System.Boolean use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclaration): System.Int32 use System.CodeDom.CodeAttributeDeclarationCollection"
		alias
			"Add"
		end

end -- class SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION
