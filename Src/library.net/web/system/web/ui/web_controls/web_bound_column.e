indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.BoundColumn"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_BOUND_COLUMN

inherit
	WEB_DATA_GRID_COLUMN
		redefine
			initialize_cell,
			initialize
		end
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_web_bound_column

feature {NONE} -- Initialization

	frozen make_web_bound_column is
		external
			"IL creator use System.Web.UI.WebControls.BoundColumn"
		end

feature -- Access

	get_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.BoundColumn"
		alias
			"get_ReadOnly"
		end

	get_data_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"get_DataField"
		end

	get_data_format_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"get_DataFormatString"
		end

	frozen this_expr: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"thisExpr"
		end

feature -- Element Change

	set_read_only (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"set_ReadOnly"
		end

	set_data_format_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"set_DataFormatString"
		end

	set_data_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"set_DataField"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"Initialize"
		end

	initialize_cell (cell: WEB_TABLE_CELL; column_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.BoundColumn"
		alias
			"InitializeCell"
		end

feature {NONE} -- Implementation

	format_data_value (data_value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.BoundColumn"
		alias
			"FormatDataValue"
		end

end -- class WEB_BOUND_COLUMN
