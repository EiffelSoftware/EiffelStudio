indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ButtonColumn"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_BUTTON_COLUMN

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
	make_web_button_column

feature {NONE} -- Initialization

	frozen make_web_button_column is
		external
			"IL creator use System.Web.UI.WebControls.ButtonColumn"
		end

feature -- Access

	get_data_text_format_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_DataTextFormatString"
		end

	get_data_text_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_DataTextField"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_Text"
		end

	get_command_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_CommandName"
		end

	get_button_type: WEB_BUTTON_COLUMN_TYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ButtonColumnType use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_ButtonType"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_Text"
		end

	set_data_text_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_DataTextField"
		end

	set_command_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_CommandName"
		end

	set_button_type (value: WEB_BUTTON_COLUMN_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ButtonColumnType): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_ButtonType"
		end

	set_data_text_format_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_DataTextFormatString"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"Initialize"
		end

	initialize_cell (cell: WEB_TABLE_CELL; column_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"InitializeCell"
		end

feature {NONE} -- Implementation

	format_data_text_value (data_text_value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"FormatDataTextValue"
		end

end -- class WEB_BUTTON_COLUMN
