indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListBox+ObjectCollection"

external class
	OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX

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
			extend as ilist_extend,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (owner: SYSTEM_WINDOWS_FORMS_LISTBOX; value: ARRAY [ANY]) is
		external
			"IL creator signature (System.Windows.Forms.ListBox, System.Object[]) use System.Windows.Forms.ListBox+ObjectCollection"
		end

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LISTBOX) is
		external
			"IL creator signature (System.Windows.Forms.ListBox) use System.Windows.Forms.ListBox+ObjectCollection"
		end

	frozen make_1 (owner: SYSTEM_WINDOWS_FORMS_LISTBOX; value: OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX) is
		external
			"IL creator signature (System.Windows.Forms.ListBox, System.Windows.Forms.ListBox+ObjectCollection) use System.Windows.Forms.ListBox+ObjectCollection"
		end

feature -- Access

	get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"ToString"
		end

	frozen extend (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; item: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Insert"
		end

	frozen copy_to (dest: ARRAY [ANY]; array_index: INTEGER) is
		external
			"IL signature (System.Object[], System.Int32): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"CopyTo"
		end

	frozen add_range_object_collection (value: OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX) is
		external
			"IL signature (System.Windows.Forms.ListBox+ObjectCollection): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"AddRange"
		end

	frozen index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Remove"
		end

	frozen has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Contains"
		end

	frozen add_range (items: ARRAY [ANY]) is
		external
			"IL signature (System.Object[]): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"AddRange"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Equals"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"GetEnumerator"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"GetHashCode"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Finalize"
		end

	frozen ilist_extend (item: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX
