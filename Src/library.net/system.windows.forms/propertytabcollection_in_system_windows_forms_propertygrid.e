indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyGrid+PropertyTabCollection"

external class
	PROPERTYTABCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_PROPERTYGRID

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"ToString"
		end

	frozen remove_tab_type (property_tab_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"RemoveTabType"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"GetEnumerator"
		end

	frozen clear (tab_scope: SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE) is
		external
			"IL signature (System.ComponentModel.PropertyTabScope): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"Clear"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"Equals"
		end

	frozen add_tab_type (property_tab_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"AddTabType"
		end

	frozen add_tab_type_type_property_tab_scope (property_tab_type: SYSTEM_TYPE; tab_scope: SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE) is
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

	frozen icollection_copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
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

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.PropertyGrid+PropertyTabCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class PROPERTYTABCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_PROPERTYGRID
