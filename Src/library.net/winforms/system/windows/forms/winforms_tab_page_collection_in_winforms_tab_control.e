indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TabControl+TabPageCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TAB_PAGE_COLLECTION_IN_WINFORMS_TAB_CONTROL

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
			copy_to as system_collections_icollection_copy_to,
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

	frozen make (owner: WINFORMS_TAB_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.TabControl) use System.Windows.Forms.TabControl+TabPageCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_TAB_PAGE is
		external
			"IL signature (System.Int32): System.Windows.Forms.TabPage use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (index: INTEGER; value: WINFORMS_TAB_PAGE) is
		external
			"IL signature (System.Int32, System.Windows.Forms.TabPage): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"ToString"
		end

	frozen add (value: WINFORMS_TAB_PAGE) is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"GetEnumerator"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Clear"
		end

	frozen contains (page: WINFORMS_TAB_PAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Contains"
		end

	frozen add_range (pages: NATIVE_ARRAY [WINFORMS_TAB_PAGE]) is
		external
			"IL signature (System.Windows.Forms.TabPage[]): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"AddRange"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Equals"
		end

	frozen index_of (page: WINFORMS_TAB_PAGE): INTEGER is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: WINFORMS_TAB_PAGE) is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (page: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (page: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_TAB_PAGE_COLLECTION_IN_WINFORMS_TAB_CONTROL
