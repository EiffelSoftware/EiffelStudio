indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.PropertyCollection"

external class
	SYSTEM_DIRECTORYSERVICES_PROPERTYCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_enumerator as ienumerable_get_enumerator,
			remove as idictionary_remove,
			has as idictionary_has,
			clear as idictionary_clear,
			extend as idictionary_extend,
			get_keys as idictionary_get_keys,
			get_is_read_only as idictionary_get_is_read_only,
			get_is_fixed_size as idictionary_get_is_fixed_size,
			put_i_th as idictionary_put_i_th,
			get_item as idictionary_get_item
		end

create {NONE}

feature -- Access

	frozen get_property_names: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.DirectoryServices.PropertyCollection"
		alias
			"get_PropertyNames"
		end

	frozen get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.DirectoryServices.PropertyCollection"
		alias
			"get_Values"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.PropertyCollection"
		alias
			"get_Count"
		end

	frozen get_item (property_name: STRING): SYSTEM_DIRECTORYSERVICES_PROPERTYVALUECOLLECTION is
		external
			"IL signature (System.String): System.DirectoryServices.PropertyValueCollection use System.DirectoryServices.PropertyCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.PropertyCollection"
		alias
			"GetHashCode"
		end

	frozen has (property_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.DirectoryServices.PropertyCollection"
		alias
			"Contains"
		end

	frozen get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.DirectoryServices.PropertyCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.PropertyCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: ARRAY [SYSTEM_DIRECTORYSERVICES_PROPERTYVALUECOLLECTION]; index: INTEGER) is
		external
			"IL signature (System.DirectoryServices.PropertyValueCollection[], System.Int32): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.PropertyCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen idictionary_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.get_IsFixedSize"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen idictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	finalize is
		external
			"IL signature (): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"Finalize"
		end

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen idictionary_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.Contains"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen idictionary_put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen idictionary_extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen idictionary_remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.Remove"
		end

	frozen idictionary_get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.get_Item"
		end

	frozen idictionary_get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.get_Keys"
		end

	frozen idictionary_clear is
		external
			"IL signature (): System.Void use System.DirectoryServices.PropertyCollection"
		alias
			"System.Collections.IDictionary.Clear"
		end

end -- class SYSTEM_DIRECTORYSERVICES_PROPERTYCOLLECTION
