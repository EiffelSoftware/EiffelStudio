indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.HybridDictionary"

external class
	SYSTEM_COLLECTIONS_SPECIALIZED_HYBRIDDICTIONARY

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
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (initial_size: INTEGER; case_insensitive: BOOLEAN) is
		external
			"IL creator signature (System.Int32, System.Boolean) use System.Collections.Specialized.HybridDictionary"
		end

	frozen make_2 (case_insensitive: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Collections.Specialized.HybridDictionary"
		end

	frozen make is
		external
			"IL creator use System.Collections.Specialized.HybridDictionary"
		end

	frozen make_1 (initial_size: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Collections.Specialized.HybridDictionary"
		end

feature -- Access

	frozen get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Item"
		end

	frozen get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Values"
		end

	frozen get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Keys"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Specialized.HybridDictionary"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Count"
		end

	frozen get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"get_IsFixedSize"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"get_IsReadOnly"
		end

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"get_IsSynchronized"
		end

feature -- Element Change

	frozen put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.HybridDictionary"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"Equals"
		end

	frozen get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Collections.Specialized.HybridDictionary"
		alias
			"GetEnumerator"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"CopyTo"
		end

	frozen remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"Remove"
		end

	frozen has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"Contains"
		end

	frozen extend (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.HybridDictionary"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.HybridDictionary"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_HYBRIDDICTIONARY
