indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataColumnCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_COLUMN_COLLECTION

inherit
	DATA_INTERNAL_DATA_COLLECTION_BASE
		redefine
			get_list
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	get_item (index: INTEGER): DATA_DATA_COLUMN is
		external
			"IL signature (System.Int32): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"get_Item"
		end

	get_item_string (name: SYSTEM_STRING): DATA_DATA_COLUMN is
		external
			"IL signature (System.String): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataColumnCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataColumnCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	frozen add_data_column (column: DATA_DATA_COLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	add_string_type (column_name: SYSTEM_STRING; type: TYPE): DATA_DATA_COLUMN is
		external
			"IL signature (System.String, System.Type): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumnCollection"
		alias
			"Remove"
		end

	index_of_data_column (column: DATA_DATA_COLUMN): INTEGER is
		external
			"IL signature (System.Data.DataColumn): System.Int32 use System.Data.DataColumnCollection"
		alias
			"IndexOf"
		end

	frozen remove_data_column (column: DATA_DATA_COLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataColumnCollection"
		alias
			"Remove"
		end

	frozen contains (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.DataColumnCollection"
		alias
			"Contains"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.DataColumnCollection"
		alias
			"Clear"
		end

	frozen can_remove (column: DATA_DATA_COLUMN): BOOLEAN is
		external
			"IL signature (System.Data.DataColumn): System.Boolean use System.Data.DataColumnCollection"
		alias
			"CanRemove"
		end

	frozen add_range (columns: NATIVE_ARRAY [DATA_DATA_COLUMN]) is
		external
			"IL signature (System.Data.DataColumn[]): System.Void use System.Data.DataColumnCollection"
		alias
			"AddRange"
		end

	add: DATA_DATA_COLUMN is
		external
			"IL signature (): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen index_of (column_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.DataColumnCollection"
		alias
			"IndexOf"
		end

	add_string (column_name: SYSTEM_STRING): DATA_DATA_COLUMN is
		external
			"IL signature (System.String): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	add_string_type_string (column_name: SYSTEM_STRING; type: TYPE; expression: SYSTEM_STRING): DATA_DATA_COLUMN is
		external
			"IL signature (System.String, System.Type, System.String): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataColumnCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.DataColumnCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataColumnCollection"
		alias
			"OnCollectionChanged"
		end

	on_collection_changing (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataColumnCollection"
		alias
			"OnCollectionChanging"
		end

end -- class DATA_DATA_COLUMN_COLLECTION
