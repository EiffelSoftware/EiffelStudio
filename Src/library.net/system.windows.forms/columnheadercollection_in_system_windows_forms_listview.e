indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListView+ColumnHeaderCollection"

external class
	COLUMNHEADERCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW

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
			copy_to as system_collections_icollection_copy_to,
			has as system_collections_ilist_contains,
			extend as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
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

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LISTVIEW) is
		external
			"IL creator signature (System.Windows.Forms.ListView) use System.Windows.Forms.ListView+ColumnHeaderCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_COLUMNHEADER is
		external
			"IL signature (System.Int32): System.Windows.Forms.ColumnHeader use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Equals"
		end

	frozen insert_int32_string (index: INTEGER; str: STRING; width: INTEGER; text_align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT) is
		external
			"IL signature (System.Int32, System.String, System.Int32, System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Insert"
		end

	add_string (str: STRING; width: INTEGER; text_align: SYSTEM_WINDOWS_FORMS_HORIZONTALALIGNMENT): SYSTEM_WINDOWS_FORMS_COLUMNHEADER is
		external
			"IL signature (System.String, System.Int32, System.Windows.Forms.HorizontalAlignment): System.Windows.Forms.ColumnHeader use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; value: SYSTEM_WINDOWS_FORMS_COLUMNHEADER) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ColumnHeader): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Insert"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"GetEnumerator"
		end

	remove (column: SYSTEM_WINDOWS_FORMS_COLUMNHEADER) is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_WINDOWS_FORMS_COLUMNHEADER): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Contains"
		end

	add_range (values: ARRAY [SYSTEM_WINDOWS_FORMS_COLUMNHEADER]) is
		external
			"IL signature (System.Windows.Forms.ColumnHeader[]): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"AddRange"
		end

	add (value: SYSTEM_WINDOWS_FORMS_COLUMNHEADER): INTEGER is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Add"
		end

	frozen index_of (value: SYSTEM_WINDOWS_FORMS_COLUMNHEADER): INTEGER is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"IndexOf"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"GetHashCode"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class COLUMNHEADERCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW
