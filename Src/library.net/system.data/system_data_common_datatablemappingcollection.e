indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DataTableMappingCollection"

frozen external class
	SYSTEM_DATA_COMMON_DATATABLEMAPPINGCOLLECTION

inherit
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_COLLECTIONS_ILIST
		rename
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	SYSTEM_DATA_ITABLEMAPPINGCOLLECTION
		rename
			get_by_data_set_table as system_data_itable_mapping_collection_get_by_data_set_table,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create
	make_datatablemappingcollection

feature {NONE} -- Initialization

	frozen make_datatablemappingcollection is
		external
			"IL creator use System.Data.Common.DataTableMappingCollection"
		end

feature -- Access

	frozen get_item (source_table: STRING): SYSTEM_DATA_COMMON_DATATABLEMAPPING is
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

	frozen get_item_int32 (index: INTEGER): SYSTEM_DATA_COMMON_DATATABLEMAPPING is
		external
			"IL signature (System.Int32): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: SYSTEM_DATA_COMMON_DATATABLEMAPPING) is
		external
			"IL signature (System.Int32, System.Data.Common.DataTableMapping): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"set_Item"
		end

	frozen set_item (source_table: STRING; value: SYSTEM_DATA_COMMON_DATATABLEMAPPING) is
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

	frozen remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"Remove"
		end

	frozen index_of_data_set_table (data_set_table: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"IndexOfDataSetTable"
		end

	frozen insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"Insert"
		end

	frozen index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.Common.DataTableMappingCollection"
		alias
			"IndexOf"
		end

	frozen add (value: ANY): INTEGER is
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

	frozen get_by_data_set_table (data_set_table: STRING): SYSTEM_DATA_COMMON_DATATABLEMAPPING is
		external
			"IL signature (System.String): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"GetByDataSetTable"
		end

	frozen get_table_mapping_by_schema_action (table_mappings: SYSTEM_DATA_COMMON_DATATABLEMAPPINGCOLLECTION; source_table: STRING; data_set_table: STRING; mapping_action: SYSTEM_DATA_MISSINGMAPPINGACTION): SYSTEM_DATA_COMMON_DATATABLEMAPPING is
		external
			"IL static signature (System.Data.Common.DataTableMappingCollection, System.String, System.String, System.Data.MissingMappingAction): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"GetTableMappingBySchemaAction"
		end

	frozen index_of_string (source_table: STRING): INTEGER is
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

	frozen remove_at_string (source_table: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"RemoveAt"
		end

	frozen contains (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"Contains"
		end

	frozen add_string2 (source_table: STRING; data_set_table: STRING): SYSTEM_DATA_COMMON_DATATABLEMAPPING is
		external
			"IL signature (System.String, System.String): System.Data.Common.DataTableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"Add"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.Common.DataTableMappingCollection"
		alias
			"GetEnumerator"
		end

	frozen contains_string (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.Common.DataTableMappingCollection"
		alias
			"Contains"
		end

	frozen add_range (value: ARRAY [SYSTEM_DATA_COMMON_DATATABLEMAPPING]) is
		external
			"IL signature (System.Data.Common.DataTableMapping[]): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_data_itable_mapping_collection_get_by_data_set_table (data_set_table_name: STRING): SYSTEM_DATA_ITABLEMAPPING is
		external
			"IL signature (System.String): System.Data.ITableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.GetByDataSetTable"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
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

	frozen get_item_string (index: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.get_Item"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
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

	frozen set_item_string (index: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.set_Item"
		end

	frozen add_string (source_table_name: STRING; data_set_table_name: STRING): SYSTEM_DATA_ITABLEMAPPING is
		external
			"IL signature (System.String, System.String): System.Data.ITableMapping use System.Data.Common.DataTableMappingCollection"
		alias
			"System.Data.ITableMappingCollection.Add"
		end

end -- class SYSTEM_DATA_COMMON_DATATABLEMAPPINGCOLLECTION
