indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataTable"

external class
	SYSTEM_DATA_DATATABLE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ILISTSOURCE
		rename
			get_list as system_component_model_ilist_source_get_list,
			get_contains_list_collection as system_component_model_ilist_source_get_contains_list_collection
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE
	SYSTEM_ISERVICEPROVIDER
	SYSTEM_COMPONENTMODEL_MARSHALBYVALUECOMPONENT
		redefine
			set_site,
			get_site,
			to_string
		end

create
	make_datatable,
	make_datatable_1

feature {NONE} -- Initialization

	frozen make_datatable is
		external
			"IL creator use System.Data.DataTable"
		end

	frozen make_datatable_1 (table_name: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataTable"
		end

feature -- Access

	frozen get_primary_key: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataTable"
		alias
			"get_PrimaryKey"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_Namespace"
		end

	frozen get_table_name: STRING is
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

	frozen get_parent_relations: SYSTEM_DATA_DATARELATIONCOLLECTION is
		external
			"IL signature (): System.Data.DataRelationCollection use System.Data.DataTable"
		alias
			"get_ParentRelations"
		end

	frozen get_extended_properties: SYSTEM_DATA_PROPERTYCOLLECTION is
		external
			"IL signature (): System.Data.PropertyCollection use System.Data.DataTable"
		alias
			"get_ExtendedProperties"
		end

	frozen get_child_relations: SYSTEM_DATA_DATARELATIONCOLLECTION is
		external
			"IL signature (): System.Data.DataRelationCollection use System.Data.DataTable"
		alias
			"get_ChildRelations"
		end

	frozen get_locale: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL signature (): System.Globalization.CultureInfo use System.Data.DataTable"
		alias
			"get_Locale"
		end

	frozen get_default_view: SYSTEM_DATA_DATAVIEW is
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

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Data.DataTable"
		alias
			"get_Site"
		end

	frozen get_constraints: SYSTEM_DATA_CONSTRAINTCOLLECTION is
		external
			"IL signature (): System.Data.ConstraintCollection use System.Data.DataTable"
		alias
			"get_Constraints"
		end

	frozen get_prefix: STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_Prefix"
		end

	frozen get_columns: SYSTEM_DATA_DATACOLUMNCOLLECTION is
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

	frozen get_data_set: SYSTEM_DATA_DATASET is
		external
			"IL signature (): System.Data.DataSet use System.Data.DataTable"
		alias
			"get_DataSet"
		end

	frozen get_display_expression: STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"get_DisplayExpression"
		end

	frozen get_rows: SYSTEM_DATA_DATAROWCOLLECTION is
		external
			"IL signature (): System.Data.DataRowCollection use System.Data.DataTable"
		alias
			"get_Rows"
		end

feature -- Element Change

	frozen add_row_deleting (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowDeleting"
		end

	frozen remove_row_deleting (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowDeleting"
		end

	frozen remove_row_changed (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowChanged"
		end

	frozen add_row_deleted (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowDeleted"
		end

	frozen remove_column_changed (value: SYSTEM_DATA_DATACOLUMNCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_ColumnChanged"
		end

	frozen add_row_changed (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowChanged"
		end

	frozen set_locale (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL signature (System.Globalization.CultureInfo): System.Void use System.Data.DataTable"
		alias
			"set_Locale"
		end

	frozen set_display_expression (value: STRING) is
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

	frozen add_column_changed (value: SYSTEM_DATA_DATACOLUMNCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_ColumnChanged"
		end

	frozen set_prefix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_Prefix"
		end

	frozen set_table_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_TableName"
		end

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Data.DataTable"
		alias
			"set_Site"
		end

	frozen add_column_changing (value: SYSTEM_DATA_DATACOLUMNCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_ColumnChanging"
		end

	frozen remove_column_changing (value: SYSTEM_DATA_DATACOLUMNCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataColumnChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_ColumnChanging"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTable"
		alias
			"set_Namespace"
		end

	frozen set_primary_key (value: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL signature (System.Data.DataColumn[]): System.Void use System.Data.DataTable"
		alias
			"set_PrimaryKey"
		end

	frozen remove_row_deleted (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
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

	frozen add_row_changing (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"add_RowChanging"
		end

	frozen remove_row_changing (value: SYSTEM_DATA_DATAROWCHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.DataRowChangeEventHandler): System.Void use System.Data.DataTable"
		alias
			"remove_RowChanging"
		end

feature -- Basic Operations

	frozen select__string (filter_expression: STRING): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen import_row (row: SYSTEM_DATA_DATAROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataTable"
		alias
			"ImportRow"
		end

	frozen select__string_string_data_view_row_state (filter_expression: STRING; sort: STRING; record_states: SYSTEM_DATA_DATAVIEWROWSTATE): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String, System.String, System.Data.DataViewRowState): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen clone: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTable"
		alias
			"Clone"
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

	frozen end_init is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"EndInit"
		end

	reset is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"Reset"
		end

	frozen get_changes_data_row_state (row_states: SYSTEM_DATA_DATAROWSTATE): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.Data.DataRowState): System.Data.DataTable use System.Data.DataTable"
		alias
			"GetChanges"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"BeginInit"
		end

	frozen copy: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTable"
		alias
			"Copy"
		end

	frozen load_data_row (values: ARRAY [ANY]; f_accept_changes: BOOLEAN): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Object[], System.Boolean): System.Data.DataRow use System.Data.DataTable"
		alias
			"LoadDataRow"
		end

	frozen Select_: ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen get_changes: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTable"
		alias
			"GetChanges"
		end

	frozen compute (expression: STRING; filter: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.Data.DataTable"
		alias
			"Compute"
		end

	frozen new_row: SYSTEM_DATA_DATAROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataTable"
		alias
			"NewRow"
		end

	frozen reject_changes is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"RejectChanges"
		end

	frozen select__string_string (filter_expression: STRING; sort: STRING): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String, System.String): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"Select"
		end

	frozen end_load_data is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"EndLoadData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.DataTable"
		alias
			"ToString"
		end

	frozen get_errors: ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"GetErrors"
		end

	frozen begin_load_data is
		external
			"IL signature (): System.Void use System.Data.DataTable"
		alias
			"BeginLoadData"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DataTable"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	on_column_changed (e: SYSTEM_DATA_DATACOLUMNCHANGEEVENTARGS) is
		external
			"IL signature (System.Data.DataColumnChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnColumnChanged"
		end

	new_row_from_builder (builder: SYSTEM_DATA_DATAROWBUILDER): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Data.DataRowBuilder): System.Data.DataRow use System.Data.DataTable"
		alias
			"NewRowFromBuilder"
		end

	frozen system_component_model_ilist_source_get_list: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Data.DataTable"
		alias
			"System.ComponentModel.IListSource.GetList"
		end

	on_row_changing (e: SYSTEM_DATA_DATAROWCHANGEEVENTARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowChanging"
		end

	frozen new_row_array (size: INTEGER): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.Int32): System.Data.DataRow[] use System.Data.DataTable"
		alias
			"NewRowArray"
		end

	on_row_deleted (e: SYSTEM_DATA_DATAROWCHANGEEVENTARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowDeleted"
		end

	has_schema_changed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataTable"
		alias
			"HasSchemaChanged"
		end

	on_property_changing (pcevent: SYSTEM_COMPONENTMODEL_PROPERTYCHANGEDEVENTARGS) is
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

	get_row_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Data.DataTable"
		alias
			"GetRowType"
		end

	on_row_changed (e: SYSTEM_DATA_DATAROWCHANGEEVENTARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowChanged"
		end

	on_row_deleting (e: SYSTEM_DATA_DATAROWCHANGEEVENTARGS) is
		external
			"IL signature (System.Data.DataRowChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnRowDeleting"
		end

	on_remove_column (column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataTable"
		alias
			"OnRemoveColumn"
		end

	on_column_changing (e: SYSTEM_DATA_DATACOLUMNCHANGEEVENTARGS) is
		external
			"IL signature (System.Data.DataColumnChangeEventArgs): System.Void use System.Data.DataTable"
		alias
			"OnColumnChanging"
		end

end -- class SYSTEM_DATA_DATATABLE
