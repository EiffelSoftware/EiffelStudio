indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogEntryCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_EVENT_LOG_ENTRY_COLLECTION

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

create {NONE}

feature -- Access

	get_item (index: INTEGER): SYSTEM_DLL_EVENT_LOG_ENTRY is
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

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Diagnostics.EventLogEntryCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntryCollection"
		alias
			"ToString"
		end

	frozen copy_to (entries: NATIVE_ARRAY [SYSTEM_DLL_EVENT_LOG_ENTRY]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.EventLogEntry[], System.Int32): System.Void use System.Diagnostics.EventLogEntryCollection"
		alias
			"CopyTo"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Diagnostics.EventLogEntryCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_DLL_EVENT_LOG_ENTRY_COLLECTION
