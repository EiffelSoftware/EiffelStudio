indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ListItemCollection"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMCOLLECTION

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
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove as system_collections_ilist_remove,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			extend as system_collections_ilist_add,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.WebControls.ListItemCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM is
		external
			"IL signature (System.Int32): System.Web.UI.WebControls.ListItem use System.Web.UI.WebControls.ListItemCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.ListItemCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.ListItemCollection"
		alias
			"get_Count"
		end

	frozen get_capacity: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.ListItemCollection"
		alias
			"get_Capacity"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen set_capacity (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"set_Capacity"
		end

feature -- Basic Operations

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"RemoveAt"
		end

	frozen remove (item: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM) is
		external
			"IL signature (System.Web.UI.WebControls.ListItem): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Remove"
		end

	frozen find_by_value (value: STRING): SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM is
		external
			"IL signature (System.String): System.Web.UI.WebControls.ListItem use System.Web.UI.WebControls.ListItemCollection"
		alias
			"FindByValue"
		end

	frozen index_of (item: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM): INTEGER is
		external
			"IL signature (System.Web.UI.WebControls.ListItem): System.Int32 use System.Web.UI.WebControls.ListItemCollection"
		alias
			"IndexOf"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Equals"
		end

	frozen add (item: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM) is
		external
			"IL signature (System.Web.UI.WebControls.ListItem): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Clear"
		end

	frozen add_string (item: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Add"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"CopyTo"
		end

	frozen find_by_text (text: STRING): SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM is
		external
			"IL signature (System.String): System.Web.UI.WebControls.ListItem use System.Web.UI.WebControls.ListItemCollection"
		alias
			"FindByText"
		end

	frozen insert_int32_string (index: INTEGER; item: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Insert"
		end

	frozen contains (item: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM): BOOLEAN is
		external
			"IL signature (System.Web.UI.WebControls.ListItem): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Contains"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.ListItemCollection"
		alias
			"GetEnumerator"
		end

	frozen insert (index: INTEGER; item: SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM) is
		external
			"IL signature (System.Int32, System.Web.UI.WebControls.ListItem): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Insert"
		end

	frozen remove_string (item: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Remove"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.ListItemCollection"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.ListItemCollection"
		alias
			"GetHashCode"
		end

	frozen add_range (items: ARRAY [SYSTEM_WEB_UI_WEBCONTROLS_LISTITEM]) is
		external
			"IL signature (System.Web.UI.WebControls.ListItem[]): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_web_ui_istate_manager_get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Web.UI.IStateManager.get_IsTrackingViewState"
		end

	frozen system_collections_ilist_add (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_ilist_contains (item: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_index_of (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_web_ui_istate_manager_track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Web.UI.IStateManager.TrackViewState"
		end

	frozen system_web_ui_istate_manager_save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	frozen system_web_ui_istate_manager_load_view_state (state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Web.UI.IStateManager.LoadViewState"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_remove (item: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; item: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.UI.WebControls.ListItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMCOLLECTION
