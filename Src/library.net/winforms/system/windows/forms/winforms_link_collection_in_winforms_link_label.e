indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LinkLabel+LinkCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LINK_COLLECTION_IN_WINFORMS_LINK_LABEL

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
			remove as system_collections_ilist_remove,
			copy_to as system_collections_icollection_copy_to,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			insert as system_collections_ilist_insert,
			add as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root
		end
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (owner: WINFORMS_LINK_LABEL) is
		external
			"IL creator signature (System.Windows.Forms.LinkLabel) use System.Windows.Forms.LinkLabel+LinkCollection"
		end

feature -- Access

	get_item (index: INTEGER): WINFORMS_LINK_IN_WINFORMS_LINK_LABEL is
		external
			"IL signature (System.Int32): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item (index: INTEGER; value: WINFORMS_LINK_IN_WINFORMS_LINK_LABEL) is
		external
			"IL signature (System.Int32, System.Windows.Forms.LinkLabel+Link): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"ToString"
		end

	frozen add_int32_int32_object (start: INTEGER; length: INTEGER; link_data: SYSTEM_OBJECT): WINFORMS_LINK_IN_WINFORMS_LINK_LABEL is
		external
			"IL signature (System.Int32, System.Int32, System.Object): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Add"
		end

	frozen add (start: INTEGER; length: INTEGER): WINFORMS_LINK_IN_WINFORMS_LINK_LABEL is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"GetEnumerator"
		end

	clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Clear"
		end

	frozen contains (link: WINFORMS_LINK_IN_WINFORMS_LINK_LABEL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.LinkLabel+Link): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Contains"
		end

	frozen index_of (link: WINFORMS_LINK_IN_WINFORMS_LINK_LABEL): INTEGER is
		external
			"IL signature (System.Windows.Forms.LinkLabel+Link): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"IndexOf"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Equals"
		end

	frozen remove (value: WINFORMS_LINK_IN_WINFORMS_LINK_LABEL) is
		external
			"IL signature (System.Windows.Forms.LinkLabel+Link): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (link: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (link: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_LINK_COLLECTION_IN_WINFORMS_LINK_LABEL
