indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.CollectionBase"

deferred external class
	SYSTEM_COLLECTIONS_COLLECTIONBASE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
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
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.CollectionBase"
		alias
			"GetEnumerator"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"RemoveAt"
		end

	to_string: STRING is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	on_validate (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnValidate"
		end

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	on_remove (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnRemove"
		end

	on_set (index: INTEGER; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnSet"
		end

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.set_Item"
		end

	on_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnInsert"
		end

	on_set_complete (index: INTEGER; old_value: ANY; new_value: ANY) is
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

	on_insert_complete (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnInsertComplete"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Remove"
		end

	frozen get_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.CollectionBase"
		alias
			"get_List"
		end

	on_remove_complete (index: INTEGER; value: ANY) is
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

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Insert"
		end

	frozen ilist_extend (value: ANY): INTEGER is
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

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen get_inner_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Collections.CollectionBase"
		alias
			"get_InnerList"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_COLLECTIONS_COLLECTIONBASE
