indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogEntryCollection"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGENTRYCOLLECTION

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
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	get_item (index: INTEGER): SYSTEM_DIAGNOSTICS_EVENTLOGENTRY is
		external
			"IL signature (System.Int32): System.Diagnostics.EventLogEntry use System.Diagnostics.EventLogEntryCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.EventLogEntryCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.EventLogEntryCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Diagnostics.EventLogEntryCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntryCollection"
		alias
			"ToString"
		end

	frozen copy_to (entries: ARRAY [SYSTEM_DIAGNOSTICS_EVENTLOGENTRY]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.EventLogEntry[], System.Int32): System.Void use System.Diagnostics.EventLogEntryCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.EventLogEntryCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Diagnostics.EventLogEntryCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.EventLogEntryCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLogEntryCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Diagnostics.EventLogEntryCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGENTRYCOLLECTION
