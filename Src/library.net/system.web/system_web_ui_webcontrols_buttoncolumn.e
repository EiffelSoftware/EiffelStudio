indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ButtonColumn"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_BUTTONCOLUMN

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN
		redefine
			initialize_cell,
			initialize
		end
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_buttoncolumn

feature {NONE} -- Initialization

	frozen make_buttoncolumn is
		external
			"IL creator use System.Web.UI.WebControls.ButtonColumn"
		end

feature -- Access

	get_data_text_format_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_DataTextFormatString"
		end

	get_data_text_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_DataTextField"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_Text"
		end

	get_command_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_CommandName"
		end

	get_button_type: SYSTEM_WEB_UI_WEBCONTROLS_BUTTONCOLUMNTYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ButtonColumnType use System.Web.UI.WebControls.ButtonColumn"
		alias
			"get_ButtonType"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_Text"
		end

	set_data_text_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_DataTextField"
		end

	set_command_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_CommandName"
		end

	set_button_type (value: SYSTEM_WEB_UI_WEBCONTROLS_BUTTONCOLUMNTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ButtonColumnType): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"set_ButtonType"
		end

	set_data_text_format_string (value: STRING) is
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

	initialize_cell (cell: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL; column_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.ButtonColumn"
		alias
			"InitializeCell"
		end

feature {NONE} -- Implementation

	format_data_text_value (data_text_value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.ButtonColumn"
		alias
			"FormatDataTextValue"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_BUTTONCOLUMN
