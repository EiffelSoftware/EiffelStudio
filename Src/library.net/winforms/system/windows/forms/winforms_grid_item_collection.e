indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.GridItemCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_GRID_ITEM_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
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

	frozen empty: WINFORMS_GRID_ITEM_COLLECTION is
		external
			"IL static_field signature :System.Windows.Forms.GridItemCollection use System.Windows.Forms.GridItemCollection"
		alias
			"Empty"
		end

	frozen get_item (label: SYSTEM_STRING): WINFORMS_GRID_ITEM is
		external
			"IL signature (System.String): System.Windows.Forms.GridItem use System.Windows.Forms.GridItemCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.GridItemCollection"
		alias
			"get_Count"
		end

	frozen get_item_int32 (index: INTEGER): WINFORMS_GRID_ITEM is
		external
			"IL signature (System.Int32): System.Windows.Forms.GridItem use System.Windows.Forms.GridItemCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.GridItemCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.GridItemCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.GridItemCollection"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.GridItemCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.GridItemCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridItemCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.GridItemCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.GridItemCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class WINFORMS_GRID_ITEM_COLLECTION
