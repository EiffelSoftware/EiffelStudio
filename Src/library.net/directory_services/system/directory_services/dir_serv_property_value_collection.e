indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.PropertyValueCollection"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_PROPERTY_VALUE_COLLECTION

inherit
	COLLECTION_BASE
		redefine
			on_remove_complete,
			on_clear_complete,
			on_insert_complete,
			on_set_complete
		end
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

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.DirectoryServices.PropertyValueCollection"
		alias
			"get_Item"
		end

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.DirectoryServices.PropertyValueCollection"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"set_Value"
		end

	frozen set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_OBJECT]; index: INTEGER) is
		external
			"IL signature (System.Object[], System.Int32): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DirectoryServices.PropertyValueCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.PropertyValueCollection"
		alias
			"Contains"
		end

	frozen add_range (value: DIR_SERV_PROPERTY_VALUE_COLLECTION) is
		external
			"IL signature (System.DirectoryServices.PropertyValueCollection): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DirectoryServices.PropertyValueCollection"
		alias
			"Add"
		end

	frozen add_range_array_object (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	on_set_complete (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"OnSetComplete"
		end

	on_clear_complete is
		external
			"IL signature (): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"OnClearComplete"
		end

	on_remove_complete (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"OnRemoveComplete"
		end

	on_insert_complete (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.PropertyValueCollection"
		alias
			"OnInsertComplete"
		end

end -- class DIR_SERV_PROPERTY_VALUE_COLLECTION
