indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CheckedListBox+ObjectCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_CHECKED_LIST_BOX

inherit
	WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_LIST_BOX
	ILIST
		rename
			copy_to as system_collections_icollection_copy_to,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	IENUMERABLE

create
	make_winforms_object_collection_in_winforms_checked_list_box

feature {NONE} -- Initialization

	frozen make_winforms_object_collection_in_winforms_checked_list_box (owner: WINFORMS_CHECKED_LIST_BOX) is
		external
			"IL creator signature (System.Windows.Forms.CheckedListBox) use System.Windows.Forms.CheckedListBox+ObjectCollection"
		end

feature -- Basic Operations

	frozen add_object_boolean (item: SYSTEM_OBJECT; is_checked: BOOLEAN): INTEGER is
		external
			"IL signature (System.Object, System.Boolean): System.Int32 use System.Windows.Forms.CheckedListBox+ObjectCollection"
		alias
			"Add"
		end

	frozen add_object_check_state (item: SYSTEM_OBJECT; check_: WINFORMS_CHECK_STATE): INTEGER is
		external
			"IL signature (System.Object, System.Windows.Forms.CheckState): System.Int32 use System.Windows.Forms.CheckedListBox+ObjectCollection"
		alias
			"Add"
		end

end -- class WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_CHECKED_LIST_BOX
