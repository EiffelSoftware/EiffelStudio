indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DataColumnMappingCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_DATA_COLUMN_MAPPING_COLLECTION

inherit
	MARSHAL_BY_REF_OBJECT
	DATA_ICOLUMN_MAPPING_COLLECTION
		rename
			get_by_data_set_column as system_data_icolumn_mapping_collection_get_by_data_set_column,
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
	make_data_data_column_mapping_collection

feature {NONE} -- Initialization

	frozen make_data_data_column_mapping_collection is
		external
			"IL creator use System.Data.Common.DataColumnMappingCollection"
		end

feature -- Access

	frozen get_item (source_column: SYSTEM_STRING): DATA_DATA_COLUMN_MAPPING is
		external
			"IL signature (System.String): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"get_Count"
		end

	frozen get_item_int32 (index: INTEGER): DATA_DATA_COLUMN_MAPPING is
		external
			"IL signature (System.Int32): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: DATA_DATA_COLUMN_MAPPING) is
		external
			"IL signature (System.Int32, System.Data.Common.DataColumnMapping): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"set_Item"
		end

	frozen set_item (source_column: SYSTEM_STRING; value: DATA_DATA_COLUMN_MAPPING) is
		external
			"IL signature (System.String, System.Data.Common.DataColumnMapping): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"RemoveAt"
		end

	frozen remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"Insert"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"IndexOf"
		end

	frozen add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"Clear"
		end

	frozen index_of_string (source_column: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"CopyTo"
		end

	frozen remove_at_string (source_column: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"RemoveAt"
		end

	frozen get_by_data_set_column (value: SYSTEM_STRING): DATA_DATA_COLUMN_MAPPING is
		external
			"IL signature (System.String): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"GetByDataSetColumn"
		end

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"Contains"
		end

	frozen add_string2 (source_column: SYSTEM_STRING; data_set_column: SYSTEM_STRING): DATA_DATA_COLUMN_MAPPING is
		external
			"IL signature (System.String, System.String): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"Add"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.Common.DataColumnMappingCollection"
		alias
			"GetEnumerator"
		end

	frozen get_column_mapping_by_schema_action (column_mappings: DATA_DATA_COLUMN_MAPPING_COLLECTION; source_column: SYSTEM_STRING; mapping_action: DATA_MISSING_MAPPING_ACTION): DATA_DATA_COLUMN_MAPPING is
		external
			"IL static signature (System.Data.Common.DataColumnMappingCollection, System.String, System.Data.MissingMappingAction): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"GetColumnMappingBySchemaAction"
		end

	frozen contains_string (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"Contains"
		end

	frozen index_of_data_set_column (data_set_column: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"IndexOfDataSetColumn"
		end

	frozen add_range (values: NATIVE_ARRAY [DATA_DATA_COLUMN_MAPPING]) is
		external
			"IL signature (System.Data.Common.DataColumnMapping[]): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_data_icolumn_mapping_collection_get_by_data_set_column (data_set_column_name: SYSTEM_STRING): DATA_ICOLUMN_MAPPING is
		external
			"IL signature (System.String): System.Data.IColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.GetByDataSetColumn"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen get_item_string (index: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.get_Item"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen set_item_string (index: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.set_Item"
		end

	frozen add_string (source_column_name: SYSTEM_STRING; data_set_column_name: SYSTEM_STRING): DATA_ICOLUMN_MAPPING is
		external
			"IL signature (System.String, System.String): System.Data.IColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.Add"
		end

end -- class DATA_DATA_COLUMN_MAPPING_COLLECTION
