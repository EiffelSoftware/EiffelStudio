indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbParameterCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_PARAMETER_COLLECTION

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

	frozen get_item (parameter_name: SYSTEM_STRING): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.String): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbParameterCollection"
		alias
			"get_Count"
		end

	frozen get_item_int32 (index: INTEGER): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.Int32): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item_int32 (index: INTEGER; value: DATA_OLE_DB_PARAMETER) is
		external
			"IL signature (System.Int32, System.Data.OleDb.OleDbParameter): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"set_Item"
		end

	frozen set_item (parameter_name: SYSTEM_STRING; value: DATA_OLE_DB_PARAMETER) is
		external
			"IL signature (System.String, System.Data.OleDb.OleDbParameter): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"RemoveAt"
		end

	frozen remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Insert"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.OleDb.OleDbParameterCollection"
		alias
			"IndexOf"
		end

	frozen add (value: DATA_OLE_DB_PARAMETER): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.Data.OleDb.OleDbParameter): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Clear"
		end

	frozen add_string_ole_db_type_int32_string (parameter_name: SYSTEM_STRING; ole_db_type: DATA_OLE_DB_TYPE; size: INTEGER; source_column: SYSTEM_STRING): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.String, System.Data.OleDb.OleDbType, System.Int32, System.String): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Add"
		end

	frozen index_of_string (parameter_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.OleDb.OleDbParameterCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"CopyTo"
		end

	frozen remove_at_string (parameter_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"RemoveAt"
		end

	frozen add_string_ole_db_type (parameter_name: SYSTEM_STRING; ole_db_type: DATA_OLE_DB_TYPE): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.String, System.Data.OleDb.OleDbType): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Add"
		end

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Contains"
		end

	frozen add_string_object (parameter_name: SYSTEM_STRING; value: SYSTEM_OBJECT): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.String, System.Object): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Add"
		end

	frozen add_object (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Add"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.OleDb.OleDbParameterCollection"
		alias
			"GetEnumerator"
		end

	frozen contains_string (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Contains"
		end

	frozen add_string_ole_db_type_int32 (parameter_name: SYSTEM_STRING; ole_db_type: DATA_OLE_DB_TYPE; size: INTEGER): DATA_OLE_DB_PARAMETER is
		external
			"IL signature (System.String, System.Data.OleDb.OleDbType, System.Int32): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbParameterCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen get_item_string (index: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Data.IDataParameterCollection.get_Item"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen set_item_string (index: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.OleDb.OleDbParameterCollection"
		alias
			"System.Data.IDataParameterCollection.set_Item"
		end

end -- class DATA_OLE_DB_PARAMETER_COLLECTION
