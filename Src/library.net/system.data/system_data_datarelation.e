indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRelation"

external class
	SYSTEM_DATA_DATARELATION

inherit
	ANY
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

	frozen make_4 (relation_name: STRING; parent_table_name: STRING; child_table_name: STRING; parent_column_names: ARRAY [STRING]; child_column_names: ARRAY [STRING]; nested: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String[], System.String[], System.Boolean) use System.Data.DataRelation"
		end

	frozen make_3 (relation_name: STRING; parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; create_constraints: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[], System.Boolean) use System.Data.DataRelation"
		end

	frozen make_2 (relation_name: STRING; parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]; child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL creator signature (System.String, System.Data.DataColumn[], System.Data.DataColumn[]) use System.Data.DataRelation"
		end

	frozen make (relation_name: STRING; parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Data.DataColumn) use System.Data.DataRelation"
		end

	frozen make_1 (relation_name: STRING; parent_column: SYSTEM_DATA_DATACOLUMN; child_column: SYSTEM_DATA_DATACOLUMN; create_constraints: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Data.DataColumn, System.Data.DataColumn, System.Boolean) use System.Data.DataRelation"
		end

feature -- Access

	get_child_key_constraint: SYSTEM_DATA_FOREIGNKEYCONSTRAINT is
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

	get_data_set: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataRelation"
		alias
			"get_DataSet"
		end

	frozen get_extended_properties: SYSTEM_DATA_PROPERTYCOLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataRelation"
		alias
			"get_ExtendedProperties"
		end

	get_child_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataRelation"
		alias
			"get_ChildTable"
		end

	get_parent_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataRelation"
		alias
			"get_ParentTable"
		end

	get_relation_name: STRING is
		external
			"IL signature (): System.String use System.Data.DataRelation"
		alias
			"get_RelationName"
		end

	get_child_columns: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataRelation"
		alias
			"get_ChildColumns"
		end

	get_parent_key_constraint: SYSTEM_DATA_UNIQUECONSTRAINT is
		external
			"IL signature (): System.Data.UniqueConstraint use System.Data.DataRelation"
		alias
			"get_ParentKeyConstraint"
		end

	get_parent_columns: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataRelation"
		alias
			"get_ParentColumns"
		end

feature -- Element Change

	set_relation_name (value: STRING) is
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

	to_string: STRING is
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

	frozen raise_property_changing (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRelation"
		alias
			"RaisePropertyChanging"
		end

	frozen on_property_changing (pcevent: SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataRelation"
		alias
			"OnPropertyChanging"
		end

end -- class SYSTEM_DATA_DATARELATION
