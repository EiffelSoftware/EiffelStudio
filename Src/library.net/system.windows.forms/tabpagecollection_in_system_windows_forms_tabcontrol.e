indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TabControl+TabPageCollection"

external class
	TABPAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_TABCONTROL

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
			remove as ilist_remove,
			copy_to as icollection_copy_to,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			extend as ilist_extend,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_TABCONTROL) is
		external
			"IL creator signature (System.Windows.Forms.TabControl) use System.Windows.Forms.TabControl+TabPageCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_TABPAGE is
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

	put_i_th (index: INTEGER; value: SYSTEM_WINDOWS_FORMS_TABPAGE) is
		external
			"IL signature (System.Int32, System.Windows.Forms.TabPage): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"ToString"
		end

	frozen extend (value: SYSTEM_WINDOWS_FORMS_TABPAGE) is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen has (page: SYSTEM_WINDOWS_FORMS_TABPAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Contains"
		end

	frozen add_range (pages: ARRAY [SYSTEM_WINDOWS_FORMS_TABPAGE]) is
		external
			"IL signature (System.Windows.Forms.TabPage[]): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"AddRange"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Equals"
		end

	frozen index_of (page: SYSTEM_WINDOWS_FORMS_TABPAGE): INTEGER is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_WINDOWS_FORMS_TABPAGE) is
		external
			"IL signature (System.Windows.Forms.TabPage): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"Remove"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_index_of (page: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_has (page: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
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

	frozen icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.TabControl+TabPageCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class TABPAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_TABCONTROL
