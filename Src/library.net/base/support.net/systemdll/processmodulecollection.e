indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Diagnostics.ProcessModuleCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PROCESSMODULECOLLECTION

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
	make_processmodulecollection

feature {NONE} -- Initialization

	frozen make_processmodulecollection (process_modules: NATIVE_ARRAY [PROCESSMODULE]) is
		external
			"IL creator signature (System.Diagnostics.ProcessModule[]) use System.Diagnostics.ProcessModuleCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): PROCESSMODULE is
		external
			"IL signature (System.Int32): System.Diagnostics.ProcessModule use System.Diagnostics.ProcessModuleCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (module: PROCESSMODULE): BOOLEAN is
		external
			"IL signature (System.Diagnostics.ProcessModule): System.Boolean use System.Diagnostics.ProcessModuleCollection"
		alias
			"Contains"
		end

	frozen index_of (module: PROCESSMODULE): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessModule): System.Int32 use System.Diagnostics.ProcessModuleCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: NATIVE_ARRAY [PROCESSMODULE]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.ProcessModule[], System.Int32): System.Void use System.Diagnostics.ProcessModuleCollection"
		alias
			"CopyTo"
		end

end -- class PROCESSMODULECOLLECTION
