indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.DataGridPagerStyle"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_GRID_PAGER_STYLE

inherit
	WEB_TABLE_ITEM_STYLE
		redefine
			reset,
			merge_with,
			copy_from
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_ISTATE_MANAGER
		rename
			save_view_state as system_web_ui_istate_manager_save_view_state,
			track_view_state as system_web_ui_istate_manager_track_view_state,
			load_view_state as system_web_ui_istate_manager_load_view_state,
			get_is_tracking_view_state as system_web_ui_istate_manager_get_is_tracking_view_state
		end

create {NONE}

feature -- Access

	frozen get_mode: WEB_PAGER_MODE is
		external
			"IL signature (): System.Web.UI.WebControls.PagerMode use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"get_Mode"
		end

	frozen get_prev_page_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"get_PrevPageText"
		end

	frozen get_position: WEB_PAGER_POSITION is
		external
			"IL signature (): System.Web.UI.WebControls.PagerPosition use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"get_Position"
		end

	frozen get_page_button_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"get_PageButtonCount"
		end

	frozen get_next_page_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"get_NextPageText"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"get_Visible"
		end

feature -- Element Change

	frozen set_mode (value: WEB_PAGER_MODE) is
		external
			"IL signature (System.Web.UI.WebControls.PagerMode): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"set_Mode"
		end

	frozen set_position (value: WEB_PAGER_POSITION) is
		external
			"IL signature (System.Web.UI.WebControls.PagerPosition): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"set_Position"
		end

	frozen set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"set_Visible"
		end

	frozen set_next_page_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"set_NextPageText"
		end

	frozen set_page_button_count (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"set_PageButtonCount"
		end

	frozen set_prev_page_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"set_PrevPageText"
		end

feature -- Basic Operations

	reset is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"Reset"
		end

	copy_from (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"CopyFrom"
		end

	merge_with (s: WEB_STYLE) is
		external
			"IL signature (System.Web.UI.WebControls.Style): System.Void use System.Web.UI.WebControls.DataGridPagerStyle"
		alias
			"MergeWith"
		end

end -- class WEB_DATA_GRID_PAGER_STYLE
