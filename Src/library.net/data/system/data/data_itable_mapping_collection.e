indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ITableMappingCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_ITABLE_MAPPING_COLLECTION

inherit
	ILIST
	ICOLLECTION
	IENUMERABLE

feature -- Access

	get_item_string (index: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.Data.ITableMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item_string (index: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Data.ITableMappingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at_string (source_table_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.ITableMappingCollection"
		alias
			"RemoveAt"
		end

	index_of_string (source_table_name: SYSTEM_STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.ITableMappingCollection"
		alias
			"IndexOf"
		end

	get_by_data_set_table (data_set_table_name: SYSTEM_STRING): DATA_ITABLE_MAPPING is
		external
			"IL deferred signature (System.String): System.Data.ITableMapping use System.Data.ITableMappingCollection"
		alias
			"GetByDataSetTable"
		end

	add_string (source_table_name: SYSTEM_STRING; data_set_table_name: SYSTEM_STRING): DATA_ITABLE_MAPPING is
		external
			"IL deferred signature (System.String, System.String): System.Data.ITableMapping use System.Data.ITableMappingCollection"
		alias
			"Add"
		end

	contains_string (source_table_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Data.ITableMappingCollection"
		alias
			"Contains"
		end

end -- class DATA_ITABLE_MAPPING_COLLECTION
