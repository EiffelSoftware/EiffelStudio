indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListBox+ObjectCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_LIST_BOX

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
			add as system_collections_ilist_add,
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
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (owner: WINFORMS_LIST_BOX; value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Windows.Forms.ListBox, System.Object[]) use System.Windows.Forms.ListBox+ObjectCollection"
		end

	frozen make (owner: WINFORMS_LIST_BOX) is
		external
			"IL creator signature (System.Windows.Forms.ListBox) use System.Windows.Forms.ListBox+ObjectCollection"
		end

	frozen make_1 (owner: WINFORMS_LIST_BOX; value: WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_LIST_BOX) is
		external
			"IL creator signature (System.Windows.Forms.ListBox, System.Windows.Forms.ListBox+ObjectCollection) use System.Windows.Forms.ListBox+ObjectCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_OBJECT is
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

	set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"ToString"
		end

	frozen add (item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; item: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Insert"
		end

	frozen add_range_array_object (items: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"AddRange"
		end

	frozen copy_to (dest: NATIVE_ARRAY [SYSTEM_OBJECT]; array_index: INTEGER) is
		external
			"IL signature (System.Object[], System.Int32): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Contains"
		end

	frozen add_range (value: WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_LIST_BOX) is
		external
			"IL signature (System.Windows.Forms.ListBox+ObjectCollection): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"AddRange"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"Equals"
		end

	frozen get_enumerator: IENUMERATOR is
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

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
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

	frozen system_collections_ilist_add (item: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListBox+ObjectCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_LIST_BOX
