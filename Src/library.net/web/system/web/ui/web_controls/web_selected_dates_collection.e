indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.SelectedDatesCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_SELECTED_DATES_COLLECTION

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

	frozen make (date_list: ARRAY_LIST) is
		external
			"IL creator signature (System.Collections.ArrayList) use System.Web.UI.WebControls.SelectedDatesCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.Int32): System.DateTime use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"ToString"
		end

	frozen add (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Add"
		end

	frozen select_range (from_date: SYSTEM_DATE_TIME; to_date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime, System.DateTime): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"SelectRange"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Clear"
		end

	frozen contains (date: SYSTEM_DATE_TIME): BOOLEAN is
		external
			"IL signature (System.DateTime): System.Boolean use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Contains"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Equals"
		end

	frozen remove (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Finalize"
		end

end -- class WEB_SELECTED_DATES_COLLECTION
