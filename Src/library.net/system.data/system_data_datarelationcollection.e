indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRelationCollection"

deferred external class
	SYSTEM_DATA_DATARELATIONCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_DATA_INTERNALDATACOLLECTIONBASE
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_item (index: INTEGER): SYSTEM_DATA_DATARELATION is
		external
			"IL deferred signature (System.Int32): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"get_Item"
		end

	get_item_string (name: STRING): SYSTEM_DATA_DATARELATION is
		external
			"IL deferred signature (System.String): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataRelationCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataRelationCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	add_string_array_data_column_array_data_column (name: STRING; parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]): SYSTEM_DATA_DATARELATION is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_data_column (parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN): SYSTEM_DATA_DATARELATION is
		external
			"IL signature (System.Data.DataColumn, System.Data.DataColumn): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_string_array_data_column_array_data_column_boolean (name: STRING; parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; create_constraints: BOOLEAN): SYSTEM_DATA_DATARELATION is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[], System.Boolean): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_string_data_column_data_column (name: STRING; parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN): SYSTEM_DATA_DATARELATION is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Data.DataColumn): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	frozen remove_data_relation (relation: SYSTEM_DATA_DATARELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"Remove"
		end

	clear is
		external
			"IL signature (): System.Void use System.Data.DataRelationCollection"
		alias
			"Clear"
		end

	contains (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.DataRelationCollection"
		alias
			"Contains"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataRelationCollection"
		alias
			"RemoveAt"
		end

	add_range (relations: ARRAY [SYSTEM_DATA_DATARELATION]) is
		external
			"IL signature (System.Data.DataRelation[]): System.Void use System.Data.DataRelationCollection"
		alias
			"AddRange"
		end

	frozen add (relation: SYSTEM_DATA_DATARELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_array_data_column (parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]): SYSTEM_DATA_DATARELATION is
		external
			"IL signature (System.Data.DataColumn[], System.Data.DataColumn[]): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	frozen remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRelationCollection"
		alias
			"Remove"
		end

	add_string_data_column_data_column_boolean (name: STRING; parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN; create_constraints: BOOLEAN): SYSTEM_DATA_DATARELATION is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Data.DataColumn, System.Boolean): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	remove_core (relation: SYSTEM_DATA_DATARELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"RemoveCore"
		end

	add_core (relation: SYSTEM_DATA_DATARELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"AddCore"
		end

	on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataRelationCollection"
		alias
			"OnCollectionChanged"
		end

	on_collection_changing (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataRelationCollection"
		alias
			"OnCollectionChanging"
		end

	get_data_set: SYSTEM_DATA_DATASET is
		external
			"IL deferred signature (): System.Data.DataSet use System.Data.DataRelationCollection"
		alias
			"GetDataSet"
		end

end -- class SYSTEM_DATA_DATARELATIONCOLLECTION
