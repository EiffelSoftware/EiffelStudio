indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ProcessThreadCollection"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	PROCESSTHREADCOLLECTION

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
	make_processthreadcollection

feature {NONE} -- Initialization

	frozen make_processthreadcollection (process_threads: NATIVE_ARRAY [PROCESSTHREAD]) is
		external
			"IL creator signature (System.Diagnostics.ProcessThread[]) use System.Diagnostics.ProcessThreadCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): PROCESSTHREAD is
		external
			"IL signature (System.Int32): System.Diagnostics.ProcessThread use System.Diagnostics.ProcessThreadCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: NATIVE_ARRAY [PROCESSTHREAD]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.ProcessThread[], System.Int32): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"CopyTo"
		end

	frozen contains (thread: PROCESSTHREAD): BOOLEAN is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Boolean use System.Diagnostics.ProcessThreadCollection"
		alias
			"Contains"
		end

	frozen index_of (thread: PROCESSTHREAD): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Int32 use System.Diagnostics.ProcessThreadCollection"
		alias
			"IndexOf"
		end

	frozen add (thread: PROCESSTHREAD): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Int32 use System.Diagnostics.ProcessThreadCollection"
		alias
			"Add"
		end

	frozen remove (thread: PROCESSTHREAD) is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; thread: PROCESSTHREAD) is
		external
			"IL signature (System.Int32, System.Diagnostics.ProcessThread): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"Insert"
		end

end -- class PROCESSTHREADCOLLECTION
