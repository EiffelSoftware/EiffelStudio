indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListView+ListViewItemCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LIST_VIEW_ITEM_COLLECTION_IN_WINFORMS_LIST_VIEW

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
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
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

	frozen make (owner: WINFORMS_LIST_VIEW) is
		external
			"IL creator signature (System.Windows.Forms.ListView) use System.Windows.Forms.ListView+ListViewItemCollection"
		end

feature -- Access

	get_item (display_index: INTEGER): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (display_index: INTEGER; value: WINFORMS_LIST_VIEW_ITEM) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"RemoveAt"
		end

	remove (item: WINFORMS_LIST_VIEW_ITEM) is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; text: SYSTEM_STRING): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Int32, System.String): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Insert"
		end

	frozen index_of (item: WINFORMS_LIST_VIEW_ITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"IndexOf"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"GetEnumerator"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"GetHashCode"
		end

	add_string_int32 (text: SYSTEM_STRING; image_index: INTEGER): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.String, System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Add"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Equals"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"CopyTo"
		end

	frozen insert_int32_list_view_item (index: INTEGER; item: WINFORMS_LIST_VIEW_ITEM): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Insert"
		end

	frozen contains (item: WINFORMS_LIST_VIEW_ITEM): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Contains"
		end

	add (text: SYSTEM_STRING): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.String): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Add"
		end

	add_list_view_item (value: WINFORMS_LIST_VIEW_ITEM): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Add"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"ToString"
		end

	frozen insert_int32_string_int32 (index: INTEGER; text: SYSTEM_STRING; image_index: INTEGER): WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Int32, System.String, System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Insert"
		end

	frozen add_range (values: NATIVE_ARRAY [WINFORMS_LIST_VIEW_ITEM]) is
		external
			"IL signature (System.Windows.Forms.ListViewItem[]): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (item: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_LIST_VIEW_ITEM_COLLECTION_IN_WINFORMS_LIST_VIEW
