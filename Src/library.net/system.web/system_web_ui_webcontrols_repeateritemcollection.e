indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RepeaterItemCollection"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMCOLLECTION

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

	frozen make (items: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL creator signature (System.Collections.ArrayList) use System.Web.UI.WebControls.RepeaterItemCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEM is
		external
			"IL signature (System.Int32): System.Web.UI.WebControls.RepeaterItem use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.RepeaterItemCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMCOLLECTION
