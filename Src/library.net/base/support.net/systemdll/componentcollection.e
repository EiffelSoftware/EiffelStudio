indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.ComponentModel.ComponentCollection"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	COMPONENTCOLLECTION

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
	make_componentcollection

feature {NONE} -- Initialization

	frozen make_componentcollection (components: NATIVE_ARRAY [ICOMPONENT]) is
		external
			"IL creator signature (System.ComponentModel.IComponent[]) use System.ComponentModel.ComponentCollection"
		end

feature -- Access

	get_item (name: SYSTEM_STRING): ICOMPONENT is
		external
			"IL signature (System.String): System.ComponentModel.IComponent use System.ComponentModel.ComponentCollection"
		alias
			"get_Item"
		end

	get_item_int32 (index: INTEGER): ICOMPONENT is
		external
			"IL signature (System.Int32): System.ComponentModel.IComponent use System.ComponentModel.ComponentCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: NATIVE_ARRAY [ICOMPONENT]; index: INTEGER) is
		external
			"IL signature (System.ComponentModel.IComponent[], System.Int32): System.Void use System.ComponentModel.ComponentCollection"
		alias
			"CopyTo"
		end

end -- class COMPONENTCOLLECTION
