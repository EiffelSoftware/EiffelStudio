indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ProcessThreadCollection"

external class
	SYSTEM_DIAGNOSTICS_PROCESSTHREADCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE

create
	make_processthreadcollection

feature {NONE} -- Initialization

	frozen make_processthreadcollection (process_threads: ARRAY [SYSTEM_DIAGNOSTICS_PROCESSTHREAD]) is
		external
			"IL creator signature (System.Diagnostics.ProcessThread[]) use System.Diagnostics.ProcessThreadCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DIAGNOSTICS_PROCESSTHREAD is
		external
			"IL signature (System.Int32): System.Diagnostics.ProcessThread use System.Diagnostics.ProcessThreadCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: ARRAY [SYSTEM_DIAGNOSTICS_PROCESSTHREAD]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.ProcessThread[], System.Int32): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"CopyTo"
		end

	frozen has (thread: SYSTEM_DIAGNOSTICS_PROCESSTHREAD): BOOLEAN is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Boolean use System.Diagnostics.ProcessThreadCollection"
		alias
			"Contains"
		end

	frozen index_of (thread: SYSTEM_DIAGNOSTICS_PROCESSTHREAD): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Int32 use System.Diagnostics.ProcessThreadCollection"
		alias
			"IndexOf"
		end

	frozen extend (thread: SYSTEM_DIAGNOSTICS_PROCESSTHREAD): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Int32 use System.Diagnostics.ProcessThreadCollection"
		alias
			"Add"
		end

	frozen remove (thread: SYSTEM_DIAGNOSTICS_PROCESSTHREAD) is
		external
			"IL signature (System.Diagnostics.ProcessThread): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"Remove"
		end

	frozen insert (index: INTEGER; thread: SYSTEM_DIAGNOSTICS_PROCESSTHREAD) is
		external
			"IL signature (System.Int32, System.Diagnostics.ProcessThread): System.Void use System.Diagnostics.ProcessThreadCollection"
		alias
			"Insert"
		end

end -- class SYSTEM_DIAGNOSTICS_PROCESSTHREADCOLLECTION
