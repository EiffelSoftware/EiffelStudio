indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataGridColumn"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_DATA_GRID_COLUMN

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

feature -- Access

	get_footer_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_FooterStyle"
		end

	get_item_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_ItemStyle"
		end

	get_header_style: WEB_TABLE_ITEM_STYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_HeaderStyle"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_Visible"
		end

	get_header_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_HeaderImageUrl"
		end

	get_header_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_HeaderText"
		end

	get_footer_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_FooterText"
		end

	get_sort_expression: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_SortExpression"
		end

feature -- Element Change

	set_sort_expression (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_SortExpression"
		end

	frozen set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_Visible"
		end

	set_header_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_HeaderText"
		end

	set_footer_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_FooterText"
		end

	set_header_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_HeaderImageUrl"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridColumn"
		alias
			"GetHashCode"
		end

	initialize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"Initialize"
		end

	initialize_cell (cell: WEB_TABLE_CELL; column_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"InitializeCell"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.DataGridColumn"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_istate_manager_get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumn"
		alias
			"System.Web.UI.IStateManager.get_IsTrackingViewState"
		end

	on_column_changed is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"OnColumnChanged"
		end

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"LoadViewState"
		end

	frozen system_web_ui_istate_manager_track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"System.Web.UI.IStateManager.TrackViewState"
		end

	frozen system_web_ui_istate_manager_save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridColumn"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	frozen get_owner: WEB_DATA_GRID is
		external
			"IL signature (): System.Web.UI.WebControls.DataGrid use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_Owner"
		end

	frozen system_web_ui_istate_manager_load_view_state (state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"System.Web.UI.IStateManager.LoadViewState"
		end

	frozen get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_IsTrackingViewState"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridColumn"
		alias
			"SaveViewState"
		end

	frozen get_view_state: WEB_STATE_BAG is
		external
			"IL signature (): System.Web.UI.StateBag use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_ViewState"
		end

	frozen get_design_mode: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_DesignMode"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"Finalize"
		end

	track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"TrackViewState"
		end

end -- class WEB_DATA_GRID_COLUMN
