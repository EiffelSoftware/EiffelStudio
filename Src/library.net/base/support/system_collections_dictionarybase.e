indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.DictionaryBase"

deferred external class
	SYSTEM_COLLECTIONS_DICTIONARYBASE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as get_enumerable_enumerator,
			remove as dictionary_remove,
			extend as dictionary_extend,
			has as dictionary_has,
			put_i_th as dictionary_put_i_th,
			get_item as dictionary_get_item,
			get_values as dictionary_get_values,
			get_sync_root as collection_get_sync_root,
			get_keys as dictionary_get_keys,
			get_is_synchronized as collection_get_is_synchronized,
			get_is_fixed_size as dictionary_get_is_fixed_size,
			get_is_read_only as dictionary_get_is_read_only
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as get_enumerable_enumerator,
			get_sync_root as collection_get_sync_root,
			get_is_synchronized as collection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as get_enumerable_enumerator
		end

feature -- Access

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.DictionaryBase"
		alias
			"get_Count"
		end

feature -- Basic Operations

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.DictionaryBase"
		alias
			"CopyTo"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"Clear"
		end

	frozen get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.DictionaryBase"
		alias
			"GetEnumerator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.DictionaryBase"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.DictionaryBase"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.DictionaryBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	on_get (key: ANY; current_value: ANY): ANY is
		external
			"IL signature (System.Object, System.Object): System.Object use System.Collections.DictionaryBase"
		alias
			"OnGet"
		end

	frozen dictionary_has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Contains"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"Finalize"
		end

	frozen get_inner_hashtable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use System.Collections.DictionaryBase"
		alias
			"get_InnerHashtable"
		end

	frozen dictionary_put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen collection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.DictionaryBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen dictionary_extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen collection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	on_clear_complete is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"OnClearComplete"
		end

	on_set_complete (key: ANY; oldValue: ANY; newValue: ANY) is
		external
			"IL signature (System.Object, System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnSetComplete"
		end

	on_remove_complete (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnRemoveComplete"
		end

	on_set (key: ANY; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Object, System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnSet"
		end

	frozen dictionary_get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Keys"
		end

	frozen get_enumerable_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.DictionaryBase"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen get_dictionary: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Collections.DictionaryBase"
		alias
			"get_Dictionary"
		end

	frozen dictionary_get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Item"
		end

	on_insert_complete (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnInsertComplete"
		end

	on_validate (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnValidate"
		end

	frozen dictionary_remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Remove"
		end

	on_insert (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnInsert"
		end

	frozen dictionary_get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Values"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"OnClear"
		end

	frozen dictionary_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_IsFixedSize"
		end

	frozen dictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	on_remove (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnRemove"
		end

end -- class SYSTEM_COLLECTIONS_DICTIONARYBASE
