indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_KEYS_COLLECTION_IN_SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"ToString"
		end

	get (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"Get"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.Specialized.NameObjectCollectionBase+KeysCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_DLL_KEYS_COLLECTION_IN_SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE
