indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataViewSetting"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_VIEW_SETTING

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_data_view_manager: DATA_DATA_VIEW_MANAGER is
		external
			"IL signature (): System.Data.DataViewManager use System.Data.DataViewSetting"
		alias
			"get_DataViewManager"
		end

	frozen get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataViewSetting"
		alias
			"get_Table"
		end

	frozen get_apply_default_sort: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewSetting"
		alias
			"get_ApplyDefaultSort"
		end

	frozen get_sort: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataViewSetting"
		alias
			"get_Sort"
		end

	frozen get_row_filter: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataViewSetting"
		alias
			"get_RowFilter"
		end

	frozen get_row_state_filter: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL signature (): System.Data.DataViewRowState use System.Data.DataViewSetting"
		alias
			"get_RowStateFilter"
		end

feature -- Element Change

	frozen set_sort (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataViewSetting"
		alias
			"set_Sort"
		end

	frozen set_row_filter (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataViewSetting"
		alias
			"set_RowFilter"
		end

	frozen set_apply_default_sort (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.DataViewSetting"
		alias
			"set_ApplyDefaultSort"
		end

	frozen set_row_state_filter (value: DATA_DATA_VIEW_ROW_STATE) is
		external
			"IL signature (System.Data.DataViewRowState): System.Void use System.Data.DataViewSetting"
		alias
			"set_RowStateFilter"
		end

end -- class DATA_DATA_VIEW_SETTING
