indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.InstanceDataCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INSTANCE_DATA_COLLECTION

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
	make_system_dll_instance_data_collection

feature {NONE} -- Initialization

	frozen make_system_dll_instance_data_collection (counter_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.InstanceDataCollection"
		end

feature -- Access

	frozen get_counter_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.InstanceDataCollection"
		alias
			"get_CounterName"
		end

	frozen get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Diagnostics.InstanceDataCollection"
		alias
			"get_Keys"
		end

	frozen get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Diagnostics.InstanceDataCollection"
		alias
			"get_Values"
		end

	frozen get_item (instance_name: SYSTEM_STRING): SYSTEM_DLL_INSTANCE_DATA is
		external
			"IL signature (System.String): System.Diagnostics.InstanceData use System.Diagnostics.InstanceDataCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to_array_instance_data (instances: NATIVE_ARRAY [SYSTEM_DLL_INSTANCE_DATA]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.InstanceData[], System.Int32): System.Void use System.Diagnostics.InstanceDataCollection"
		alias
			"CopyTo"
		end

	frozen contains (instance_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.InstanceDataCollection"
		alias
			"Contains"
		end

end -- class SYSTEM_DLL_INSTANCE_DATA_COLLECTION
