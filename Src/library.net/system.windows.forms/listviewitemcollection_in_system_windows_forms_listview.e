indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListView+ListViewItemCollection"

external class
	LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW

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
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LISTVIEW) is
		external
			"IL creator signature (System.Windows.Forms.ListView) use System.Windows.Forms.ListView+ListViewItemCollection"
		end

feature -- Access

	get_item (display_index: INTEGER): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
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

	set_item (display_index: INTEGER; value: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"RemoveAt"
		end

	remove (item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM) is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; text: STRING): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Int32, System.String): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Insert"
		end

	frozen index_of (item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): INTEGER is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"IndexOf"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	add_string_int32 (text: STRING; image_index: INTEGER): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.String, System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Add"
		end

	is_equal (obj: ANY): BOOLEAN is
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

	frozen insert_int32_list_view_item (index: INTEGER; item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Int32, System.Windows.Forms.ListViewItem): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Insert"
		end

	frozen contains (item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Boolean use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Contains"
		end

	add (text: STRING): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.String): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Add"
		end

	add_list_view_item (value: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Windows.Forms.ListViewItem): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Add"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"ToString"
		end

	frozen insert_int32_string_int32 (index: INTEGER; text: STRING; image_index: INTEGER): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Int32, System.String, System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"Insert"
		end

	frozen add_range (values: ARRAY [SYSTEM_WINDOWS_FORMS_LISTVIEWITEM]) is
		external
			"IL signature (System.Windows.Forms.ListViewItem[]): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"AddRange"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (item: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
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

	frozen system_collections_ilist_contains (item: ANY): BOOLEAN is
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

	frozen system_collections_ilist_insert (index: INTEGER; item: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ListViewItemCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
