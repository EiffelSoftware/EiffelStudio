indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeDeclarationCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION

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
	make_system_dll_code_type_declaration_collection_2,
	make_system_dll_code_type_declaration_collection,
	make_system_dll_code_type_declaration_collection_1

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_declaration_collection_2 (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_DECLARATION]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeDeclaration[]) use System.CodeDom.CodeTypeDeclarationCollection"
		end

	frozen make_system_dll_code_type_declaration_collection is
		external
			"IL creator use System.CodeDom.CodeTypeDeclarationCollection"
		end

	frozen make_system_dll_code_type_declaration_collection_1 (value: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeDeclarationCollection) use System.CodeDom.CodeTypeDeclarationCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_CODE_TYPE_DECLARATION is
		external
			"IL signature (System.Int32): System.CodeDom.CodeTypeDeclaration use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range (value: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeTypeDeclarationCollection): System.Void use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_DECLARATION]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration[], System.Int32): System.Void use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DLL_CODE_TYPE_DECLARATION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration): System.Int32 use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_CODE_TYPE_DECLARATION): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration): System.Boolean use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"Contains"
		end

	frozen add_range_array_code_type_declaration (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_TYPE_DECLARATION]) is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration[]): System.Void use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DLL_CODE_TYPE_DECLARATION): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration): System.Int32 use System.CodeDom.CodeTypeDeclarationCollection"
		alias
			"Add"
		end

end -- class SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION
