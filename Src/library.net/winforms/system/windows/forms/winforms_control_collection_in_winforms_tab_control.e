indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TabControl+ControlCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_TAB_CONTROL

inherit
	WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL
		redefine
			remove,
			add
		end
	ILIST
		rename
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	IENUMERABLE
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

create
	make_winforms_control_collection_in_winforms_tab_control

feature {NONE} -- Initialization

	frozen make_winforms_control_collection_in_winforms_tab_control (owner: WINFORMS_TAB_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.TabControl) use System.Windows.Forms.TabControl+ControlCollection"
		end

feature -- Basic Operations

	add (value: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.TabControl+ControlCollection"
		alias
			"Add"
		end

	remove (value: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.TabControl+ControlCollection"
		alias
			"Remove"
		end

end -- class WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_TAB_CONTROL
