indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.StatusBar+StatusBarPanelCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_STATUS_BAR_PANEL_COLLECTION_IN_WINFORMS_STATUS_BAR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ILIST
		rename
			copy_to as system_collections_icollection_copy_to,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (owner: WINFORMS_STATUS_BAR) is
		external
			"IL creator signature (System.Windows.Forms.StatusBar) use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_STATUS_BAR_PANEL is
		external
			"IL signature (System.Int32): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (index: INTEGER; value: WINFORMS_STATUS_BAR_PANEL) is
		external
			"IL signature (System.Int32, System.Windows.Forms.StatusBarPanel): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	add_status_bar_panel (value: WINFORMS_STATUS_BAR_PANEL): INTEGER is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Add"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Equals"
		end

	insert (index: INTEGER; value: WINFORMS_STATUS_BAR_PANEL) is
		external
			"IL signature (System.Int32, System.Windows.Forms.StatusBarPanel): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Insert"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"ToString"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"GetEnumerator"
		end

	remove (value: WINFORMS_STATUS_BAR_PANEL) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Remove"
		end

	frozen contains (panel: WINFORMS_STATUS_BAR_PANEL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Contains"
		end

	add_range (panels: NATIVE_ARRAY [WINFORMS_STATUS_BAR_PANEL]) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel[]): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"AddRange"
		end

	add (text: SYSTEM_STRING): WINFORMS_STATUS_BAR_PANEL is
		external
			"IL signature (System.String): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Add"
		end

	frozen index_of (panel: WINFORMS_STATUS_BAR_PANEL): INTEGER is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"IndexOf"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"GetHashCode"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (panel: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (panel: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_STATUS_BAR_PANEL_COLLECTION_IN_WINFORMS_STATUS_BAR
