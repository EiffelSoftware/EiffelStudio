indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkLabel+LinkCollection"

external class
	LINKCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove as ilist_remove,
			copy_to as icollection_copy_to,
			index_of as ilist_index_of,
			has as ilist_has,
			insert as ilist_insert,
			extend as ilist_extend,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WINDOWS_FORMS_LINKLABEL) is
		external
			"IL creator signature (System.Windows.Forms.LinkLabel) use System.Windows.Forms.LinkLabel+LinkCollection"
		end

feature -- Access

	get_item (index: INTEGER): LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL is
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

	put_i_th (index: INTEGER; value: LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL) is
		external
			"IL signature (System.Int32, System.Windows.Forms.LinkLabel+Link): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"ToString"
		end

	frozen add_int32_int32_object (start: INTEGER; length: INTEGER; link_data: ANY): LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL is
		external
			"IL signature (System.Int32, System.Int32, System.Object): System.Windows.Forms.LinkLabel+Link use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Add"
		end

	frozen extend (start: INTEGER; length: INTEGER): LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen has (link: LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.LinkLabel+Link): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Contains"
		end

	frozen index_of (link: LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL): INTEGER is
		external
			"IL signature (System.Windows.Forms.LinkLabel+Link): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"IndexOf"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Equals"
		end

	frozen remove (value: LINK_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL) is
		external
			"IL signature (System.Windows.Forms.LinkLabel+Link): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"Remove"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_index_of (link: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_has (link: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
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

	frozen icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.LinkLabel+LinkCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class LINKCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LINKLABEL
