indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.SelectedDatesCollection"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_SELECTEDDATESCOLLECTION

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

	frozen make (date_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
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

	frozen get_item (index: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32): System.DateTime use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"ToString"
		end

	frozen add (date: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Add"
		end

	frozen select_range (from_date: SYSTEM_DATETIME; to_date: SYSTEM_DATETIME) is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	frozen contains (date: SYSTEM_DATETIME): BOOLEAN is
		external
			"IL signature (System.DateTime): System.Boolean use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Contains"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.SelectedDatesCollection"
		alias
			"Equals"
		end

	frozen remove (date: SYSTEM_DATETIME) is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_SELECTEDDATESCOLLECTION
