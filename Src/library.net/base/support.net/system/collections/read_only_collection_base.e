indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.ReadOnlyCollectionBase"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	READ_ONLY_COLLECTION_BASE

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
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

feature -- Access

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ReadOnlyCollectionBase"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ReadOnlyCollectionBase"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.ReadOnlyCollectionBase"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.ReadOnlyCollectionBase"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.ReadOnlyCollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.ReadOnlyCollectionBase"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen get_inner_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Collections.ReadOnlyCollectionBase"
		alias
			"get_InnerList"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ReadOnlyCollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.ReadOnlyCollectionBase"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.ReadOnlyCollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class READ_ONLY_COLLECTION_BASE
