indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DataBindingCollection"

frozen external class
	SYSTEM_WEB_UI_DATABINDINGCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.DataBindingCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.DataBindingCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (property_name: STRING): SYSTEM_WEB_UI_DATABINDING is
		external
			"IL signature (System.String): System.Web.UI.DataBinding use System.Web.UI.DataBindingCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.DataBindingCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.DataBindingCollection"
		alias
			"get_Count"
		end

	frozen get_removed_bindings: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Web.UI.DataBindingCollection"
		alias
			"get_RemovedBindings"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.DataBindingCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBindingCollection"
		alias
			"ToString"
		end

	frozen add (binding: SYSTEM_WEB_UI_DATABINDING) is
		external
			"IL signature (System.Web.UI.DataBinding): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Add"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"CopyTo"
		end

	frozen remove_string (property_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Remove"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.DataBindingCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Clear"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.DataBindingCollection"
		alias
			"Equals"
		end

	frozen remove_string_boolean (property_name: STRING; add_to_removed_list: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Remove"
		end

	frozen remove (binding: SYSTEM_WEB_UI_DATABINDING) is
		external
			"IL signature (System.Web.UI.DataBinding): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.DataBindingCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_UI_DATABINDINGCOLLECTION
