indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DataTableMappingCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_DATA_TABLE_MAPPING_COLLECTION

inherit
	MARSHAL_BY_REF_OBJECT
	DATA_ITABLE_MAPPING_COLLECTION
		rename
			get_by_data_set_table as system_data_itable_mapping_collection_get_by_data_set_table,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	ILIST
		rename
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	ICOLLECTION
		rename
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_data_data_table_mapping_collection

feature {NONE} -- Initialization

	frozen make_data_data_table_mapping_collection is
		external
			"IL creator use System.Data.Common.DataTableMappingCollection"
		end

feature -- Access

	frozen get_item (source_table: SYSTEM_STRING): DATA_DATA_TABLE_MAPPING is
		external
			"IL signature (System.String): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"get_Count"
		end

	frozen get_item_int32 (index: INTEGER): DATA_DATA_TABLE_MAPPING is
		external
			"IL signature (System.Int32): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: DATA_DATA_TABLE_MAPPING) is
		external
			"IL signature (System.Int32, System.Data.Common.DataTableMapping): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"set_Item"
		end

	frozen set_item (source_table: SYSTEM_STRING; value: DATA_DATA_TABLE_MAPPING) is
		external
			"IL signature (System.String, System.Data.Common.DataTableMapping): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"RemoveAt"
		end

	frozen remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"Remove"
		end

	frozen index_of_data_set_table (data_set_table: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"IndexOfDataSetTable"
		end

	frozen insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"Insert"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"IndexOf"
		end

	frozen add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"Clear"
		end

	frozen get_by_data_set_table (data_set_table: SYSTEM_STRING): DATA_DATA_TABLE_MAPPING is
		external
			"IL signature (System.String): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"GetByDataSetTable"
		end

	frozen get_table_mapping_by_schema_action (table_mappings: DATA_DATA_TABLE_MAPPING_COLLECTION; source_table: SYSTEM_STRING; data_set_table: SYSTEM_STRING; mapping_action: DATA_MISSING_MAPPING_ACTION): DATA_DATA_TABLE_MAPPING is
		external
			"IL static signature (System.Data.Common.DataTableMappingCollection, System.String, System.String, System.Data.MissingMappingAction): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"GetTableMappingBySchemaAction"
		end

	frozen index_of_string (source_table: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"CopyTo"
		end

	frozen remove_at_string (source_table: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"RemoveAt"
		end

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"Contains"
		end

	frozen add_string2 (source_table: SYSTEM_STRING; data_set_table: SYSTEM_STRING): DATA_DATA_TABLE_MAPPING is
		external
			"IL signature (System.String, System.String): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"Add"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.Common.DataTableMappingCollection"
		alias
			"GetEnumerator"
		end

	frozen contains_string (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"Contains"
		end

	frozen add_range (values: NATIVE_ARRAY [DATA_DATA_TABLE_MAPPING]) is
		external
			"IL signature (System.Data.Common.DataTableMapping[]): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_data_itable_mapping_collection_get_by_data_set_table (data_set_table_name: SYSTEM_STRING): DATA_ITABLE_MAPPING is
		external
			"IL signature (System.String): System.Data.ITableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.GetByDataSetTable"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen get_item_string (index: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.get_Item"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen set_item_string (index: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.set_Item"
		end

	frozen add_string (source_table_name: SYSTEM_STRING; data_set_table_name: SYSTEM_STRING): DATA_ITABLE_MAPPING is
		external
			"IL signature (System.String, System.String): System.Data.ITableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.Add"
		end

end -- class DATA_DATA_TABLE_MAPPING_COLLECTION
