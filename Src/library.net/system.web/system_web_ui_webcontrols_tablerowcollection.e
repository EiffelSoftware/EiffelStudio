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
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			extend as ilist_extend,
			get_is_fixed_size as ilist_get_is_fixed_size,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item
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

	frozen extend (row: SYSTEM_WEB_UI_WEBCONTROLS_TABLEROW): INTEGER is
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

	is_equal (obj: ANY): BOOLEAN is
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

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen ilist_index_of (o: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen ilist_remove (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen ilist_extend (o: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Add"
		end

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen ilist_has (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
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

	frozen ilist_insert (index: INTEGER; o: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.UI.WebControls.TableRowCollection"
		alias
			"System.Collections.IList.Insert"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLEROWCOLLECTION
