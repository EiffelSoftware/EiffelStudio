indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridColumnCollection"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMNCOLLECTION

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
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRID; columns: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL creator signature (System.Web.UI.WebControls.DataGrid, System.Collections.ArrayList) use System.Web.UI.WebControls.DataGridColumnCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN is
		external
			"IL signature (System.Int32): System.Web.UI.WebControls.DataGridColumn use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"ToString"
		end

	frozen add_at (index: INTEGER; column: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN) is
		external
			"IL signature (System.Int32, System.Web.UI.WebControls.DataGridColumn): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"AddAt"
		end

	frozen add (column: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridColumn): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"Add"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"Clear"
		end

	frozen index_of (column: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN): INTEGER is
		external
			"IL signature (System.Web.UI.WebControls.DataGridColumn): System.Int32 use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"IndexOf"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"RemoveAt"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"Equals"
		end

	frozen remove (column: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMN) is
		external
			"IL signature (System.Web.UI.WebControls.DataGridColumn): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_istate_manager_get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"System.Web.UI.IStateManager.get_IsTrackingViewState"
		end

	frozen system_web_ui_istate_manager_load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"System.Web.UI.IStateManager.LoadViewState"
		end

	frozen system_web_ui_istate_manager_save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"Finalize"
		end

	frozen system_web_ui_istate_manager_track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.DataGridColumnCollection"
		alias
			"System.Web.UI.IStateManager.TrackViewState"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDCOLUMNCOLLECTION
