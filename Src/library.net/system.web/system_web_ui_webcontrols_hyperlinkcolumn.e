indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.HyperLinkColumn"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_HYPERLINKCOLUMN

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
	make_hyperlinkcolumn

feature {NONE} -- Initialization

	frozen make_hyperlinkcolumn is
		external
			"IL creator use System.Web.UI.WebControls.HyperLinkColumn"
		end

feature -- Access

	get_data_text_format_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataTextFormatString"
		end

	get_target: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_Target"
		end

	get_navigate_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_NavigateUrl"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_Text"
		end

	get_data_text_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataTextField"
		end

	get_data_navigate_url_format_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataNavigateUrlFormatString"
		end

	get_data_navigate_url_field: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"get_DataNavigateUrlField"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_Text"
		end

	set_data_navigate_url_format_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataNavigateUrlFormatString"
		end

	set_data_text_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataTextField"
		end

	set_navigate_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_NavigateUrl"
		end

	set_data_navigate_url_field (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_DataNavigateUrlField"
		end

	set_target (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"set_Target"
		end

	set_data_text_format_string (value: STRING) is
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

	initialize_cell (cell: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL; column_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"InitializeCell"
		end

feature {NONE} -- Implementation

	format_data_navigate_url_value (data_url_value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"FormatDataNavigateUrlValue"
		end

	format_data_text_value (data_text_value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Web.UI.WebControls.HyperLinkColumn"
		alias
			"FormatDataTextValue"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_HYPERLINKCOLUMN
