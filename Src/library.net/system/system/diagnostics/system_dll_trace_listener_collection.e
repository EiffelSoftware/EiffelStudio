indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.TraceListenerCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TRACE_LISTENER_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ILIST
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (name: SYSTEM_STRING): SYSTEM_DLL_TRACE_LISTENER is
		external
			"IL signature (System.String): System.Diagnostics.TraceListener use System.Diagnostics.TraceListenerCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.TraceListenerCollection"
		alias
			"get_Count"
		end

	frozen get_item_int32 (i: INTEGER): SYSTEM_DLL_TRACE_LISTENER is
		external
			"IL signature (System.Int32): System.Diagnostics.TraceListener use System.Diagnostics.TraceListenerCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_item (i: INTEGER; value: SYSTEM_DLL_TRACE_LISTENER) is
		external
			"IL signature (System.Int32, System.Diagnostics.TraceListener): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.TraceListenerCollection"
		alias
			"ToString"
		end

	frozen add (listener: SYSTEM_DLL_TRACE_LISTENER): INTEGER is
		external
			"IL signature (System.Diagnostics.TraceListener): System.Int32 use System.Diagnostics.TraceListenerCollection"
		alias
			"Add"
		end

	frozen add_range_array_trace_listener (value: NATIVE_ARRAY [SYSTEM_DLL_TRACE_LISTENER]) is
		external
			"IL signature (System.Diagnostics.TraceListener[]): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"AddRange"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.TraceListenerCollection"
		alias
			"GetHashCode"
		end

	frozen insert (index: INTEGER; listener: SYSTEM_DLL_TRACE_LISTENER) is
		external
			"IL signature (System.Int32, System.Diagnostics.TraceListener): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"Insert"
		end

	frozen copy_to (listeners: NATIVE_ARRAY [SYSTEM_DLL_TRACE_LISTENER]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.TraceListener[], System.Int32): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"CopyTo"
		end

	frozen remove_trace_listener (listener: SYSTEM_DLL_TRACE_LISTENER) is
		external
			"IL signature (System.Diagnostics.TraceListener): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"Remove"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Diagnostics.TraceListenerCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"Clear"
		end

	frozen contains (listener: SYSTEM_DLL_TRACE_LISTENER): BOOLEAN is
		external
			"IL signature (System.Diagnostics.TraceListener): System.Boolean use System.Diagnostics.TraceListenerCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_TRACE_LISTENER_COLLECTION) is
		external
			"IL signature (System.Diagnostics.TraceListenerCollection): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"AddRange"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.TraceListenerCollection"
		alias
			"Equals"
		end

	frozen index_of (listener: SYSTEM_DLL_TRACE_LISTENER): INTEGER is
		external
			"IL signature (System.Diagnostics.TraceListener): System.Int32 use System.Diagnostics.TraceListenerCollection"
		alias
			"IndexOf"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Diagnostics.TraceListenerCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_DLL_TRACE_LISTENER_COLLECTION
