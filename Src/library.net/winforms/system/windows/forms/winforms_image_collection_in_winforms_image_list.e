indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ImageList+ImageCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_IMAGE_COLLECTION_IN_WINFORMS_IMAGE_LIST

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
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			add as system_collections_ilist_add,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
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

create {NONE}

feature -- Access

	frozen get_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"get_Empty"
		end

	frozen get_item (index: INTEGER): DRAWING_IMAGE is
		external
			"IL signature (System.Int32): System.Drawing.Image use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: DRAWING_IMAGE) is
		external
			"IL signature (System.Int32, System.Drawing.Image): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"ToString"
		end

	frozen add_strip (value: DRAWING_IMAGE): INTEGER is
		external
			"IL signature (System.Drawing.Image): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"AddStrip"
		end

	frozen add (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"GetHashCode"
		end

	frozen add_image_color (value: DRAWING_IMAGE; transparent_color: DRAWING_COLOR): INTEGER is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Color): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Add"
		end

	frozen add_icon (value: DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Add"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Clear"
		end

	frozen contains (image: DRAWING_IMAGE): BOOLEAN is
		external
			"IL signature (System.Drawing.Image): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Contains"
		end

	frozen index_of (image: DRAWING_IMAGE): INTEGER is
		external
			"IL signature (System.Drawing.Image): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"IndexOf"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Equals"
		end

	frozen remove (image: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_index_of (image: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (image: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_contains (image: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class WINFORMS_IMAGE_COLLECTION_IN_WINFORMS_IMAGE_LIST
