indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ITableMappingCollection"

deferred external class
	SYSTEM_DATA_ITABLEMAPPINGCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION

feature -- Access

	get_item_string (index: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.Data.ITableMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item_string (index: STRING; value: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Data.ITableMappingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at_string (source_table_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.ITableMappingCollection"
		alias
			"RemoveAt"
		end

	index_of_string (source_table_name: STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.ITableMappingCollection"
		alias
			"IndexOf"
		end

	get_by_data_set_table (data_set_table_name: STRING): SYSTEM_DATA_ITABLEMAPPING is
		external
			"IL deferred signature (System.String): System.Data.ITableMapping use System.Data.ITableMappingCollection"
		alias
			"GetByDataSetTable"
		end

	add_string (source_table_name: STRING; data_set_table_name: STRING): SYSTEM_DATA_ITABLEMAPPING is
		external
			"IL deferred signature (System.String, System.String): System.Data.ITableMapping use System.Data.ITableMappingCollection"
		alias
			"Add"
		end

	contains_string (source_table_name: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Data.ITableMappingCollection"
		alias
			"Contains"
		end

end -- class SYSTEM_DATA_ITABLEMAPPINGCOLLECTION
