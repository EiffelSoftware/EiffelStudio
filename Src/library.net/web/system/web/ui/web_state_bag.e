indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.StateBag"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_STATE_BAG

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
	IDICTIONARY
		rename
			copy_to as system_collections_icollection_copy_to,
			get_enumerator as system_collections_ienumerable_get_enumerator,
			contains as system_collections_idictionary_contains,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_read_only as system_collections_idictionary_get_is_read_only,
			get_is_fixed_size as system_collections_idictionary_get_is_fixed_size,
			remove as system_collections_idictionary_remove,
			add as system_collections_idictionary_add,
			set_item as system_collections_idictionary_set_item,
			get_item as system_collections_idictionary_get_item
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.StateBag"
		end

	frozen make_1 (ignore_case: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.StateBag"
		end

feature -- Access

	frozen get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Web.UI.StateBag"
		alias
			"get_Values"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.StateBag"
		alias
			"get_Count"
		end

	frozen get_item (key: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.UI.StateBag"
		alias
			"get_Item"
		end

	frozen get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Web.UI.StateBag"
		alias
			"get_Keys"
		end

feature -- Element Change

	frozen set_item (key: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.UI.StateBag"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.StateBag"
		alias
			"ToString"
		end

	frozen add (key: SYSTEM_STRING; value: SYSTEM_OBJECT): WEB_STATE_ITEM is
		external
			"IL signature (System.String, System.Object): System.Web.UI.StateItem use System.Web.UI.StateBag"
		alias
			"Add"
		end

	frozen get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Web.UI.StateBag"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.StateBag"
		alias
			"Clear"
		end

	frozen is_item_dirty (key: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Web.UI.StateBag"
		alias
			"IsItemDirty"
		end

	frozen set_item_dirty (key: SYSTEM_STRING; dirty: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.UI.StateBag"
		alias
			"SetItemDirty"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.StateBag"
		alias
			"Equals"
		end

	frozen remove (key: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.StateBag"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.StateBag"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.StateBag"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.StateBag"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_idictionary_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.get_IsReadOnly"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.StateBag"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_web_ui_istate_manager_track_view_state is
		external
			"IL signature (): System.Void use System.Web.UI.StateBag"
		alias
			"System.Web.UI.IStateManager.TrackViewState"
		end

	frozen system_collections_idictionary_remove (key: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.Remove"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.StateBag"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_idictionary_contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.Contains"
		end

	frozen system_web_ui_istate_manager_load_view_state (state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.StateBag"
		alias
			"System.Web.UI.IStateManager.LoadViewState"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.StateBag"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_idictionary_set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.set_Item"
		end

	frozen system_collections_idictionary_add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.Add"
		end

	frozen system_collections_idictionary_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.get_IsFixedSize"
		end

	frozen system_collections_idictionary_get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Web.UI.StateBag"
		alias
			"System.Collections.IDictionary.get_Item"
		end

	frozen system_web_ui_istate_manager_save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.StateBag"
		alias
			"System.Web.UI.IStateManager.SaveViewState"
		end

	frozen system_web_ui_istate_manager_get_is_tracking_view_state: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.StateBag"
		alias
			"System.Web.UI.IStateManager.get_IsTrackingViewState"
		end

end -- class WEB_STATE_BAG
