indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IColumnMappingCollection"

deferred external class
	SYSTEM_DATA_ICOLUMNMAPPINGCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION

feature -- Access

	get_item_string (index: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.Data.IColumnMappingCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item_string (index: STRING; value: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Data.IColumnMappingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at_string (source_column_name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IColumnMappingCollection"
		alias
			"RemoveAt"
		end

	index_of_string (source_column_name: STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.IColumnMappingCollection"
		alias
			"IndexOf"
		end

	add_string (source_column_name: STRING; data_set_column_name: STRING): SYSTEM_DATA_ICOLUMNMAPPING is
		external
			"IL deferred signature (System.String, System.String): System.Data.IColumnMapping use System.Data.IColumnMappingCollection"
		alias
			"Add"
		end

	contains_string (source_column_name: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Data.IColumnMappingCollection"
		alias
			"Contains"
		end

	get_by_data_set_column (data_set_column_name: STRING): SYSTEM_DATA_ICOLUMNMAPPING is
		external
			"IL deferred signature (System.String): System.Data.IColumnMapping use System.Data.IColumnMappingCollection"
		alias
			"GetByDataSetColumn"
		end

end -- class SYSTEM_DATA_ICOLUMNMAPPINGCOLLECTION
