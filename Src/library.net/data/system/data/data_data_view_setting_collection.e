indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataViewSettingCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_VIEW_SETTING_COLLECTION

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
			"IL signature (): System.Boolean use System.Data.DataViewSettingCollection"
		alias
			"get_IsSynchronized"
		end

	get_item (table: DATA_DATA_TABLE): DATA_DATA_VIEW_SETTING is
		external
			"IL signature (System.Data.DataTable): System.Data.DataViewSetting use System.Data.DataViewSettingCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.DataViewSettingCollection"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataViewSettingCollection"
		alias
			"get_Count"
		end

	get_item_string (table_name: SYSTEM_STRING): DATA_DATA_VIEW_SETTING is
		external
			"IL signature (System.String): System.Data.DataViewSetting use System.Data.DataViewSettingCollection"
		alias
			"get_Item"
		end

	get_item_int32 (index: INTEGER): DATA_DATA_VIEW_SETTING is
		external
			"IL signature (System.Int32): System.Data.DataViewSetting use System.Data.DataViewSettingCollection"
		alias
			"get_Item"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.DataViewSettingCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_item_int32 (index: INTEGER; value: DATA_DATA_VIEW_SETTING) is
		external
			"IL signature (System.Int32, System.Data.DataViewSetting): System.Void use System.Data.DataViewSettingCollection"
		alias
			"set_Item"
		end

	set_item (table: DATA_DATA_TABLE; value: DATA_DATA_VIEW_SETTING) is
		external
			"IL signature (System.Data.DataTable, System.Data.DataViewSetting): System.Void use System.Data.DataViewSettingCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.DataViewSettingCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.DataViewSettingCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.DataViewSettingCollection"
		alias
			"ToString"
		end

	frozen copy_to (ar: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Data.DataViewSettingCollection"
		alias
			"CopyTo"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataViewSettingCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Data.DataViewSettingCollection"
		alias
			"Finalize"
		end

end -- class DATA_DATA_VIEW_SETTING_COLLECTION
