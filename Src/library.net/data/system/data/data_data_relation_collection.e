indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataRelationCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_DATA_RELATION_COLLECTION

inherit
	DATA_INTERNAL_DATA_COLLECTION_BASE
	ICOLLECTION
	IENUMERABLE

feature -- Access

	get_item (index: INTEGER): DATA_DATA_RELATION is
		external
			"IL deferred signature (System.Int32): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"get_Item"
		end

	get_item_string (name: SYSTEM_STRING): DATA_DATA_RELATION is
		external
			"IL deferred signature (System.String): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataRelationCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataRelationCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	add_string_array_data_column_array_data_column (name: SYSTEM_STRING; parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]): DATA_DATA_RELATION is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_data_column (parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN): DATA_DATA_RELATION is
		external
			"IL signature (System.Data.DataColumn, System.Data.DataColumn): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_string_array_data_column_array_data_column_boolean (name: SYSTEM_STRING; parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; create_constraints: BOOLEAN): DATA_DATA_RELATION is
		external
			"IL signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[], System.Boolean): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_string_data_column_data_column (name: SYSTEM_STRING; parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN): DATA_DATA_RELATION is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Data.DataColumn): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRelationCollection"
		alias
			"Remove"
		end

	add_string_data_column_data_column_boolean (name: SYSTEM_STRING; parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN; create_constraints: BOOLEAN): DATA_DATA_RELATION is
		external
			"IL signature (System.String, System.Data.DataColumn, System.Data.DataColumn, System.Boolean): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	frozen remove_data_relation (relation: DATA_DATA_RELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"Remove"
		end

	index_of (relation: DATA_DATA_RELATION): INTEGER is
		external
			"IL signature (System.Data.DataRelation): System.Int32 use System.Data.DataRelationCollection"
		alias
			"IndexOf"
		end

	clear is
		external
			"IL signature (): System.Void use System.Data.DataRelationCollection"
		alias
			"Clear"
		end

	contains (name: SYSTEM_STRING): BOOLEAN is
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

	add_range (relations: NATIVE_ARRAY [DATA_DATA_RELATION]) is
		external
			"IL signature (System.Data.DataRelation[]): System.Void use System.Data.DataRelationCollection"
		alias
			"AddRange"
		end

	frozen add (relation: DATA_DATA_RELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	add_array_data_column (parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]): DATA_DATA_RELATION is
		external
			"IL signature (System.Data.DataColumn[], System.Data.DataColumn[]): System.Data.DataRelation use System.Data.DataRelationCollection"
		alias
			"Add"
		end

	can_remove (relation: DATA_DATA_RELATION): BOOLEAN is
		external
			"IL signature (System.Data.DataRelation): System.Boolean use System.Data.DataRelationCollection"
		alias
			"CanRemove"
		end

	index_of_string (relation_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.DataRelationCollection"
		alias
			"IndexOf"
		end

feature {NONE} -- Implementation

	remove_core (relation: DATA_DATA_RELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"RemoveCore"
		end

	add_core (relation: DATA_DATA_RELATION) is
		external
			"IL signature (System.Data.DataRelation): System.Void use System.Data.DataRelationCollection"
		alias
			"AddCore"
		end

	on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataRelationCollection"
		alias
			"OnCollectionChanged"
		end

	on_collection_changing (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataRelationCollection"
		alias
			"OnCollectionChanging"
		end

	get_data_set: DATA_DATA_SET is
		external
			"IL deferred signature (): System.Data.DataSet use System.Data.DataRelationCollection"
		alias
			"GetDataSet"
		end

end -- class DATA_DATA_RELATION_COLLECTION
