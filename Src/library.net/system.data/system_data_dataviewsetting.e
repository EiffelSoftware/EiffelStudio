indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataViewSetting"

external class
	SYSTEM_DATA_DATAVIEWSETTING

create {NONE}

feature -- Access

	frozen get_data_view_manager: SYSTEM_DATA_DATAVIEWMANAGER is
		external
			"IL signature (): System.Data.DataViewManager use System.Data.DataViewSetting"
		alias
			"get_DataViewManager"
		end

	frozen get_table: SYSTEM_DATA_DATATABLE is
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

	frozen get_sort: STRING is
		external
			"IL signature (): System.String use System.Data.DataViewSetting"
		alias
			"get_Sort"
		end

	frozen get_row_filter: STRING is
		external
			"IL signature (): System.String use System.Data.DataViewSetting"
		alias
			"get_RowFilter"
		end

	frozen get_row_state_filter: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL signature (): System.Data.DataViewRowState use System.Data.DataViewSetting"
		alias
			"get_RowStateFilter"
		end

feature -- Element Change

	frozen set_sort (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataViewSetting"
		alias
			"set_Sort"
		end

	frozen set_row_filter (value: STRING) is
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

	frozen set_row_state_filter (value: SYSTEM_DATA_DATAVIEWROWSTATE) is
		external
			"IL signature (System.Data.DataViewRowState): System.Void use System.Data.DataViewSetting"
		alias
			"set_RowStateFilter"
		end

end -- class SYSTEM_DATA_DATAVIEWSETTING
