indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ComponentCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPONENT_COLLECTION

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
	make_system_dll_component_collection

feature {NONE} -- Initialization

	frozen make_system_dll_component_collection (components: NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT]) is
		external
			"IL creator signature (System.ComponentModel.IComponent[]) use System.ComponentModel.ComponentCollection"
		end

feature -- Access

	get_item (name: SYSTEM_STRING): SYSTEM_DLL_ICOMPONENT is
		external
			"IL signature (System.String): System.ComponentModel.IComponent use System.ComponentModel.ComponentCollection"
		alias
			"get_Item"
		end

	get_item_int32 (index: INTEGER): SYSTEM_DLL_ICOMPONENT is
		external
			"IL signature (System.Int32): System.ComponentModel.IComponent use System.ComponentModel.ComponentCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT]; index: INTEGER) is
		external
			"IL signature (System.ComponentModel.IComponent[], System.Int32): System.Void use System.ComponentModel.ComponentCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_DLL_COMPONENT_COLLECTION
