indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TabControl+ControlCollection"

external class
	CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_TABCONTROL

inherit
	CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			remove,
			add
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			extend as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			equals as equals_object
		end
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone,
			equals as equals_object
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			equals as equals_object
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			equals as equals_object
		end

create
	make_controlcollection

feature {NONE} -- Initialization

	frozen make_controlcollection (owner: SYSTEM_WINDOWS_FORMS_TABCONTROL) is
		external
			"IL creator signature (System.Windows.Forms.TabControl) use System.Windows.Forms.TabControl+ControlCollection"
		end

feature -- Basic Operations

	add (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.TabControl+ControlCollection"
		alias
			"Add"
		end

	remove (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.TabControl+ControlCollection"
		alias
			"Remove"
		end

end -- class CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_TABCONTROL
