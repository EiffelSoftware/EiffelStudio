indexing
	Generator: "Eiffel Emitter 2.7b2"
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
			get_enumerator as ienumerable_get_enumerator,
			remove as idictionary_remove,
			extend as idictionary_extend,
			has as idictionary_has,
			put_i_th as idictionary_put_i_th,
			get_item as idictionary_get_item,
			get_values as idictionary_get_values,
			get_sync_root as icollection_get_sync_root,
			get_keys as idictionary_get_keys,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as idictionary_get_is_fixed_size,
			get_is_read_only as idictionary_get_is_read_only
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end

feature -- Access

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.DictionaryBase"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.DictionaryBase"
		alias
			"GetHashCode"
		end

	frozen get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.DictionaryBase"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.DictionaryBase"
		alias
			"ToString"
		end

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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.DictionaryBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.DictionaryBase"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	on_validate (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnValidate"
		end

	frozen get_dictionary: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Collections.DictionaryBase"
		alias
			"get_Dictionary"
		end

	frozen idictionary_remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Remove"
		end

	on_remove (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnRemove"
		end

	frozen idictionary_get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Item"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"Finalize"
		end

	on_set (key: ANY; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Object, System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnSet"
		end

	on_set_complete (key: ANY; old_value: ANY; new_value: ANY) is
		external
			"IL signature (System.Object, System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnSetComplete"
		end

	on_insert_complete (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnInsertComplete"
		end

	on_insert (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnInsert"
		end

	frozen get_inner_hashtable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use System.Collections.DictionaryBase"
		alias
			"get_InnerHashtable"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen idictionary_extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen idictionary_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_IsFixedSize"
		end

	on_clear_complete is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"OnClearComplete"
		end

	on_remove_complete (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnRemoveComplete"
		end

	frozen idictionary_has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Contains"
		end

	frozen idictionary_put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen idictionary_get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Keys"
		end

	on_clear is
		external
			"IL signature (): System.Void use System.Collections.DictionaryBase"
		alias
			"OnClear"
		end

	frozen idictionary_get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Values"
		end

	frozen idictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.DictionaryBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	on_get (key: ANY; current_value: ANY): ANY is
		external
			"IL signature (System.Object, System.Object): System.Object use System.Collections.DictionaryBase"
		alias
			"OnGet"
		end

end -- class SYSTEM_COLLECTIONS_DICTIONARYBASE
