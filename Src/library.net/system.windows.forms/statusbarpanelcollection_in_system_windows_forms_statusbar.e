indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StatusBar+StatusBarPanelCollection"

external class
	STATUSBARPANELCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_STATUSBAR

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
			copy_to as icollection_copy_to,
			remove as ilist_remove,
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

	frozen make (owner: SYSTEM_WINDOWS_FORMS_STATUSBAR) is
		external
			"IL creator signature (System.Windows.Forms.StatusBar) use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_STATUSBARPANEL is
		external
			"IL signature (System.Int32): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	put_i_th (index: INTEGER; value: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL) is
		external
			"IL signature (System.Int32, System.Windows.Forms.StatusBarPanel): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	add_status_bar_panel (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL): INTEGER is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Add"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Equals"
		end

	insert (index: INTEGER; value: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL) is
		external
			"IL signature (System.Int32, System.Windows.Forms.StatusBarPanel): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Insert"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"ToString"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"GetEnumerator"
		end

	remove (value: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Remove"
		end

	frozen has (panel: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Contains"
		end

	add_range (panels: ARRAY [SYSTEM_WINDOWS_FORMS_STATUSBARPANEL]) is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel[]): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"AddRange"
		end

	extend (text: STRING): SYSTEM_WINDOWS_FORMS_STATUSBARPANEL is
		external
			"IL signature (System.String): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Add"
		end

	frozen index_of (panel: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL): INTEGER is
		external
			"IL signature (System.Windows.Forms.StatusBarPanel): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"IndexOf"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"GetHashCode"
		end

	prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_index_of (panel: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_has (panel: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"Finalize"
		end

	frozen icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.StatusBar+StatusBarPanelCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class STATUSBARPANELCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_STATUSBAR
