indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataColumn"

external class
	SYSTEM_DATA_DATACOLUMN

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_ISERVICEPROVIDER
	SYSTEM_COMPONENTMODEL_MARSHALBYVALUECOMPONENT
		redefine
			to_string
		end

create
	make_datacolumn_2,
	make_datacolumn_3,
	make_datacolumn,
	make_datacolumn_1,
	make_datacolumn_4

feature {NONE} -- Initialization

	frozen make_datacolumn_2 (column_name: STRING; data_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Data.DataColumn"
		end

	frozen make_datacolumn_3 (column_name: STRING; data_type: SYSTEM_TYPE; expr: STRING) is
		external
			"IL creator signature (System.String, System.Type, System.String) use System.Data.DataColumn"
		end

	frozen make_datacolumn is
		external
			"IL creator use System.Data.DataColumn"
		end

	frozen make_datacolumn_1 (column_name: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataColumn"
		end

	frozen make_datacolumn_4 (column_name: STRING; data_type: SYSTEM_TYPE; expr: STRING; type: SYSTEM_DATA_MAPPINGTYPE) is
		external
			"IL creator signature (System.String, System.Type, System.String, System.Data.MappingType) use System.Data.DataColumn"
		end

feature -- Access

	frozen get_allow_dbnull: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataColumn"
		alias
			"get_AllowDBNull"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Namespace"
		end

	frozen get_auto_increment: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataColumn"
		alias
			"get_AutoIncrement"
		end

	frozen get_unique: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataColumn"
		alias
			"get_Unique"
		end

	frozen get_ordinal: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataColumn"
		alias
			"get_Ordinal"
		end

	frozen get_expression: STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Expression"
		end

	frozen get_data_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Data.DataColumn"
		alias
			"get_DataType"
		end

	frozen get_extended_properties: SYSTEM_DATA_PROPERTYCOLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataColumn"
		alias
			"get_ExtendedProperties"
		end

	frozen get_column_name: STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_ColumnName"
		end

	frozen get_auto_increment_seed: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Data.DataColumn"
		alias
			"get_AutoIncrementSeed"
		end

	frozen get_caption: STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Caption"
		end

	frozen get_default_value: ANY is
		external
			"IL signature (): System.Object use System.Data.DataColumn"
		alias
			"get_DefaultValue"
		end

	frozen get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataColumn"
		alias
			"get_ReadOnly"
		end

	frozen get_prefix: STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Prefix"
		end

	get_column_mapping: SYSTEM_DATA_MAPPINGTYPE is
		external
			"IL signature (): System.Data.MappingType use System.Data.DataColumn"
		alias
			"get_ColumnMapping"
		end

	frozen get_auto_increment_step: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Data.DataColumn"
		alias
			"get_AutoIncrementStep"
		end

	frozen get_max_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataColumn"
		alias
			"get_MaxLength"
		end

	frozen get_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataColumn"
		alias
			"get_Table"
		end

feature -- Element Change

	frozen set_data_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Data.DataColumn"
		alias
			"set_DataType"
		end

	set_column_mapping (value: SYSTEM_DATA_MAPPINGTYPE) is
		external
			"IL signature (System.Data.MappingType): System.Void use System.Data.DataColumn"
		alias
			"set_ColumnMapping"
		end

	frozen set_auto_increment (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataColumn"
		alias
			"set_AutoIncrement"
		end

	frozen set_default_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.DataColumn"
		alias
			"set_DefaultValue"
		end

	frozen set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataColumn"
		alias
			"set_ReadOnly"
		end

	frozen set_column_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_ColumnName"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_Namespace"
		end

	frozen set_max_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataColumn"
		alias
			"set_MaxLength"
		end

	frozen set_unique (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataColumn"
		alias
			"set_Unique"
		end

	frozen set_prefix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_Prefix"
		end

	frozen set_expression (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_Expression"
		end

	frozen set_auto_increment_step (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Data.DataColumn"
		alias
			"set_AutoIncrementStep"
		end

	frozen set_allow_dbnull (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataColumn"
		alias
			"set_AllowDBNull"
		end

	frozen set_caption (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_Caption"
		end

	frozen set_auto_increment_seed (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Data.DataColumn"
		alias
			"set_AutoIncrementSeed"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	frozen check_not_allow_null is
		external
			"IL signature (): System.Void use System.Data.DataColumn"
		alias
			"CheckNotAllowNull"
		end

	frozen check_unique is
		external
			"IL signature (): System.Void use System.Data.DataColumn"
		alias
			"CheckUnique"
		end

	on_property_changing (pcevent: SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataColumn"
		alias
			"OnPropertyChanging"
		end

	frozen raise_property_changing (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"RaisePropertyChanging"
		end

end -- class SYSTEM_DATA_DATACOLUMN
