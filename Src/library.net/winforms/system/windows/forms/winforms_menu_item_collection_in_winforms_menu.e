indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Menu+MenuItemCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MENU_ITEM_COLLECTION_IN_WINFORMS_MENU

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
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (owner: WINFORMS_MENU) is
		external
			"IL creator signature (System.Windows.Forms.Menu) use System.Windows.Forms.Menu+MenuItemCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_MENU_ITEM is
		external
			"IL signature (System.Int32): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	add_string_event_handler (caption: SYSTEM_STRING; on_click: EVENT_HANDLER): WINFORMS_MENU_ITEM is
		external
			"IL signature (System.String, System.EventHandler): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Add"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Equals"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Clear"
		end

	add_menu_item (item: WINFORMS_MENU_ITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.MenuItem): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Add"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"ToString"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"GetEnumerator"
		end

	remove (item: WINFORMS_MENU_ITEM) is
		external
			"IL signature (System.Windows.Forms.MenuItem): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Remove"
		end

	frozen contains (value: WINFORMS_MENU_ITEM): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.MenuItem): System.Boolean use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Contains"
		end

	add_range (items: NATIVE_ARRAY [WINFORMS_MENU_ITEM]) is
		external
			"IL signature (System.Windows.Forms.MenuItem[]): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"AddRange"
		end

	add (caption: SYSTEM_STRING): WINFORMS_MENU_ITEM is
		external
			"IL signature (System.String): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Add"
		end

	frozen index_of (value: WINFORMS_MENU_ITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.MenuItem): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"IndexOf"
		end

	add_int32 (index: INTEGER; item: WINFORMS_MENU_ITEM): INTEGER is
		external
			"IL signature (System.Int32, System.Windows.Forms.MenuItem): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"GetHashCode"
		end

	add_string_array_menu_item (caption: SYSTEM_STRING; items: NATIVE_ARRAY [WINFORMS_MENU_ITEM]): WINFORMS_MENU_ITEM is
		external
			"IL signature (System.String, System.Windows.Forms.MenuItem[]): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Add"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.Menu+MenuItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_MENU_ITEM_COLLECTION_IN_WINFORMS_MENU
