indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DataBindingCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_BINDING_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
	IENUMERABLE

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

	frozen get_item (property_name: SYSTEM_STRING): WEB_DATA_BINDING is
		external
			"IL signature (System.String): System.Web.UI.DataBinding use System.Web.UI.DataBindingCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
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

	frozen get_removed_bindings: NATIVE_ARRAY [SYSTEM_STRING] is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBindingCollection"
		alias
			"ToString"
		end

	frozen add (binding: WEB_DATA_BINDING) is
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

	frozen remove_string (property_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Remove"
		end

	frozen get_enumerator: IENUMERATOR is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.DataBindingCollection"
		alias
			"Equals"
		end

	frozen remove_string_boolean (property_name: SYSTEM_STRING; add_to_removed_list: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.UI.DataBindingCollection"
		alias
			"Remove"
		end

	frozen remove (binding: WEB_DATA_BINDING) is
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

end -- class WEB_DATA_BINDING_COLLECTION
