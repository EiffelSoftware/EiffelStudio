indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Form+ControlCollection"

external class
	CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_FORM

inherit
	CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			remove,
			extend
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			extend as ilist_extend,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			is_equal as equals_object
		end
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone,
			is_equal as equals_object
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			is_equal as equals_object
		end

create
	make_controlcollection

feature {NONE} -- Initialization

	frozen make_controlcollection (owner: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL creator signature (System.Windows.Forms.Form) use System.Windows.Forms.Form+ControlCollection"
		end

feature -- Basic Operations

	extend (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Form+ControlCollection"
		alias
			"Add"
		end

	remove (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Form+ControlCollection"
		alias
			"Remove"
		end

end -- class CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_FORM
