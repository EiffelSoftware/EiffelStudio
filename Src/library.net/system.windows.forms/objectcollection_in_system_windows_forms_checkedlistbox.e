indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.CheckedListBox+ObjectCollection"

external class
	OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CHECKEDLISTBOX

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			copy_to as system_collections_icollection_copy_to,
			extend as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTBOX
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end

create
	make_objectcollection

feature {NONE} -- Initialization

	frozen make_objectcollection (owner: SYSTEM_WINDOWS_FORMS_CHECKEDLISTBOX) is
		external
			"IL creator signature (System.Windows.Forms.CheckedListBox) use System.Windows.Forms.CheckedListBox+ObjectCollection"
		end

feature -- Basic Operations

	frozen add_object_boolean (item: ANY; is_checked: BOOLEAN): INTEGER is
		external
			"IL signature (System.Object, System.Boolean): System.Int32 use System.Windows.Forms.CheckedListBox+ObjectCollection"
		alias
			"Add"
		end

	frozen add_object_check_state (item: ANY; check_: SYSTEM_WINDOWS_FORMS_CHECKSTATE): INTEGER is
		external
			"IL signature (System.Object, System.Windows.Forms.CheckState): System.Int32 use System.Windows.Forms.CheckedListBox+ObjectCollection"
		alias
			"Add"
		end

end -- class OBJECTCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CHECKEDLISTBOX
