indexing
	Generator: "Eiffel Emitter 2.5b2"
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
			insert as list_insert,
			index_of as list_index_of,
			prune_i_th as list_prune_i_th,
			remove as list_remove,
			clear as list_clear,
			extend as list_extend,
			has as list_has,
			put_i_th as list_put_i_th,
			get_item as list_get_item,
			copy_to as collection_copy_to,
			get_sync_root as collection_get_sync_root,
			get_is_synchronized as collection_get_Is_synchronized,
			get_is_fixed_size as list_get_is_fixed_size,
			get_is_read_only as list_get_is_read_only,
			get_count as collection_get_count
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as collection_copy_to,
			get_sync_root as collection_get_sync_root,
			get_is_synchronized as collection_get_is_synchronized,
			get_count as collection_get_count
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

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"RemoveAt"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"Clear"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.CollectionBase"
		alias
			"GetEnumerator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.CollectionBase"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.CollectionBase"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen list_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Add"
		end

	frozen get_inner_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Collections.CollectionBase"
		alias
			"get_InnerList"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"Finalize"
		end

	frozen collection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen get_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Collections.CollectionBase"
		alias
			"get_List"
		end

	frozen collection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	on_clear_complete is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"OnClearComplete"
		end

	frozen list_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen collection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen list_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen list_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.RemoveAt"
		end

	on_set (index: INTEGER; oldValue: ANY; newValue: ANY) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnSet"
		end

	frozen list_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.set_Item"
		end

	on_remove_complete (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnRemoveComplete"
		end

	on_set_complete (index: INTEGER; oldValue: ANY; newValue: ANY) is
		external
			"IL signature (System.Int32, System.Object, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnSetComplete"
		end

	frozen list_clear is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Clear"
		end

	on_insert_complete (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnInsertComplete"
		end

	on_validate (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnValidate"
		end

	frozen list_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Insert"
		end

	on_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnInsert"
		end

	frozen list_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Remove"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Collections.CollectionBase"
		alias
			"OnClear"
		end

	frozen list_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen collection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.CollectionBase"
		alias
			"System.Collections.ICollection.get_Count"
		end

	on_remove (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.CollectionBase"
		alias
			"OnRemove"
		end

	frozen list_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen list_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.CollectionBase"
		alias
			"System.Collections.IList.Contains"
		end

end -- class SYSTEM_COLLECTIONS_COLLECTIONBASE
