indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRow"

external class
	SYSTEM_DATA_DATAROW

create {NONE}

feature -- Access

	frozen get_item (column: SYSTEM_DATA_DATACOLUMN): ANY is
		external
			"IL signature (System.Data.DataColumn): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataRow"
		alias
			"get_Table"
		end

	frozen get_item_string (column_name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_item_array: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Data.DataRow"
		alias
			"get_ItemArray"
		end

	frozen get_item_int32_data_row_version (column_index: INTEGER; version: SYSTEM_DATA_DATAROWVERSION): ANY is
		external
			"IL signature (System.Int32, System.Data.DataRowVersion): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_item_string_data_row_version (column_name: STRING; version: SYSTEM_DATA_DATAROWVERSION): ANY is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_item_data_column_data_row_version (column: SYSTEM_DATA_DATACOLUMN; version: SYSTEM_DATA_DATAROWVERSION): ANY is
		external
			"IL signature (System.Data.DataColumn, System.Data.DataRowVersion): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_row_error: STRING is
		external
			"IL signature (): System.String use System.Data.DataRow"
		alias
			"get_RowError"
		end

	frozen get_has_errors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataRow"
		alias
			"get_HasErrors"
		end

	frozen get_row_state: SYSTEM_DATA_DATAROWSTATE is
		external
			"IL signature (): System.Data.DataRowState use System.Data.DataRow"
		alias
			"get_RowState"
		end

	frozen get_item_int32 (column_index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_row_error (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRow"
		alias
			"set_RowError"
		end

	frozen set_item_string (column_name: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.DataRow"
		alias
			"set_Item"
		end

	frozen set_item_int32 (column_index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataRow"
		alias
			"set_Item"
		end

	frozen set_item (column: SYSTEM_DATA_DATACOLUMN; value: ANY) is
		external
			"IL signature (System.Data.DataColumn, System.Object): System.Void use System.Data.DataRow"
		alias
			"set_Item"
		end

	frozen set_item_array (value: ARRAY [ANY]) is
		external
			"IL signature (System.Object[]): System.Void use System.Data.DataRow"
		alias
			"set_ItemArray"
		end

feature -- Basic Operations

	frozen is_null_int32 (column_index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen get_column_error_string (column_name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Data.DataRow"
		alias
			"GetColumnError"
		end

	frozen get_child_rows_data_relation_data_row_version (relation: SYSTEM_DATA_DATARELATION; version: SYSTEM_DATA_DATAROWVERSION): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.Data.DataRelation, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen get_parent_row_data_relation_data_row_version (relation: SYSTEM_DATA_DATARELATION; version: SYSTEM_DATA_DATAROWVERSION): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Data.DataRelation, System.Data.DataRowVersion): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen get_child_rows (relation: SYSTEM_DATA_DATARELATION): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen set_column_error (column: SYSTEM_DATA_DATACOLUMN; error: STRING) is
		external
			"IL signature (System.Data.DataColumn, System.String): System.Void use System.Data.DataRow"
		alias
			"SetColumnError"
		end

	frozen cancel_edit is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"CancelEdit"
		end

	frozen begin_edit is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"BeginEdit"
		end

	frozen delete is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"Delete"
		end

	frozen end_edit is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"EndEdit"
		end

	frozen get_child_rows_string (relation_name: STRING): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen set_column_error_string (column_name: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Data.DataRow"
		alias
			"SetColumnError"
		end

	frozen get_parent_row_string_data_row_version (relation_name: STRING; version: SYSTEM_DATA_DATAROWVERSION): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen reject_changes is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"RejectChanges"
		end

	frozen get_parent_row (relation: SYSTEM_DATA_DATARELATION): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen get_columns_in_error: ARRAY [SYSTEM_DATA_DATACOLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataRow"
		alias
			"GetColumnsInError"
		end

	frozen get_child_rows_string_data_row_version (relation_name: STRING; version: SYSTEM_DATA_DATAROWVERSION): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen is_null_string (column_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen get_parent_rows_string_data_row_version (relation_name: STRING; version: SYSTEM_DATA_DATAROWVERSION): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen get_parent_rows_data_relation_data_row_version (relation: SYSTEM_DATA_DATARELATION; version: SYSTEM_DATA_DATAROWVERSION): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.Data.DataRelation, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen set_unspecified (column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataRow"
		alias
			"SetUnspecified"
		end

	frozen get_parent_rows (relation: SYSTEM_DATA_DATARELATION): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen get_column_error (column: SYSTEM_DATA_DATACOLUMN): STRING is
		external
			"IL signature (System.Data.DataColumn): System.String use System.Data.DataRow"
		alias
			"GetColumnError"
		end

	frozen has_version (version: SYSTEM_DATA_DATAROWVERSION): BOOLEAN is
		external
			"IL signature (System.Data.DataRowVersion): System.Boolean use System.Data.DataRow"
		alias
			"HasVersion"
		end

	frozen get_column_error_int32 (column_index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.DataRow"
		alias
			"GetColumnError"
		end

	frozen is_null_data_column_data_row_version (column: SYSTEM_DATA_DATACOLUMN; version: SYSTEM_DATA_DATAROWVERSION): BOOLEAN is
		external
			"IL signature (System.Data.DataColumn, System.Data.DataRowVersion): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen clear_errors is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"ClearErrors"
		end

	frozen get_parent_row_string (relation_name: STRING): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.String): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen set_parent_row_data_row_data_relation (parent_row: SYSTEM_DATA_DATAROW; relation: SYSTEM_DATA_DATARELATION) is
		external
			"IL signature (System.Data.DataRow, System.Data.DataRelation): System.Void use System.Data.DataRow"
		alias
			"SetParentRow"
		end

	frozen set_parent_row (parent_row: SYSTEM_DATA_DATAROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataRow"
		alias
			"SetParentRow"
		end

	frozen get_parent_rows_string (relation_name: STRING): ARRAY [SYSTEM_DATA_DATAROW] is
		external
			"IL signature (System.String): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen is_null (column: SYSTEM_DATA_DATACOLUMN): BOOLEAN is
		external
			"IL signature (System.Data.DataColumn): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen accept_changes is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"AcceptChanges"
		end

	frozen set_column_error_int32 (column_index: INTEGER; error: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Data.DataRow"
		alias
			"SetColumnError"
		end

feature {NONE} -- Implementation

	frozen set_null (column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataRow"
		alias
			"SetNull"
		end

end -- class SYSTEM_DATA_DATAROW
