indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ComponentCollection"

external class
	SYSTEM_COMPONENTMODEL_COMPONENTCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE
		rename
			icollection_copy_to as system_collections_icollection_copy_to,
			icollection_get_sync_root as system_collections_icollection_get_sync_root,
			icollection_get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create
	make_componentcollection

feature {NONE} -- Initialization

	frozen make_componentcollection (components: ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT]) is
		external
			"IL creator signature (System.ComponentModel.IComponent[]) use System.ComponentModel.ComponentCollection"
		end

feature -- Access

	get_item (name: STRING): SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL signature (System.String): System.ComponentModel.IComponent use System.ComponentModel.ComponentCollection"
		alias
			"get_Item"
		end

	get_item_int32 (index: INTEGER): SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL signature (System.Int32): System.ComponentModel.IComponent use System.ComponentModel.ComponentCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to (array: ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT]; index: INTEGER) is
		external
			"IL signature (System.ComponentModel.IComponent[], System.Int32): System.Void use System.ComponentModel.ComponentCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_COMPONENTMODEL_COMPONENTCOLLECTION
