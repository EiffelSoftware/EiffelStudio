indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.CollectionBase"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	COLLECTION_BASE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
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

feature -- Access

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.CollectionBase"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.CollectionBase"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.CollectionBase"
		alias
			"GetEnumerator"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"RemoveAt"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.CollectionBase"
		alias
			"ToString"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"Clear"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	on_validate (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnValidate"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	on_remove (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnRemove"
		end

	on_set (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnSet"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.set_Item"
		end

	on_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnInsert"
		end

	on_set_complete (index: INTEGER; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnSetComplete"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"OnClear"
		end

	on_insert_complete (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnInsertComplete"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Remove"
		end

	frozen get_list: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.CollectionBase"
		alias
			"get_List"
		end

	on_remove_complete (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnRemoveComplete"
		end

	on_clear_complete is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"OnClearComplete"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Add"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen get_inner_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Collections.CollectionBase"
		alias
			"get_InnerList"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class COLLECTION_BASE
