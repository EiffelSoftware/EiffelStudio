indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DataColumnMappingCollection"

frozen external class
	SYSTEM_DATA_COMMON_DATACOLUMNMAPPINGCOLLECTION

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_DATA_ICOLUMNMAPPINGCOLLECTION
		rename
			get_by_data_set_column as system_data_icolumn_mapping_collection_get_by_data_set_column,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end

create
	make_datacolumnmappingcollection

feature {NONE} -- Initialization

	frozen make_datacolumnmappingcollection is
		external
			"IL creator use System.Data.Common.DataColumnMappingCollection"
		end

feature -- Access

	frozen get_item (source_column: STRING): SYSTEM_DATA_COMMON_DATACOLUMNMAPPING is
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

	frozen get_item_int32 (index: INTEGER): SYSTEM_DATA_COMMON_DATACOLUMNMAPPING is
		external
			"IL signature (System.Int32): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: SYSTEM_DATA_COMMON_DATACOLUMNMAPPING) is
		external
			"IL signature (System.Int32, System.Data.Common.DataColumnMapping): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"set_Item"
		end

	frozen put_i_th (source_column: STRING; value: SYSTEM_DATA_COMMON_DATACOLUMNMAPPING) is
		external
			"IL signature (System.String, System.Data.Common.DataColumnMapping): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"RemoveAt"
		end

	frozen remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"Insert"
		end

	frozen index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"IndexOf"
		end

	frozen extend (value: ANY): INTEGER is
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

	frozen index_of_string (source_column: STRING): INTEGER is
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

	frozen remove_at_string (source_column: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"RemoveAt"
		end

	frozen get_by_data_set_column (value: STRING): SYSTEM_DATA_COMMON_DATACOLUMNMAPPING is
		external
			"IL signature (System.String): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"GetByDataSetColumn"
		end

	frozen has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"Contains"
		end

	frozen add_string2 (source_column: STRING; data_set_column: STRING): SYSTEM_DATA_COMMON_DATACOLUMNMAPPING is
		external
			"IL signature (System.String, System.String): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"Add"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.Common.DataColumnMappingCollection"
		alias
			"GetEnumerator"
		end

	frozen get_column_mapping_by_schema_action (column_mappings: SYSTEM_DATA_COMMON_DATACOLUMNMAPPINGCOLLECTION; source_column: STRING; mapping_action: SYSTEM_DATA_MISSINGMAPPINGACTION): SYSTEM_DATA_COMMON_DATACOLUMNMAPPING is
		external
			"IL static signature (System.Data.Common.DataColumnMappingCollection, System.String, System.Data.MissingMappingAction): System.Data.Common.DataColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"GetColumnMappingBySchemaAction"
		end

	frozen contains_string (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"Contains"
		end

	frozen index_of_data_set_column (data_set_column: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DataColumnMappingCollection"
		alias
			"IndexOfDataSetColumn"
		end

	frozen add_range (value: ARRAY [SYSTEM_DATA_COMMON_DATACOLUMNMAPPING]) is
		external
			"IL signature (System.Data.Common.DataColumnMapping[]): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_data_icolumn_mapping_collection_get_by_data_set_column (data_set_column_name: STRING): SYSTEM_DATA_ICOLUMNMAPPING is
		external
			"IL signature (System.String): System.Data.IColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.GetByDataSetColumn"
		end

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen get_item_string (index: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.get_Item"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen set_item_string (index: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.set_Item"
		end

	frozen add_string (source_column_name: STRING; data_set_column_name: STRING): SYSTEM_DATA_ICOLUMNMAPPING is
		external
			"IL signature (System.String, System.String): System.Data.IColumnMapping use System.Data.Common.DataColumnMappingCollection"
		alias
			"System.Data.IColumnMappingCollection.Add"
		end

end -- class SYSTEM_DATA_COMMON_DATACOLUMNMAPPINGCOLLECTION
