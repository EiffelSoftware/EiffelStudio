indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataRelation"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_RELATION

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_4 (relation_name: SYSTEM_STRING; parent_table_name: SYSTEM_STRING; child_table_name: SYSTEM_STRING; parent_column_names: NATIVE_ARRAY [SYSTEM_STRING]; child_column_names: NATIVE_ARRAY [SYSTEM_STRING]; nested: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String[], System.String[], System.Boolean) use System.Data.DataRelation"
		end

	frozen make_3 (relation_name: SYSTEM_STRING; parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; create_constraints: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[], System.Boolean) use System.Data.DataRelation"
		end

	frozen make_2 (relation_name: SYSTEM_STRING; parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]; child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]) use System.Data.DataRelation"
		end

	frozen make (relation_name: SYSTEM_STRING; parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Data.DataColumn) use System.Data.DataRelation"
		end

	frozen make_1 (relation_name: SYSTEM_STRING; parent_column: DATA_DATA_COLUMN; child_column: DATA_DATA_COLUMN; create_constraints: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Data.DataColumn, System.Boolean) use System.Data.DataRelation"
		end

feature -- Access

	get_child_key_constraint: DATA_FOREIGN_KEY_CONSTRAINT is
		external
			"IL signature (): System.Data.ForeignKeyConstraint use System.Data.DataRelation"
		alias
			"get_ChildKeyConstraint"
		end

	get_nested: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataRelation"
		alias
			"get_Nested"
		end

	get_data_set: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataRelation"
		alias
			"get_DataSet"
		end

	frozen get_extended_properties: DATA_PROPERTY_COLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataRelation"
		alias
			"get_ExtendedProperties"
		end

	get_child_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataRelation"
		alias
			"get_ChildTable"
		end

	get_parent_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataRelation"
		alias
			"get_ParentTable"
		end

	get_relation_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataRelation"
		alias
			"get_RelationName"
		end

	get_child_columns: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataRelation"
		alias
			"get_ChildColumns"
		end

	get_parent_key_constraint: DATA_UNIQUE_CONSTRAINT is
		external
			"IL signature (): System.Data.UniqueConstraint use System.Data.DataRelation"
		alias
			"get_ParentKeyConstraint"
		end

	get_parent_columns: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataRelation"
		alias
			"get_ParentColumns"
		end

feature -- Element Change

	set_relation_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRelation"
		alias
			"set_RelationName"
		end

	set_nested (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataRelation"
		alias
			"set_Nested"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataRelation"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen check_state_for_property is
		external
			"IL signature (): System.Void use System.Data.DataRelation"
		alias
			"CheckStateForProperty"
		end

	frozen raise_property_changing (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRelation"
		alias
			"RaisePropertyChanging"
		end

	frozen on_property_changing (pcevent: SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataRelation"
		alias
			"OnPropertyChanging"
		end

end -- class DATA_DATA_RELATION
