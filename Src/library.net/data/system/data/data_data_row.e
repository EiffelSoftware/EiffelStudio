indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataRow"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_ROW

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_item (column: DATA_DATA_COLUMN): SYSTEM_OBJECT is
		external
			"IL signature (System.Data.DataColumn): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataRow"
		alias
			"get_Table"
		end

	frozen get_item_string (column_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_item_array: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Data.DataRow"
		alias
			"get_ItemArray"
		end

	frozen get_item_int32_data_row_version (column_index: INTEGER; version: DATA_DATA_ROW_VERSION): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32, System.Data.DataRowVersion): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_item_string_data_row_version (column_name: SYSTEM_STRING; version: DATA_DATA_ROW_VERSION): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_item_data_column_data_row_version (column: DATA_DATA_COLUMN; version: DATA_DATA_ROW_VERSION): SYSTEM_OBJECT is
		external
			"IL signature (System.Data.DataColumn, System.Data.DataRowVersion): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

	frozen get_row_error: SYSTEM_STRING is
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

	frozen get_row_state: DATA_DATA_ROW_STATE is
		external
			"IL signature (): System.Data.DataRowState use System.Data.DataRow"
		alias
			"get_RowState"
		end

	frozen get_item_int32 (column_index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.DataRow"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_row_error (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataRow"
		alias
			"set_RowError"
		end

	frozen set_item_string (column_name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Data.DataRow"
		alias
			"set_Item"
		end

	frozen set_item_int32 (column_index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Data.DataRow"
		alias
			"set_Item"
		end

	frozen set_item (column: DATA_DATA_COLUMN; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Data.DataColumn, System.Object): System.Void use System.Data.DataRow"
		alias
			"set_Item"
		end

	frozen set_item_array (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Data.DataRow"
		alias
			"set_ItemArray"
		end

feature -- Basic Operations

	frozen has_version (version: DATA_DATA_ROW_VERSION): BOOLEAN is
		external
			"IL signature (System.Data.DataRowVersion): System.Boolean use System.Data.DataRow"
		alias
			"HasVersion"
		end

	frozen get_columns_in_error: NATIVE_ARRAY [DATA_DATA_COLUMN] is
		external
			"IL signature (): System.Data.DataColumn[] use System.Data.DataRow"
		alias
			"GetColumnsInError"
		end

	frozen get_parent_row_data_relation_data_row_version (relation: DATA_DATA_RELATION; version: DATA_DATA_ROW_VERSION): DATA_DATA_ROW is
		external
			"IL signature (System.Data.DataRelation, System.Data.DataRowVersion): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen end_edit is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"EndEdit"
		end

	frozen get_column_error_string (column_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Data.DataRow"
		alias
			"GetColumnError"
		end

	frozen get_child_rows (relation: DATA_DATA_RELATION): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen cancel_edit is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"CancelEdit"
		end

	frozen accept_changes is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"AcceptChanges"
		end

	frozen get_parent_row (relation: DATA_DATA_RELATION): DATA_DATA_ROW is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen set_column_error (column: DATA_DATA_COLUMN; error: SYSTEM_STRING) is
		external
			"IL signature (System.Data.DataColumn, System.String): System.Void use System.Data.DataRow"
		alias
			"SetColumnError"
		end

	frozen get_column_error (column: DATA_DATA_COLUMN): SYSTEM_STRING is
		external
			"IL signature (System.Data.DataColumn): System.String use System.Data.DataRow"
		alias
			"GetColumnError"
		end

	frozen get_parent_rows (relation: DATA_DATA_RELATION): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.Data.DataRelation): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen set_column_error_int32 (column_index: INTEGER; error: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Data.DataRow"
		alias
			"SetColumnError"
		end

	frozen is_null (column: DATA_DATA_COLUMN): BOOLEAN is
		external
			"IL signature (System.Data.DataColumn): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen get_parent_rows_data_relation_data_row_version (relation: DATA_DATA_RELATION; version: DATA_DATA_ROW_VERSION): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.Data.DataRelation, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen get_parent_row_string (relation_name: SYSTEM_STRING): DATA_DATA_ROW is
		external
			"IL signature (System.String): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen begin_edit is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"BeginEdit"
		end

	frozen is_null_int32 (column_index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen delete is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"Delete"
		end

	frozen is_null_data_column_data_row_version (column: DATA_DATA_COLUMN; version: DATA_DATA_ROW_VERSION): BOOLEAN is
		external
			"IL signature (System.Data.DataColumn, System.Data.DataRowVersion): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen get_parent_row_string_data_row_version (relation_name: SYSTEM_STRING; version: DATA_DATA_ROW_VERSION): DATA_DATA_ROW is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Data.DataRow use System.Data.DataRow"
		alias
			"GetParentRow"
		end

	frozen get_child_rows_string (relation_name: SYSTEM_STRING): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen get_child_rows_data_relation_data_row_version (relation: DATA_DATA_RELATION; version: DATA_DATA_ROW_VERSION): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.Data.DataRelation, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen set_parent_row_data_row_data_relation (parent_row: DATA_DATA_ROW; relation: DATA_DATA_RELATION) is
		external
			"IL signature (System.Data.DataRow, System.Data.DataRelation): System.Void use System.Data.DataRow"
		alias
			"SetParentRow"
		end

	frozen is_null_string (column_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.DataRow"
		alias
			"IsNull"
		end

	frozen get_parent_rows_string_data_row_version (relation_name: SYSTEM_STRING; version: DATA_DATA_ROW_VERSION): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen get_child_rows_string_data_row_version (relation_name: SYSTEM_STRING; version: DATA_DATA_ROW_VERSION): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String, System.Data.DataRowVersion): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetChildRows"
		end

	frozen get_column_error_int32 (column_index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.DataRow"
		alias
			"GetColumnError"
		end

	frozen set_column_error_string (column_name: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Data.DataRow"
		alias
			"SetColumnError"
		end

	frozen set_parent_row (parent_row: DATA_DATA_ROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataRow"
		alias
			"SetParentRow"
		end

	frozen get_parent_rows_string (relation_name: SYSTEM_STRING): NATIVE_ARRAY [DATA_DATA_ROW] is
		external
			"IL signature (System.String): System.Data.DataRow[] use System.Data.DataRow"
		alias
			"GetParentRows"
		end

	frozen reject_changes is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"RejectChanges"
		end

	frozen clear_errors is
		external
			"IL signature (): System.Void use System.Data.DataRow"
		alias
			"ClearErrors"
		end

feature {NONE} -- Implementation

	frozen set_null (column: DATA_DATA_COLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataRow"
		alias
			"SetNull"
		end

end -- class DATA_DATA_ROW
