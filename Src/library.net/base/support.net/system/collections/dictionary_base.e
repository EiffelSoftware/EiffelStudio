indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.DictionaryBase"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DICTIONARY_BASE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			remove as system_collections_idictionary_remove,
			add as system_collections_idictionary_add,
			contains as system_collections_idictionary_contains,
			set_item as system_collections_idictionary_set_item,
			get_item as system_collections_idictionary_get_item,
			get_values as system_collections_idictionary_get_values,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_keys as system_collections_idictionary_get_keys,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_idictionary_get_is_fixed_size,
			get_is_read_only as system_collections_idictionary_get_is_read_only
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
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

	frozen get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.DictionaryBase"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.DictionaryBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.DictionaryBase"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	on_validate (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnValidate"
		end

	frozen get_dictionary: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Collections.DictionaryBase"
		alias
			"get_Dictionary"
		end

	frozen system_collections_idictionary_remove (key: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Remove"
		end

	on_remove (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnRemove"
		end

	frozen system_collections_idictionary_get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
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

	on_set (key: SYSTEM_OBJECT; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnSet"
		end

	on_set_complete (key: SYSTEM_OBJECT; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnSetComplete"
		end

	on_insert_complete (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnInsertComplete"
		end

	on_insert (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnInsert"
		end

	frozen get_inner_hashtable: HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use System.Collections.DictionaryBase"
		alias
			"get_InnerHashtable"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_idictionary_add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen system_collections_idictionary_get_is_fixed_size: BOOLEAN is
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

	on_remove_complete (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"OnRemoveComplete"
		end

	frozen system_collections_idictionary_contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.Contains"
		end

	frozen system_collections_idictionary_set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen system_collections_idictionary_get_keys: ICOLLECTION is
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

	frozen system_collections_idictionary_get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_Values"
		end

	frozen system_collections_idictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.DictionaryBase"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.DictionaryBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	on_get (key: SYSTEM_OBJECT; current_value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Object): System.Object use System.Collections.DictionaryBase"
		alias
			"OnGet"
		end

end -- class DICTIONARY_BASE
