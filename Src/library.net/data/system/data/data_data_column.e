indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataColumn"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_COLUMN

inherit
	SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT
		redefine
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ISERVICE_PROVIDER

create
	make_data_data_column_2,
	make_data_data_column_4,
	make_data_data_column,
	make_data_data_column_3,
	make_data_data_column_1

feature {NONE} -- Initialization

	frozen make_data_data_column_2 (column_name: SYSTEM_STRING; data_type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Data.DataColumn"
		end

	frozen make_data_data_column_4 (column_name: SYSTEM_STRING; data_type: TYPE; expr: SYSTEM_STRING; type: DATA_MAPPING_TYPE) is
		external
			"IL creator signature (System.String, System.Type, System.String, System.Data.MappingType) use System.Data.DataColumn"
		end

	frozen make_data_data_column is
		external
			"IL creator use System.Data.DataColumn"
		end

	frozen make_data_data_column_3 (column_name: SYSTEM_STRING; data_type: TYPE; expr: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Type, System.String) use System.Data.DataColumn"
		end

	frozen make_data_data_column_1 (column_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataColumn"
		end

feature -- Access

	frozen get_allow_dbnull: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataColumn"
		alias
			"get_AllowDBNull"
		end

	frozen get_namespace: SYSTEM_STRING is
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

	frozen get_expression: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Expression"
		end

	frozen get_data_type: TYPE is
		external
			"IL signature (): System.Type use System.Data.DataColumn"
		alias
			"get_DataType"
		end

	frozen get_extended_properties: DATA_PROPERTY_COLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataColumn"
		alias
			"get_ExtendedProperties"
		end

	frozen get_column_name: SYSTEM_STRING is
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

	frozen get_caption: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Caption"
		end

	frozen get_default_value: SYSTEM_OBJECT is
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

	frozen get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataColumn"
		alias
			"get_Prefix"
		end

	get_column_mapping: DATA_MAPPING_TYPE is
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

	frozen get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataColumn"
		alias
			"get_Table"
		end

feature -- Element Change

	frozen set_data_type (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Data.DataColumn"
		alias
			"set_DataType"
		end

	set_column_mapping (value: DATA_MAPPING_TYPE) is
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

	frozen set_default_value (value: SYSTEM_OBJECT) is
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

	frozen set_column_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_ColumnName"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
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

	frozen set_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"set_Prefix"
		end

	frozen set_expression (value: SYSTEM_STRING) is
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

	frozen set_caption (value: SYSTEM_STRING) is
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

	to_string: SYSTEM_STRING is
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

	on_property_changing (pcevent: SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataColumn"
		alias
			"OnPropertyChanging"
		end

	frozen raise_property_changing (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumn"
		alias
			"RaisePropertyChanging"
		end

end -- class DATA_DATA_COLUMN
