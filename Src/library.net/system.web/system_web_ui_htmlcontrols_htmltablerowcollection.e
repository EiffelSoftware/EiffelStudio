indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlTableRowCollection"

frozen external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROWCOLLECTION

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

create {NONE}

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW is
		external
			"IL signature (System.Int32): System.Web.UI.HtmlControls.HtmlTableRow use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"ToString"
		end

	frozen add (row: SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW) is
		external
			"IL signature (System.Web.UI.HtmlControls.HtmlTableRow): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; row: SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW) is
		external
			"IL signature (System.Int32, System.Web.UI.HtmlControls.HtmlTableRow): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"Clear"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"RemoveAt"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"Equals"
		end

	frozen remove (row: SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW) is
		external
			"IL signature (System.Web.UI.HtmlControls.HtmlTableRow): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlTableRowCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROWCOLLECTION
