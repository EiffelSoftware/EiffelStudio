indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.ListDictionary"

external class
	SYSTEM_COLLECTIONS_SPECIALIZED_LISTDICTIONARY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.Specialized.ListDictionary"
		end

	frozen make_1 (comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL creator signature (System.Collections.IComparer) use System.Collections.Specialized.ListDictionary"
		end

feature -- Access

	frozen get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Collections.Specialized.ListDictionary"
		alias
			"get_Item"
		end

	frozen get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.ListDictionary"
		alias
			"get_Values"
		end

	frozen get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.ListDictionary"
		alias
			"get_Keys"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Specialized.ListDictionary"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.ListDictionary"
		alias
			"get_Count"
		end

	frozen get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.ListDictionary"
		alias
			"get_IsFixedSize"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.ListDictionary"
		alias
			"get_IsReadOnly"
		end

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.ListDictionary"
		alias
			"get_IsSynchronized"
		end

feature -- Element Change

	frozen set_item (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Specialized.ListDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.ListDictionary"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.ListDictionary"
		alias
			"Equals"
		end

	frozen get_enumerator_idictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.Specialized.ListDictionary"
		alias
			"GetEnumerator"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.ListDictionary"
		alias
			"CopyTo"
		end

	frozen remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Specialized.ListDictionary"
		alias
			"Remove"
		end

	frozen contains (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.ListDictionary"
		alias
			"Contains"
		end

	frozen add (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Specialized.ListDictionary"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.Specialized.ListDictionary"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.ListDictionary"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Specialized.ListDictionary"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.ListDictionary"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_LISTDICTIONARY
