indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ControlCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_CONTROL_COLLECTION

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

	frozen make (owner: WEB_CONTROL) is
		external
			"IL creator signature (System.Web.UI.Control) use System.Web.UI.ControlCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlCollection"
		alias
			"get_IsSynchronized"
		end

	get_item (index: INTEGER): WEB_CONTROL is
		external
			"IL signature (System.Int32): System.Web.UI.Control use System.Web.UI.ControlCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.ControlCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ControlCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.ControlCollection"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ControlCollection"
		alias
			"Equals"
		end

	add_at (index: INTEGER; child: WEB_CONTROL) is
		external
			"IL signature (System.Int32, System.Web.UI.Control): System.Void use System.Web.UI.ControlCollection"
		alias
			"AddAt"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ControlCollection"
		alias
			"GetHashCode"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.ControlCollection"
		alias
			"CopyTo"
		end

	index_of (value: WEB_CONTROL): INTEGER is
		external
			"IL signature (System.Web.UI.Control): System.Int32 use System.Web.UI.ControlCollection"
		alias
			"IndexOf"
		end

	remove (value: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.ControlCollection"
		alias
			"Remove"
		end

	contains (c: WEB_CONTROL): BOOLEAN is
		external
			"IL signature (System.Web.UI.Control): System.Boolean use System.Web.UI.ControlCollection"
		alias
			"Contains"
		end

	add (child: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.ControlCollection"
		alias
			"Add"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.ControlCollection"
		alias
			"GetEnumerator"
		end

	clear is
		external
			"IL signature (): System.Void use System.Web.UI.ControlCollection"
		alias
			"Clear"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.ControlCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen get_owner: WEB_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.ControlCollection"
		alias
			"get_Owner"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.ControlCollection"
		alias
			"Finalize"
		end

end -- class WEB_CONTROL_COLLECTION
