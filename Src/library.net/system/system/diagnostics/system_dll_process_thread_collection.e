indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.ProcessThreadCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PROCESS_THREAD_COLLECTION

inherit
	READ_ONLY_COLLECTION_BASE
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_dll_process_thread_collection

feature {NONE} -- Initialization

	frozen make_system_dll_process_thread_collection (process_threads: NATIVE_ARRAY [SYSTEM_DLL_PROCESS_THREAD]) is
		external
			"IL creator signature (System.Diagnostics.ProcessThread[]) use System.Diagnostics.ProcessThreadCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_PROCESS_THREAD is
		external
			"IL signature (System.Int32): System.Diagnostics.ProcessThread use System.Diagnostics.ProcessThreadCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_PROCESS_THREAD]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.ProcessThread[], System.Int32): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"CopyTo"
		end

	frozen contains (thread: SYSTEM_DLL_PROCESS_THREAD): BOOLEAN is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Boolean use System.Diagnostics.ProcessThreadCollection"
		alias
			"Contains"
		end

	frozen index_of (thread: SYSTEM_DLL_PROCESS_THREAD): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Int32 use System.Diagnostics.ProcessThreadCollection"
		alias
			"IndexOf"
		end

	frozen add (thread: SYSTEM_DLL_PROCESS_THREAD): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Int32 use System.Diagnostics.ProcessThreadCollection"
		alias
			"Add"
		end

	frozen remove (thread: SYSTEM_DLL_PROCESS_THREAD) is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; thread: SYSTEM_DLL_PROCESS_THREAD) is
		external
			"IL signature (System.Int32, System.Diagnostics.ProcessThread): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"Insert"
		end

end -- class SYSTEM_DLL_PROCESS_THREAD_COLLECTION
