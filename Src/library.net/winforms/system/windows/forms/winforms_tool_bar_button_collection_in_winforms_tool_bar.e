indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ToolBar+ToolBarButtonCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TOOL_BAR_BUTTON_COLLECTION_IN_WINFORMS_TOOL_BAR

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
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			copy_to as system_collections_icollection_copy_to,
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

	frozen make (owner: WINFORMS_TOOL_BAR) is
		external
			"IL creator signature (System.Windows.Forms.ToolBar) use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_TOOL_BAR_BUTTON is
		external
			"IL signature (System.Int32): System.Windows.Forms.ToolBarButton use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (index: INTEGER; value: WINFORMS_TOOL_BAR_BUTTON) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ToolBarButton): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"ToString"
		end

	frozen add (text: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"GetHashCode"
		end

	frozen insert (index: INTEGER; button: WINFORMS_TOOL_BAR_BUTTON) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ToolBarButton): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Insert"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Clear"
		end

	frozen contains (button: WINFORMS_TOOL_BAR_BUTTON): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ToolBarButton): System.Boolean use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Contains"
		end

	frozen add_range (buttons: NATIVE_ARRAY [WINFORMS_TOOL_BAR_BUTTON]) is
		external
			"IL signature (System.Windows.Forms.ToolBarButton[]): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"AddRange"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Equals"
		end

	frozen add_tool_bar_button (button: WINFORMS_TOOL_BAR_BUTTON): INTEGER is
		external
			"IL signature (System.Windows.Forms.ToolBarButton): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Add"
		end

	frozen index_of (button: WINFORMS_TOOL_BAR_BUTTON): INTEGER is
		external
			"IL signature (System.Windows.Forms.ToolBarButton): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"IndexOf"
		end

	frozen remove (button: WINFORMS_TOOL_BAR_BUTTON) is
		external
			"IL signature (System.Windows.Forms.ToolBarButton): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_index_of (button: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_remove (button: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (button: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (button: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; button: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ToolBar+ToolBarButtonCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_TOOL_BAR_BUTTON_COLLECTION_IN_WINFORMS_TOOL_BAR
