indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyGrid+PropertyTabCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PROPERTY_TAB_COLLECTION_IN_WINFORMS_PROPERTY_GRID

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

	frozen get_item (index: INTEGER): WINFORMS_PROPERTY_TAB is
		external
			"IL signature (System.Int32): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"ToString"
		end

	frozen remove_tab_type (property_tab_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"RemoveTabType"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"GetEnumerator"
		end

	frozen clear (tab_scope: SYSTEM_DLL_PROPERTY_TAB_SCOPE) is
		external
			"IL signature (System.ComponentModel.PropertyTabScope): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"Clear"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"Equals"
		end

	frozen add_tab_type (property_tab_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"AddTabType"
		end

	frozen add_tab_type_type_property_tab_scope (property_tab_type: TYPE; tab_scope: SYSTEM_DLL_PROPERTY_TAB_SCOPE) is
		external
			"IL signature (System.Type, System.ComponentModel.PropertyTabScope): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"AddTabType"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class WINFORMS_PROPERTY_TAB_COLLECTION_IN_WINFORMS_PROPERTY_GRID
