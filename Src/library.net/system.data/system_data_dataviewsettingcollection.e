indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataViewSettingCollection"

external class
	SYSTEM_DATA_DATAVIEWSETTINGCOLLECTION

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
			"IL signature (): System.Boolean use System.Data.DataViewSettingCollection"
		alias
			"get_IsSynchronized"
		end

	get_item (table: SYSTEM_DATA_DATATABLE): SYSTEM_DATA_DATAVIEWSETTING is
		external
			"IL signature (System.Data.DataTable): System.Data.DataViewSetting use System.Data.DataViewSettingCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
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

	get_item_string (table_name: STRING): SYSTEM_DATA_DATAVIEWSETTING is
		external
			"IL signature (System.String): System.Data.DataViewSetting use System.Data.DataViewSettingCollection"
		alias
			"get_Item"
		end

	get_item_int32 (index: INTEGER): SYSTEM_DATA_DATAVIEWSETTING is
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

	set_item_int32 (index: INTEGER; value: SYSTEM_DATA_DATAVIEWSETTING) is
		external
			"IL signature (System.Int32, System.Data.DataViewSetting): System.Void use System.Data.DataViewSettingCollection"
		alias
			"set_Item"
		end

	set_item (table: SYSTEM_DATA_DATATABLE; value: SYSTEM_DATA_DATAVIEWSETTING) is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.DataViewSettingCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
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

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_DATA_DATAVIEWSETTINGCOLLECTION
