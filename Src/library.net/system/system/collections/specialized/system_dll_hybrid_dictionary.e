indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.HybridDictionary"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_HYBRID_DICTIONARY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
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

	frozen get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Item"
		end

	frozen get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Values"
		end

	frozen get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.HybridDictionary"
		alias
			"get_Keys"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
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

	frozen set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.HybridDictionary"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"Equals"
		end

	frozen get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
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

	frozen remove (key: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.Specialized.HybridDictionary"
		alias
			"Remove"
		end

	frozen contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.HybridDictionary"
		alias
			"Contains"
		end

	frozen add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
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

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.HybridDictionary"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_DLL_HYBRID_DICTIONARY
