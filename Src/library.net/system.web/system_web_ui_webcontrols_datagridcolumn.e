indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridColumn"

deferred external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_WEB_UI_ISTATEMANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

feature -- Access

	get_footer_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_FooterStyle"
		end

	get_item_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
		external
			"IL signature (): System.Web.UI.WebControls.TableItemStyle use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_ItemStyle"
		end

	get_header_style: SYSTEM_WEB_UI_WEBCONTROLS_TABLEITEMSTYLE is
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

	get_header_image_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_HeaderImageUrl"
		end

	get_header_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_HeaderText"
		end

	get_footer_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_FooterText"
		end

	get_sort_expression: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_SortExpression"
		end

feature -- Element Change

	set_sort_expression (value: STRING) is
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

	set_header_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_HeaderText"
		end

	set_footer_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"set_FooterText"
		end

	set_header_image_url (value: STRING) is
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

	initialize_cell (cell: SYSTEM_WEB_UI_WEBCONTROLS_TABLECELL; column_index: INTEGER; item_type: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMTYPE) is
		external
			"IL signature (System.Web.UI.WebControls.TableCell, System.Int32, System.Web.UI.WebControls.ListItemType): System.Void use System.Web.UI.WebControls.DataGridColumn"
		alias
			"InitializeCell"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumn"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
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

	load_view_state (saved_state: ANY) is
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

	frozen system_web_ui_istate_manager_save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridColumn"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	frozen get_owner: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRID is
		external
			"IL signature (): System.Web.UI.WebControls.DataGrid use System.Web.UI.WebControls.DataGridColumn"
		alias
			"get_Owner"
		end

	frozen system_web_ui_istate_manager_load_view_state (state: ANY) is
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

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridColumn"
		alias
			"SaveViewState"
		end

	frozen get_view_state: SYSTEM_WEB_UI_STATEBAG is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN
