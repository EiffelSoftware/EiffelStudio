indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.ResultPropertyCollection"

external class
	SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYCOLLECTION

inherit
	SYSTEM_COLLECTIONS_DICTIONARYBASE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
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

create {NONE}

feature -- Access

	frozen get_property_names: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.DirectoryServices.ResultPropertyCollection"
		alias
			"get_PropertyNames"
		end

	frozen get_item (name: STRING): SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYVALUECOLLECTION is
		external
			"IL signature (System.String): System.DirectoryServices.ResultPropertyValueCollection use System.DirectoryServices.ResultPropertyCollection"
		alias
			"get_Item"
		end

	frozen get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.DirectoryServices.ResultPropertyCollection"
		alias
			"get_Values"
		end

feature -- Basic Operations

	frozen contains (property_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.DirectoryServices.ResultPropertyCollection"
		alias
			"Contains"
		end

	frozen copy_to_array_result_property_value_collection (array: ARRAY [SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYVALUECOLLECTION]; index: INTEGER) is
		external
			"IL signature (System.DirectoryServices.ResultPropertyValueCollection[], System.Int32): System.Void use System.DirectoryServices.ResultPropertyCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYCOLLECTION
