indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeTypeMemberCollection"

external class
	SYSTEM_CODEDOM_CODETYPEMEMBERCOLLECTION

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
	make_codetypemembercollection_2,
	make_codetypemembercollection,
	make_codetypemembercollection_1

feature {NONE} -- Initialization

	frozen make_codetypemembercollection_2 (value: ARRAY [SYSTEM_CODEDOM_CODETYPEMEMBER]) is
		external
			"IL creator signature (System.CodeDom.CodeTypeMember[]) use System.CodeDom.CodeTypeMemberCollection"
		end

	frozen make_codetypemembercollection is
		external
			"IL creator use System.CodeDom.CodeTypeMemberCollection"
		end

	frozen make_codetypemembercollection_1 (value: SYSTEM_CODEDOM_CODETYPEMEMBERCOLLECTION) is
		external
			"IL creator signature (System.CodeDom.CodeTypeMemberCollection) use System.CodeDom.CodeTypeMemberCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODETYPEMEMBER is
		external
			"IL signature (System.Int32): System.CodeDom.CodeTypeMember use System.CodeDom.CodeTypeMemberCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_CODETYPEMEMBER) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeMember): System.Void use System.CodeDom.CodeTypeMemberCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_code_type_member (value: ARRAY [SYSTEM_CODEDOM_CODETYPEMEMBER]) is
		external
			"IL signature (System.CodeDom.CodeTypeMember[]): System.Void use System.CodeDom.CodeTypeMemberCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_CODETYPEMEMBER) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeTypeMember): System.Void use System.CodeDom.CodeTypeMemberCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_CODETYPEMEMBER]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.CodeTypeMember[], System.Int32): System.Void use System.CodeDom.CodeTypeMemberCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_CODETYPEMEMBER): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeMember): System.Int32 use System.CodeDom.CodeTypeMemberCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_CODETYPEMEMBER) is
		external
			"IL signature (System.CodeDom.CodeTypeMember): System.Void use System.CodeDom.CodeTypeMemberCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_CODETYPEMEMBER): BOOLEAN is
		external
			"IL signature (System.CodeDom.CodeTypeMember): System.Boolean use System.CodeDom.CodeTypeMemberCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_CODETYPEMEMBERCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeTypeMemberCollection): System.Void use System.CodeDom.CodeTypeMemberCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_CODETYPEMEMBER): INTEGER is
		external
			"IL signature (System.CodeDom.CodeTypeMember): System.Int32 use System.CodeDom.CodeTypeMemberCollection"
		alias
			"Add"
		end

end -- class SYSTEM_CODEDOM_CODETYPEMEMBERCOLLECTION
