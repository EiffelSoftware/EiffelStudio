indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogPermissionEntryCollection"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRYCOLLECTION

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
		redefine
			on_remove,
			on_clear,
			on_insert,
			on_set
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY is
		external
			"IL signature (System.Int32): System.Diagnostics.EventLogPermissionEntry use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY) is
		external
			"IL signature (System.Int32, System.Diagnostics.EventLogPermissionEntry): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_event_log_permission_entry (value: ARRAY [SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY]) is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntry[]): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY) is
		external
			"IL signature (System.Int32, System.Diagnostics.EventLogPermissionEntry): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntry[], System.Int32): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY): INTEGER is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntry): System.Int32 use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY) is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntry): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY): BOOLEAN is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntry): System.Boolean use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRYCOLLECTION) is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntryCollection): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY): INTEGER is
		external
			"IL signature (System.Diagnostics.EventLogPermissionEntry): System.Int32 use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	on_remove (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"OnRemove"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"OnClear"
		end

	on_set (index: INTEGER; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"OnSet"
		end

	on_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Diagnostics.EventLogPermissionEntryCollection"
		alias
			"OnInsert"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRYCOLLECTION
