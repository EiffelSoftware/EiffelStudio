indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ControlCollection"

external class
	SYSTEM_WEB_UI_CONTROLCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make (owner: SYSTEM_WEB_UI_CONTROL) is
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

	get_item (index: INTEGER): SYSTEM_WEB_UI_CONTROL is
		external
			"IL signature (System.Int32): System.Web.UI.Control use System.Web.UI.ControlCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.ControlCollection"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ControlCollection"
		alias
			"Equals"
		end

	add_at (index: INTEGER; child: SYSTEM_WEB_UI_CONTROL) is
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

	index_of (value: SYSTEM_WEB_UI_CONTROL): INTEGER is
		external
			"IL signature (System.Web.UI.Control): System.Int32 use System.Web.UI.ControlCollection"
		alias
			"IndexOf"
		end

	remove (value: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.ControlCollection"
		alias
			"Remove"
		end

	contains (c: SYSTEM_WEB_UI_CONTROL): BOOLEAN is
		external
			"IL signature (System.Web.UI.Control): System.Boolean use System.Web.UI.ControlCollection"
		alias
			"Contains"
		end

	add (child: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.ControlCollection"
		alias
			"Add"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen get_owner: SYSTEM_WEB_UI_CONTROL is
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

end -- class SYSTEM_WEB_UI_CONTROLCOLLECTION
