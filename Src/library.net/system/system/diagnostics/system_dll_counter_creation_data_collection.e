indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.CounterCreationDataCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COUNTER_CREATION_DATA_COLLECTION

inherit
	COLLECTION_BASE
		redefine
			on_insert
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

create
	make_system_dll_counter_creation_data_collection_1,
	make_system_dll_counter_creation_data_collection_2,
	make_system_dll_counter_creation_data_collection

feature {NONE} -- Initialization

	frozen make_system_dll_counter_creation_data_collection_1 (value: SYSTEM_DLL_COUNTER_CREATION_DATA_COLLECTION) is
		external
			"IL creator signature (System.Diagnostics.CounterCreationDataCollection) use System.Diagnostics.CounterCreationDataCollection"
		end

	frozen make_system_dll_counter_creation_data_collection_2 (value: NATIVE_ARRAY [SYSTEM_DLL_COUNTER_CREATION_DATA]) is
		external
			"IL creator signature (System.Diagnostics.CounterCreationData[]) use System.Diagnostics.CounterCreationDataCollection"
		end

	frozen make_system_dll_counter_creation_data_collection is
		external
			"IL creator use System.Diagnostics.CounterCreationDataCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_COUNTER_CREATION_DATA is
		external
			"IL signature (System.Int32): System.Diagnostics.CounterCreationData use System.Diagnostics.CounterCreationDataCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_COUNTER_CREATION_DATA) is
		external
			"IL signature (System.Int32, System.Diagnostics.CounterCreationData): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_counter_creation_data (value: NATIVE_ARRAY [SYSTEM_DLL_COUNTER_CREATION_DATA]) is
		external
			"IL signature (System.Diagnostics.CounterCreationData[]): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_DLL_COUNTER_CREATION_DATA) is
		external
			"IL signature (System.Int32, System.Diagnostics.CounterCreationData): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_COUNTER_CREATION_DATA]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.CounterCreationData[], System.Int32): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DLL_COUNTER_CREATION_DATA): INTEGER is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Int32 use System.Diagnostics.CounterCreationDataCollection"
		alias
			"IndexOf"
		end

	remove (value: SYSTEM_DLL_COUNTER_CREATION_DATA) is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_COUNTER_CREATION_DATA): BOOLEAN is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Boolean use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_COUNTER_CREATION_DATA_COLLECTION) is
		external
			"IL signature (System.Diagnostics.CounterCreationDataCollection): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DLL_COUNTER_CREATION_DATA): INTEGER is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Int32 use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	on_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"OnInsert"
		end

end -- class SYSTEM_DLL_COUNTER_CREATION_DATA_COLLECTION
