indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.EditCommandColumn"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_EDITCOMMANDCOLUMN

inherit
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN
		redefine
			initialize_cell
		end
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_editcommandcolumn

feature {NONE} -- Initialization

	frozen make_editcommandcolumn is
		external
			"IL creator use System.Web.UI.WebControls.EditCommandColumn"
		end

feature -- Access

	get_cancel_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_CancelText"
		end

	get_button_type: SYSTEM_WEB_UI_WEBCONTROLS_BUTTONCOLUMNTYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ButtonColumnType use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_ButtonType"
		end

	get_edit_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_EditText"
		end

	get_update_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_UpdateText"
		end

feature -- Element Change

	set_update_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_UpdateText"
		end

	set_edit_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_EditText"
		end

	set_cancel_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_CancelText"
		end

	set_button_type (value: SYSTEM_WEB_UI_WEBCONTROLS_BUTTONCOLUMNTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ButtonColumnType): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_ButtonType"
		end

feature -- Basic Operations

	initialize_cell (cell: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL; column_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"InitializeCell"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_EDITCOMMANDCOLUMN
