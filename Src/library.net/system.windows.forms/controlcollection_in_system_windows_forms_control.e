indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Control+ControlCollection"

external class
	CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
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
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.Control) use System.Windows.Forms.Control+ControlCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (System.Int32): System.Windows.Forms.Control use System.Windows.Forms.Control+ControlCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control+ControlCollection"
		alias
			"ToString"
		end

	frozen set_child_index (child: SYSTEM_WINDOWS_FORMS_CONTROL; new_index: INTEGER) is
		external
			"IL signature (System.Windows.Forms.Control, System.Int32): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"SetChildIndex"
		end

	frozen get_child_index (child: SYSTEM_WINDOWS_FORMS_CONTROL): INTEGER is
		external
			"IL signature (System.Windows.Forms.Control): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"GetChildIndex"
		end

	frozen get_child_index_control_boolean (child: SYSTEM_WINDOWS_FORMS_CONTROL; throw_exception: BOOLEAN): INTEGER is
		external
			"IL signature (System.Windows.Forms.Control, System.Boolean): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"GetChildIndex"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"GetHashCode"
		end

	frozen has (control: SYSTEM_WINDOWS_FORMS_CONTROL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"Contains"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.Control+ControlCollection"
		alias
			"GetEnumerator"
		end

	remove (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"Remove"
		end

	equals_object (other: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"Equals"
		end

	add_range (controls: ARRAY [SYSTEM_WINDOWS_FORMS_CONTROL]) is
		external
			"IL signature (System.Windows.Forms.Control[]): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"AddRange"
		end

	extend (value: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"Add"
		end

	frozen index_of (control: SYSTEM_WINDOWS_FORMS_CONTROL): INTEGER is
		external
			"IL signature (System.Windows.Forms.Control): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"IndexOf"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"Clear"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_index_of (control: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (control: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.ICloneable.Clone"
		end

	frozen ilist_extend (control: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_has (control: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"Finalize"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL
