indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.HyperLinkColumn"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HYPER_LINK_COLUMN

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
	make_web_hyper_link_column

feature {NONE} -- Initialization

	frozen make_web_hyper_link_column is
		external
			"IL creator use System.Web.UI.WebControls.HyperLinkColumn"
		end

feature -- Access

	get_data_text_format_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataTextFormatString"
		end

	get_target: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_Target"
		end

	get_navigate_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_NavigateUrl"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_Text"
		end

	get_data_text_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataTextField"
		end

	get_data_navigate_url_format_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataNavigateUrlFormatString"
		end

	get_data_navigate_url_field: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataNavigateUrlField"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_Text"
		end

	set_data_navigate_url_format_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataNavigateUrlFormatString"
		end

	set_data_text_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataTextField"
		end

	set_navigate_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_NavigateUrl"
		end

	set_data_navigate_url_field (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataNavigateUrlField"
		end

	set_target (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_Target"
		end

	set_data_text_format_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataTextFormatString"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"Initialize"
		end

	initialize_cell (cell: WEB_TABLE_CELL; column_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"InitializeCell"
		end

feature {NONE} -- Implementation

	format_data_navigate_url_value (data_url_value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"FormatDataNavigateUrlValue"
		end

	format_data_text_value (data_text_value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"FormatDataTextValue"
		end

end -- class WEB_HYPER_LINK_COLUMN
