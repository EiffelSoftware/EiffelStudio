indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListView+ColumnHeaderCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_COLUMN_HEADER_COLLECTION_IN_WINFORMS_LIST_VIEW

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

	frozen make (owner: WINFORMS_LIST_VIEW) is
		external
			"IL creator signature (System.Windows.Forms.ListView) use System.Windows.Forms.ListView+ColumnHeaderCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_COLUMN_HEADER is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Equals"
		end

	frozen insert_int32_string (index: INTEGER; str: SYSTEM_STRING; width: INTEGER; text_align: WINFORMS_HORIZONTAL_ALIGNMENT) is
		external
			"IL signature (System.Int32, System.String, System.Int32, System.Windows.Forms.HorizontalAlignment): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Insert"
		end

	add_string (str: SYSTEM_STRING; width: INTEGER; text_align: WINFORMS_HORIZONTAL_ALIGNMENT): WINFORMS_COLUMN_HEADER is
		external
			"IL signature (System.String, System.Int32, System.Windows.Forms.HorizontalAlignment): System.Windows.Forms.ColumnHeader use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; value: WINFORMS_COLUMN_HEADER) is
		external
			"IL signature (System.Int32, System.Windows.Forms.ColumnHeader): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Insert"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"GetEnumerator"
		end

	remove (column: WINFORMS_COLUMN_HEADER) is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Remove"
		end

	frozen contains (value: WINFORMS_COLUMN_HEADER): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Boolean use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Contains"
		end

	add_range (values: NATIVE_ARRAY [WINFORMS_COLUMN_HEADER]) is
		external
			"IL signature (System.Windows.Forms.ColumnHeader[]): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"AddRange"
		end

	add (value: WINFORMS_COLUMN_HEADER): INTEGER is
		external
			"IL signature (System.Windows.Forms.ColumnHeader): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"Add"
		end

	frozen index_of (value: WINFORMS_COLUMN_HEADER): INTEGER is
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

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
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

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
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

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
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

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListView+ColumnHeaderCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_COLUMN_HEADER_COLLECTION_IN_WINFORMS_LIST_VIEW
