indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListViewItem+ListViewSubItemCollection"

external class
	LISTVIEWSUBITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			copy_to as system_collections_icollection_copy_to,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			extend as system_collections_ilist_add,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem) use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
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

	frozen set_item (index: INTEGER; value: LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem+ListViewSubItem): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"ToString"
		end

	frozen add_range_array_list_view_sub_item (items: ARRAY [LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM]) is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem[]): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"AddRange"
		end

	frozen add (text: STRING): LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.String): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Add"
		end

	frozen add_string_color (text: STRING; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR; font: SYSTEM_DRAWING_FONT): LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.String, System.Drawing.Color, System.Drawing.Color, System.Drawing.Font): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Add"
		end

	frozen add_range_array_string_color (items: ARRAY [STRING]; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR; font: SYSTEM_DRAWING_FONT) is
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

	frozen add_list_view_sub_item (item: LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Windows.Forms.ListViewItem+ListViewSubItem use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; item: LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem+ListViewSubItem): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Insert"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen contains (sub_item: LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Contains"
		end

	frozen add_range (items: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"AddRange"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"Equals"
		end

	frozen index_of (sub_item: LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.ListViewItem+ListViewSubItem): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"IndexOf"
		end

	frozen remove (item: LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM) is
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

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (sub_item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (item: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
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

	frozen system_collections_ilist_contains (sub_item: ANY): BOOLEAN is
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

	frozen system_collections_ilist_insert (index: INTEGER; item: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListViewItem+ListViewSubItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class LISTVIEWSUBITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
