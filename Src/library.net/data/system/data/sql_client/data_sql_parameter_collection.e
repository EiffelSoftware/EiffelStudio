indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlParameterCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_PARAMETER_COLLECTION

inherit
	MARSHAL_BY_REF_OBJECT
	DATA_IDATA_PARAMETER_COLLECTION
		rename
			add as add_object,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	ILIST
		rename
			add as add_object,
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

create {NONE}

feature -- Access

	frozen get_item (parameter_name: SYSTEM_STRING): DATA_SQL_PARAMETER is
		external
			"IL signature (System.String): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"get_Count"
		end

	frozen get_item_int32 (index: INTEGER): DATA_SQL_PARAMETER is
		external
			"IL signature (System.Int32): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: DATA_SQL_PARAMETER) is
		external
			"IL signature (System.Int32, System.Data.SqlClient.SqlParameter): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"set_Item"
		end

	frozen set_item (parameter_name: SYSTEM_STRING; value: DATA_SQL_PARAMETER) is
		external
			"IL signature (System.String, System.Data.SqlClient.SqlParameter): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"RemoveAt"
		end

	frozen remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Insert"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"IndexOf"
		end

	frozen add (value: DATA_SQL_PARAMETER): DATA_SQL_PARAMETER is
		external
			"IL signature (System.Data.SqlClient.SqlParameter): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Clear"
		end

	frozen add_string_sql_db_type_int32_string (parameter_name: SYSTEM_STRING; sql_db_type: DATA_SQL_DB_TYPE; size: INTEGER; source_column: SYSTEM_STRING): DATA_SQL_PARAMETER is
		external
			"IL signature (System.String, System.Data.SqlDbType, System.Int32, System.String): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen index_of_string (parameter_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"CopyTo"
		end

	frozen remove_at_string (parameter_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"RemoveAt"
		end

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Contains"
		end

	frozen add_string_object (parameter_name: SYSTEM_STRING; value: SYSTEM_OBJECT): DATA_SQL_PARAMETER is
		external
			"IL signature (System.String, System.Object): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen add_string_sql_db_type (parameter_name: SYSTEM_STRING; sql_db_type: DATA_SQL_DB_TYPE): DATA_SQL_PARAMETER is
		external
			"IL signature (System.String, System.Data.SqlDbType): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen add_object (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.SqlClient.SqlParameterCollection"
		alias
			"GetEnumerator"
		end

	frozen contains_string (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Contains"
		end

	frozen add_string_sql_db_type_int32 (parameter_name: SYSTEM_STRING; sql_db_type: DATA_SQL_DB_TYPE; size: INTEGER): DATA_SQL_PARAMETER is
		external
			"IL signature (System.String, System.Data.SqlDbType, System.Int32): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen get_item_string (index: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.get_Item"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen set_item_string (index: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.set_Item"
		end

end -- class DATA_SQL_PARAMETER_COLLECTION
