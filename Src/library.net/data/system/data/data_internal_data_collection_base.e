indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.InternalDataCollectionBase"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_INTERNAL_DATA_COLLECTION_BASE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Data.InternalDataCollectionBase"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.InternalDataCollectionBase"
		alias
			"get_IsSynchronized"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.InternalDataCollectionBase"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.InternalDataCollectionBase"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.InternalDataCollectionBase"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.InternalDataCollectionBase"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.InternalDataCollectionBase"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.InternalDataCollectionBase"
		alias
			"ToString"
		end

	frozen copy_to (ar: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.InternalDataCollectionBase"
		alias
			"CopyTo"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.InternalDataCollectionBase"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Data.InternalDataCollectionBase"
		alias
			"Finalize"
		end

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.InternalDataCollectionBase"
		alias
			"get_List"
		end

end -- class DATA_INTERNAL_DATA_COLLECTION_BASE
