indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.InstanceDataCollectionCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INSTANCE_DATA_COLLECTION_COLLECTION

inherit
	DICTIONARY_BASE
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

create
	make_system_dll_instance_data_collection_collection

feature {NONE} -- Initialization

	frozen make_system_dll_instance_data_collection_collection is
		external
			"IL creator use System.Diagnostics.InstanceDataCollectionCollection"
		end

feature -- Access

	frozen get_item (counter_name: SYSTEM_STRING): SYSTEM_DLL_INSTANCE_DATA_COLLECTION is
		external
			"IL signature (System.String): System.Diagnostics.InstanceDataCollection use System.Diagnostics.InstanceDataCollectionCollection"
		alias
			"get_Item"
		end

	frozen get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Diagnostics.InstanceDataCollectionCollection"
		alias
			"get_Keys"
		end

	frozen get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Diagnostics.InstanceDataCollectionCollection"
		alias
			"get_Values"
		end

feature -- Basic Operations

	frozen copy_to_array_instance_data_collection (counters: NATIVE_ARRAY [SYSTEM_DLL_INSTANCE_DATA_COLLECTION]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.InstanceDataCollection[], System.Int32): System.Void use System.Diagnostics.InstanceDataCollectionCollection"
		alias
			"CopyTo"
		end

	frozen contains (counter_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.InstanceDataCollectionCollection"
		alias
			"Contains"
		end

end -- class SYSTEM_DLL_INSTANCE_DATA_COLLECTION_COLLECTION
