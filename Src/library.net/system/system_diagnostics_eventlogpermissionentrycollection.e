indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogPermissionEntryCollection"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRYCOLLECTION

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
		redefine
			on_remove,
			on_clear,
			on_insert,
			on_set
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
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

	frozen has (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY): BOOLEAN is
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

	frozen extend (value: SYSTEM_DIAGNOSTICS_EVENTLOGPERMISSIONENTRY): INTEGER is
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
