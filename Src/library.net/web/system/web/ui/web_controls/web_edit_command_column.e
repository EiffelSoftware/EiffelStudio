indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.EditCommandColumn"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_EDIT_COMMAND_COLUMN

inherit
	WEB_DATA_GRID_COLUMN
		redefine
			initialize_cell
		end
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create
	make_web_edit_command_column

feature {NONE} -- Initialization

	frozen make_web_edit_command_column is
		external
			"IL creator use System.Web.UI.WebControls.EditCommandColumn"
		end

feature -- Access

	get_cancel_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_CancelText"
		end

	get_button_type: WEB_BUTTON_COLUMN_TYPE is
		external
			"IL signature (): System.Web.UI.WebControls.ButtonColumnType use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_ButtonType"
		end

	get_edit_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_EditText"
		end

	get_update_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"get_UpdateText"
		end

feature -- Element Change

	set_update_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_UpdateText"
		end

	set_edit_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_EditText"
		end

	set_cancel_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_CancelText"
		end

	set_button_type (value: WEB_BUTTON_COLUMN_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.ButtonColumnType): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"set_ButtonType"
		end

feature -- Basic Operations

	initialize_cell (cell: WEB_TABLE_CELL; column_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.EditCommandColumn"
		alias
			"InitializeCell"
		end

end -- class WEB_EDIT_COMMAND_COLUMN
