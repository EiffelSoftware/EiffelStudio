indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY_COLLECTION

inherit
	COLLECTION_BASE
		redefine
			on_remove,
			on_clear,
			on_insert,
			on_set
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

	frozen get_item (index: INTEGER): DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY is
		external
			"IL signature (System.Int32): System.DirectoryServices.DirectoryServicesPermissionEntry use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY) is
		external
			"IL signature (System.Int32, System.DirectoryServices.DirectoryServicesPermissionEntry): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY) is
		external
			"IL signature (System.Int32, System.DirectoryServices.DirectoryServicesPermissionEntry): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY]; index: INTEGER) is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntry[], System.Int32): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"CopyTo"
		end

	frozen add_range_array_directory_services_permission_entry (value: NATIVE_ARRAY [DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY]) is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntry[]): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"AddRange"
		end

	frozen index_of (value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY): INTEGER is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntry): System.Int32 use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY) is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntry): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"Remove"
		end

	frozen contains (value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY): BOOLEAN is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntry): System.Boolean use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"Contains"
		end

	frozen add_range (value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY_COLLECTION) is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntryCollection): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"AddRange"
		end

	frozen add (value: DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY): INTEGER is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionEntry): System.Int32 use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"OnRemove"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"OnClear"
		end

	on_set (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.DirectoryServices.DirectoryServicesPermissionEntryCollection"
		alias
			"OnInsert"
		end

end -- class DIR_SERV_DIRECTORY_SERVICES_PERMISSION_ENTRY_COLLECTION
