indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.ReadOnlyCollectionBase"

deferred external class
	SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE

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
			copy_to as collection_copy_to,
			get_sync_root as collection_get_sync_root,
			get_is_synchronized as collection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ReadOnlyCollectionBase"
		alias
			"get_Count"
		end

feature -- Basic Operations

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.ReadOnlyCollectionBase"
		alias
			"GetEnumerator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.ReadOnlyCollectionBase"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.ReadOnlyCollectionBase"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.ReadOnlyCollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen collection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.ReadOnlyCollectionBase"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen collection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.ReadOnlyCollectionBase"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Collections.ReadOnlyCollectionBase"
		alias
			"Finalize"
		end

	frozen collection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.ReadOnlyCollectionBase"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen get_inner_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Collections.ReadOnlyCollectionBase"
		alias
			"get_InnerList"
		end

end -- class SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE
