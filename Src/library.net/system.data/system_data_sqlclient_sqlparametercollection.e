indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlParameterCollection"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLPARAMETERCOLLECTION

inherit
	SYSTEM_DATA_IDATAPARAMETERCOLLECTION
		rename
			remove_at as remove_at_int32,
			index_of as index_of_object,
			contains as contains_object,
			add as add_object,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove_at as remove_at_int32,
			index_of as index_of_object,
			contains as contains_object,
			add as add_object,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create {NONE}

feature -- Access

	frozen get_item (parameter_name: STRING): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
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

	frozen get_item_int32 (index: INTEGER): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
		external
			"IL signature (System.Int32): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: SYSTEM_DATA_SQLCLIENT_SQLPARAMETER) is
		external
			"IL signature (System.Int32, System.Data.SqlClient.SqlParameter): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"set_Item"
		end

	frozen set_item (parameter_name: STRING; value: SYSTEM_DATA_SQLCLIENT_SQLPARAMETER) is
		external
			"IL signature (System.String, System.Data.SqlClient.SqlParameter): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_at (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"RemoveAt"
		end

	frozen add (value: SYSTEM_DATA_SQLCLIENT_SQLPARAMETER): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
		external
			"IL signature (System.Data.SqlClient.SqlParameter): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Insert"
		end

	frozen index_of (parameter_name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"IndexOf"
		end

	frozen add_string_sql_db_type_int32_string (name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE; size: INTEGER; source_column: STRING): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
		external
			"IL signature (System.String, System.Data.SqlDbType, System.Int32, System.String): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen contains_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Contains"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"CopyTo"
		end

	frozen add_string_sql_db_type (name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
		external
			"IL signature (System.String, System.Data.SqlDbType): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen add_string_object (name: STRING; value: ANY): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
		external
			"IL signature (System.String, System.Object): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen add_object (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.SqlClient.SqlParameterCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Contains"
		end

	frozen remove_at_int32 (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"RemoveAt"
		end

	frozen add_string_sql_db_type_int32 (name: STRING; db_type: SYSTEM_DATA_SQLDBTYPE; size: INTEGER): SYSTEM_DATA_SQLCLIENT_SQLPARAMETER is
		external
			"IL signature (System.String, System.Data.SqlDbType, System.Int32): System.Data.SqlClient.SqlParameter use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Add"
		end

	frozen index_of_object (parameter: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"IndexOf"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"Clear"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
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

	frozen get_item_string (index: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.get_Item"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
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

	frozen set_item_string (index: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.set_Item"
		end

	frozen contains_string (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.Contains"
		end

	frozen remove_at_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.RemoveAt"
		end

	frozen index_of_string (value: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.SqlClient.SqlParameterCollection"
		alias
			"System.Data.IDataParameterCollection.IndexOf"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLPARAMETERCOLLECTION
