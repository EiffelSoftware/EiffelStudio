indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbErrorCollection"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBERRORCOLLECTION

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
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DATA_OLEDB_OLEDBERROR is
		external
			"IL signature (System.Int32): System.Data.OleDb.OleDbError use System.Data.OleDb.OleDbErrorCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbErrorCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbErrorCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.OleDb.OleDbErrorCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbErrorCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.OleDb.OleDbErrorCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.OleDb.OleDbErrorCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbErrorCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbErrorCollection"
		alias
			"Finalize"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbErrorCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBERRORCOLLECTION
