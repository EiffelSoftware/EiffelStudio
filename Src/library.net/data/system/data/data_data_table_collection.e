indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataTableCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_TABLE_COLLECTION

inherit
	DATA_INTERNAL_DATA_COLLECTION_BASE
		redefine
			get_list
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (name: SYSTEM_STRING): DATA_DATA_TABLE is
		external
			"IL signature (System.String): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"get_Item"
		end

	frozen get_item_int32 (index: INTEGER): DATA_DATA_TABLE is
		external
			"IL signature (System.Int32): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changing (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"remove_CollectionChanging"
		end

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"add_CollectionChanged"
		end

	frozen add_collection_changing (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"add_CollectionChanging"
		end

feature -- Basic Operations

	add_data_table (table: DATA_DATA_TABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataTableCollection"
		alias
			"Add"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTableCollection"
		alias
			"Remove"
		end

	index_of (table: DATA_DATA_TABLE): INTEGER is
		external
			"IL signature (System.Data.DataTable): System.Int32 use System.Data.DataTableCollection"
		alias
			"IndexOf"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.DataTableCollection"
		alias
			"Clear"
		end

	frozen contains (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Data.DataTableCollection"
		alias
			"Contains"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataTableCollection"
		alias
			"RemoveAt"
		end

	frozen add_range (tables: NATIVE_ARRAY [DATA_DATA_TABLE]) is
		external
			"IL signature (System.Data.DataTable[]): System.Void use System.Data.DataTableCollection"
		alias
			"AddRange"
		end

	add: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"Add"
		end

	frozen remove_data_table (table: DATA_DATA_TABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataTableCollection"
		alias
			"Remove"
		end

	add_string (name: SYSTEM_STRING): DATA_DATA_TABLE is
		external
			"IL signature (System.String): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"Add"
		end

	frozen can_remove (table: DATA_DATA_TABLE): BOOLEAN is
		external
			"IL signature (System.Data.DataTable): System.Boolean use System.Data.DataTableCollection"
		alias
			"CanRemove"
		end

	index_of_string (table_name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.DataTableCollection"
		alias
			"IndexOf"
		end

feature {NONE} -- Implementation

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.DataTableCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataTableCollection"
		alias
			"OnCollectionChanged"
		end

	on_collection_changing (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataTableCollection"
		alias
			"OnCollectionChanging"
		end

end -- class DATA_DATA_TABLE_COLLECTION
