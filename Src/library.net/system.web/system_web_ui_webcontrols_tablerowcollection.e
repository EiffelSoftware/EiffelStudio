indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TableRowCollection"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLEROWCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			has as system_collections_ilist_contains,
			extend as system_collections_ilist_add,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			put_i_th as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION

create {NONE}

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TableRowCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW is
		external
			"IL signature (System.Int32): System.Web.UI.WebControls.TableRow use System.Web.UI.WebControls.TableRowCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.TableRowCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TableRowCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.TableRowCollection"
		alias
			"ToString"
		end

	frozen add_at (index: INTEGER; row: SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW) is
		external
			"IL signature (System.Int32, System.Web.UI.WebControls.TableRow): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"AddAt"
		end

	frozen add (row: SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW): INTEGER is
		external
			"IL signature (System.Web.UI.WebControls.TableRow): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"GetHashCode"
		end

	frozen get_row_index (row: SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW): INTEGER is
		external
			"IL signature (System.Web.UI.WebControls.TableRow): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"GetRowIndex"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.TableRowCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"Clear"
		end

	frozen add_range (rows: ARRAY [SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW]) is
		external
			"IL signature (System.Web.UI.WebControls.TableRow[]): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"AddRange"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.TableRowCollection"
		alias
			"Equals"
		end

	frozen remove (row: SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW) is
		external
			"IL signature (System.Web.UI.WebControls.TableRow): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen system_collections_ilist_set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_ilist_index_of (o: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_ilist_remove (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_ilist_add (o: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_contains (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_insert (index: INTEGER; o: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLEROWCOLLECTION
