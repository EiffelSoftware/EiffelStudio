indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LIST_VIEW_SUB_ITEM_COLLECTION_IN_WINFORMS_LIST_VIEW_ITEM

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
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
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

	frozen make (owner: WINFORMS_LIST_VIEW_ITEM) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem) use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Int32): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem+ListViewSubItem): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"ToString"
		end

	frozen add_range_array_list_view_sub_item (items: NATIVE_ARRAY [WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM]) is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem[]): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"AddRange"
		end

	frozen add (text: SYSTEM_STRING): WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.String): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Add"
		end

	frozen add_string_color (text: SYSTEM_STRING; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR; font: DRAWING_FONT): WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.String, System.Drawing.Color, System.Drawing.Color, System.Drawing.Font): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Add"
		end

	frozen add_range_array_string_color (items: NATIVE_ARRAY [SYSTEM_STRING]; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR; font: DRAWING_FONT) is
		external
			"IL signature (System.String[], System.Drawing.Color, System.Drawing.Color, System.Drawing.Font): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"AddRange"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"GetHashCode"
		end

	frozen add_list_view_sub_item (item: WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM): WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; item: WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem+ListViewSubItem): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Insert"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Clear"
		end

	frozen contains (sub_item: WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Contains"
		end

	frozen add_range (items: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"AddRange"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Equals"
		end

	frozen index_of (sub_item: WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"IndexOf"
		end

	frozen remove (item: WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM) is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (sub_item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (sub_item: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_LIST_VIEW_SUB_ITEM_COLLECTION_IN_WINFORMS_LIST_VIEW_ITEM
