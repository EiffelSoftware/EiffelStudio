indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ProcessModuleCollection"

external class
	SYSTEM_DIAGNOSTICS_PROCESSMODULECOLLECTION

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
	make_processmodulecollection

feature {NONE} -- Initialization

	frozen make_processmodulecollection (process_modules: ARRAY [SYSTEM_DIAGNOSTICS_PROCESSMODULE]) is
		external
			"IL creator signature (System.Diagnostics.ProcessModule[]) use System.Diagnostics.ProcessModuleCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DIAGNOSTICS_PROCESSMODULE is
		external
			"IL signature (System.Int32): System.Diagnostics.ProcessModule use System.Diagnostics.ProcessModuleCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen has (module: SYSTEM_DIAGNOSTICS_PROCESSMODULE): BOOLEAN is
		external
			"IL signature (System.Diagnostics.ProcessModule): System.Boolean use System.Diagnostics.ProcessModuleCollection"
		alias
			"Contains"
		end

	frozen index_of (module: SYSTEM_DIAGNOSTICS_PROCESSMODULE): INTEGER is
		external
			"IL signature (System.Diagnostics.ProcessModule): System.Int32 use System.Diagnostics.ProcessModuleCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: ARRAY [SYSTEM_DIAGNOSTICS_PROCESSMODULE]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.ProcessModule[], System.Int32): System.Void use System.Diagnostics.ProcessModuleCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_DIAGNOSTICS_PROCESSMODULECOLLECTION
