indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlTableCellCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTML_TABLE_CELL_COLLECTION

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

create {NONE}

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): WEB_HTML_TABLE_CELL is
		external
			"IL signature (System.Int32): System.Web.UI.HtmlControls.HtmlTableCell use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"ToString"
		end

	frozen add (cell: WEB_HTML_TABLE_CELL) is
		external
			"IL signature (System.Web.UI.HtmlControls.HtmlTableCell): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"Add"
		end

	frozen insert (index: INTEGER; cell: WEB_HTML_TABLE_CELL) is
		external
			"IL signature (System.Int32, System.Web.UI.HtmlControls.HtmlTableCell): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"Clear"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"RemoveAt"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"Equals"
		end

	frozen remove (cell: WEB_HTML_TABLE_CELL) is
		external
			"IL signature (System.Web.UI.HtmlControls.HtmlTableCell): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.HtmlControls.HtmlTableCellCollection"
		alias
			"Finalize"
		end

end -- class WEB_HTML_TABLE_CELL_COLLECTION
