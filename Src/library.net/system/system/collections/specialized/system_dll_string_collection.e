indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.StringCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_STRING_COLLECTION

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
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			add as system_collections_ilist_add,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.Specialized.StringCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.StringCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Specialized.StringCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.StringCollection"
		alias
			"ToString"
		end

	frozen add (value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"GetHashCode"
		end

	frozen insert (index: INTEGER; value: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_STRING]; index: INTEGER) is
		external
			"IL signature (System.String[], System.Int32): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_DLL_STRING_ENUMERATOR is
		external
			"IL signature (): System.Collections.Specialized.StringEnumerator use System.Collections.Specialized.StringCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"Clear"
		end

	frozen contains (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"Contains"
		end

	frozen add_range (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"AddRange"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"Equals"
		end

	frozen index_of (value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_DLL_STRING_COLLECTION
