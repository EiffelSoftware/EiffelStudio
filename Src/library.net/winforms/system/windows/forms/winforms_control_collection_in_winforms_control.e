indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Control+ControlCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
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
	make

feature {NONE} -- Initialization

	frozen make (owner: WINFORMS_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.Control) use System.Windows.Forms.Control+ControlCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_CONTROL is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Control+ControlCollection"
		alias
			"ToString"
		end

	equals (other: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"Equals"
		end

	frozen set_child_index (child: WINFORMS_CONTROL; new_index: INTEGER) is
		external
			"IL signature (System.Windows.Forms.Control, System.Int32): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"SetChildIndex"
		end

	frozen get_child_index (child: WINFORMS_CONTROL): INTEGER is
		external
			"IL signature (System.Windows.Forms.Control): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"GetChildIndex"
		end

	frozen get_child_index_control_boolean (child: WINFORMS_CONTROL; throw_exception: BOOLEAN): INTEGER is
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

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.Control+ControlCollection"
		alias
			"GetEnumerator"
		end

	remove (value: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"Remove"
		end

	frozen contains (control: WINFORMS_CONTROL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Control): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"Contains"
		end

	add_range (controls: NATIVE_ARRAY [WINFORMS_CONTROL]) is
		external
			"IL signature (System.Windows.Forms.Control[]): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"AddRange"
		end

	add (value: WINFORMS_CONTROL) is
		external
			"IL signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"Add"
		end

	frozen index_of (control: WINFORMS_CONTROL): INTEGER is
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

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (control: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (control: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.ICloneable.Clone"
		end

	frozen system_collections_ilist_add (control: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (control: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
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

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.Control+ControlCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL
