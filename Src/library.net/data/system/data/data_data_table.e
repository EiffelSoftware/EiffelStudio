indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataTable"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_TABLE

inherit
	SYSTEM_DLL_MARSHAL_BY_VALUE_COMPONENT
		redefine
			set_site,
			get_site,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ISERVICE_PROVIDER
	SYSTEM_DLL_ILIST_SOURCE
		rename
			get_list as system_component_model_ilist_source_get_list,
			get_contains_list_collection as system_component_model_ilist_source_get_contains_list_collection
		end
	SYSTEM_DLL_ISUPPORT_INITIALIZE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_data_data_table,
	make_data_data_table_1

feature {NONE} -- Initialization

	frozen make_data_data_table is
		external
			"IL creator use System.Data.DataTable"
		end

	frozen make_data_data_table_1 (table_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataTable"
		end

feature -- Access

	frozen get_primary_key: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataTable"
		alias
			"get_PrimaryKey"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_Namespace"
		end

	frozen get_table_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_TableName"
		end

	frozen get_minimum_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataTable"
		alias
			"get_MinimumCapacity"
		end

	frozen get_parent_relations: DATA_DATA_RELATION_COLLECTION is
		external
			"IL signature (): System.Data.DataRelationCollection use System.Data.DataTable"
		alias
			"get_ParentRelations"
		end

	frozen get_extended_properties: DATA_PROPERTY_COLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataTable"
		alias
			"get_ExtendedProperties"
		end

	frozen get_child_relations: DATA_DATA_RELATION_COLLECTION is
		external
			"IL signature (): System.Data.DataRelationCollection use System.Data.DataTable"
		alias
			"get_ChildRelations"
		end

	frozen get_locale: CULTURE_INFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Data.DataTable"
		alias
			"get_Locale"
		end

	frozen get_default_view: DATA_DATA_VIEW is
		external
			"IL signature (): System.Data.DataView use System.Data.DataTable"
		alias
			"get_DefaultView"
		end

	frozen get_case_sensitive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataTable"
		alias
			"get_CaseSensitive"
		end

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Data.DataTable"
		alias
			"get_Site"
		end

	frozen get_constraints: DATA_CONSTRAINT_COLLECTION is
		external
			"IL signature (): System.Data.ConstraintCollection use System.Data.DataTable"
		alias
			"get_Constraints"
		end

	frozen get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_Prefix"
		end

	frozen get_columns: DATA_DATA_COLUMN_COLLECTION is
		external
			"IL signature (): System.Data.DataColumnCollection use System.Data.DataTable"
		alias
			"get_Columns"
		end

	frozen get_has_errors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataTable"
		alias
			"get_HasErrors"
		end

	frozen get_data_set: DATA_DATA_SET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataTable"
		alias
			"get_DataSet"
		end

	frozen get_display_expression: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_DisplayExpression"
		end

	frozen get_rows: DATA_DATA_ROW_COLLECTION is
		external
			"IL signature (): System.Data.DataRowCollection use System.Data.DataTable"
		alias
			"get_Rows"
		end

feature -- Element Change

	frozen add_row_deleting (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowDeleting"
		end

	frozen remove_row_deleting (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowDeleting"
		end

	frozen remove_row_changed (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowChanged"
		end

	frozen add_row_deleted (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowDeleted"
		end

	frozen remove_column_changed (value: DATA_DATA_COLUMN_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_ColumnChanged"
		end

	frozen add_row_changed (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowChanged"
		end

	frozen set_locale (value: CULTURE_INFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Data.DataTable"
		alias
			"set_Locale"
		end

	frozen set_display_expression (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_DisplayExpression"
		end

	frozen set_minimum_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataTable"
		alias
			"set_MinimumCapacity"
		end

	frozen add_column_changed (value: DATA_DATA_COLUMN_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_ColumnChanged"
		end

	frozen set_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_Prefix"
		end

	frozen set_table_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_TableName"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Data.DataTable"
		alias
			"set_Site"
		end

	frozen add_column_changing (value: DATA_DATA_COLUMN_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_ColumnChanging"
		end

	frozen remove_column_changing (value: DATA_DATA_COLUMN_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_ColumnChanging"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_Namespace"
		end

	frozen set_primary_key (value: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL signature (System.Data.DataColumn[]): System.Void use System.Data.DataTable"
		alias
			"set_PrimaryKey"
		end

	frozen remove_row_deleted (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowDeleted"
		end

	frozen set_case_sensitive (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataTable"
		alias
			"set_CaseSensitive"
		end

	frozen add_row_changing (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowChanging"
		end

	frozen remove_row_changing (value: DATA_DATA_ROW_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowChanging"
		end

feature -- Basic Operations

	frozen copy_: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTable"
		alias
			"Copy"
		end

	frozen select__string (filter_expression: SYSTEM_STRING): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen import_row (row: DATA_DATA_ROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataTable"
		alias
			"ImportRow"
		end

	frozen begin_load_data is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"BeginLoadData"
		end

	frozen select__string_string_data_view_row_state (filter_expression: SYSTEM_STRING; sort: SYSTEM_STRING; record_states: DATA_DATA_VIEW_ROW_STATE): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String, System.String, System.Data.DataViewRowState): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"Clear"
		end

	frozen accept_changes is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"AcceptChanges"
		end

	frozen get_changes_data_row_state (row_states: DATA_DATA_ROW_STATE): DATA_DATA_TABLE is
		external
			"IL signature (System.Data.DataRowState): System.Data.DataTable use System.Data.DataTable"
		alias
			"GetChanges"
		end

	reset is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"Reset"
		end

	frozen load_data_row (values: NATIVE_ARRAY [SYSTEM_OBJECT]; f_accept_changes: BOOLEAN): DATA_DATA_ROW is
		external
			"IL signature (System.Object[], System.Boolean): System.Data.DataRow use System.Data.DataTable"
		alias
			"LoadDataRow"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"BeginInit"
		end

	frozen reject_changes is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"RejectChanges"
		end

	frozen get_changes: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTable"
		alias
			"GetChanges"
		end

	frozen select_: NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen new_row: DATA_DATA_ROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataTable"
		alias
			"NewRow"
		end

	clone_: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTable"
		alias
			"Clone"
		end

	frozen select__string_string (filter_expression: SYSTEM_STRING; sort: SYSTEM_STRING): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String, System.String): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen compute (expression: SYSTEM_STRING; filter: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.Data.DataTable"
		alias
			"Compute"
		end

	frozen end_load_data is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"EndLoadData"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"EndInit"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"ToString"
		end

	frozen get_errors: NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"GetErrors"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DataTable"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	on_column_changed (e: DATA_DATA_COLUMN_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Data.DataColumnChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnColumnChanged"
		end

	new_row_from_builder (builder: DATA_DATA_ROW_BUILDER): DATA_DATA_ROW is
		external
			"IL signature (System.Data.DataRowBuilder): System.Data.DataRow use System.Data.DataTable"
		alias
			"NewRowFromBuilder"
		end

	frozen system_component_model_ilist_source_get_list: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Data.DataTable"
		alias
			"System.ComponentModel.IListSource.GetList"
		end

	on_row_changing (e: DATA_DATA_ROW_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowChanging"
		end

	frozen new_row_array (size: INTEGER): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.Int32): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"NewRowArray"
		end

	on_row_deleted (e: DATA_DATA_ROW_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowDeleted"
		end

	on_property_changing (pcevent: SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.PropertyChangedEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnPropertyChanging"
		end

	frozen system_component_model_ilist_source_get_contains_list_collection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataTable"
		alias
			"System.ComponentModel.IListSource.get_ContainsListCollection"
		end

	get_row_type: TYPE is
		external
			"IL signature (): System.Type use System.Data.DataTable"
		alias
			"GetRowType"
		end

	on_row_changed (e: DATA_DATA_ROW_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowChanged"
		end

	on_row_deleting (e: DATA_DATA_ROW_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowDeleting"
		end

	on_remove_column (column: DATA_DATA_COLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataTable"
		alias
			"OnRemoveColumn"
		end

	on_column_changing (e: DATA_DATA_COLUMN_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.Data.DataColumnChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnColumnChanging"
		end

end -- class DATA_DATA_TABLE
