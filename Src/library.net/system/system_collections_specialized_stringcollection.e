indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.StringCollection"

external class
	SYSTEM_COLLECTIONS_SPECIALIZED_STRINGCOLLECTION

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
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to
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

	frozen get_item (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.StringCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
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

	frozen set_item (index: INTEGER; value: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.StringCollection"
		alias
			"ToString"
		end

	frozen add (value: STRING): INTEGER is
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

	frozen insert (index: INTEGER; value: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [STRING]; index: INTEGER) is
		external
			"IL signature (System.String[], System.Int32): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_SPECIALIZED_STRINGENUMERATOR is
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

	frozen contains (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"Contains"
		end

	frozen add_range (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"AddRange"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.StringCollection"
		alias
			"Equals"
		end

	frozen index_of (value: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: STRING) is
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

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
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

	frozen system_collections_ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_ilist_add (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_contains (value: ANY): BOOLEAN is
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

	frozen system_collections_ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Collections.Specialized.StringCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_STRINGCOLLECTION
