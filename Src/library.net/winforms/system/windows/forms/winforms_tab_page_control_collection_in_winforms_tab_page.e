indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TabPage+TabPageControlCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TAB_PAGE_CONTROL_COLLECTION_IN_WINFORMS_TAB_PAGE

inherit
	WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL
		redefine
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
	make_winforms_tab_page_control_collection_in_winforms_tab_page

feature {NONE} -- Initialization

	frozen make_winforms_tab_page_control_collection_in_winforms_tab_page (owner: WINFORMS_TAB_PAGE) is
		external
			"IL creator signature (System.Windows.Forms.TabPage) use System.Windows.Forms.TabPage+TabPageControlCollection"
		end

feature -- Basic Operations

	add (value: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.TabPage+TabPageControlCollection"
		alias
			"Add"
		end

end -- class WINFORMS_TAB_PAGE_CONTROL_COLLECTION_IN_WINFORMS_TAB_PAGE
