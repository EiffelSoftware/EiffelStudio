indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ImageList+ImageCollection"

frozen external class
	IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST

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
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			extend as ilist_extend,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end

create {NONE}

feature -- Access

	frozen get_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"get_Empty"
		end

	frozen get_item (index: INTEGER): SYSTEM_DRAWING_IMAGE is
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

	frozen put_i_th (index: INTEGER; value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Int32, System.Drawing.Image): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"ToString"
		end

	frozen add_strip (value: SYSTEM_DRAWING_IMAGE): INTEGER is
		external
			"IL signature (System.Drawing.Image): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"AddStrip"
		end

	frozen extend (value: SYSTEM_DRAWING_IMAGE) is
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

	frozen add_image_color (value: SYSTEM_DRAWING_IMAGE; transparent_color: SYSTEM_DRAWING_COLOR): INTEGER is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Color): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Add"
		end

	frozen add_icon (value: SYSTEM_DRAWING_ICON) is
		external
			"IL signature (System.Drawing.Icon): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Add"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen has (image: SYSTEM_DRAWING_IMAGE): BOOLEAN is
		external
			"IL signature (System.Drawing.Image): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Contains"
		end

	frozen index_of (image: SYSTEM_DRAWING_IMAGE): INTEGER is
		external
			"IL signature (System.Drawing.Image): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"IndexOf"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Equals"
		end

	frozen remove (image: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"Remove"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_index_of (image: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (image: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_has (image: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
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

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ImageList+ImageCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST
