indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataTableCollection"

external class
	SYSTEM_DATA_DATATABLECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_DATA_INTERNALDATACOLLECTIONBASE
		redefine
			get_list
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (name: STRING): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.String): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"get_Item"
		end

	frozen get_item_int32 (index: INTEGER): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.Int32): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changing (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"remove_CollectionChanging"
		end

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"add_CollectionChanged"
		end

	frozen add_collection_changing (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataTableCollection"
		alias
			"add_CollectionChanging"
		end

feature -- Basic Operations

	add_data_table (table: SYSTEM_DATA_DATATABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataTableCollection"
		alias
			"Add"
		end

	frozen remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataTableCollection"
		alias
			"Remove"
		end

	index_of (table: SYSTEM_DATA_DATATABLE): INTEGER is
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

	frozen contains (name: STRING): BOOLEAN is
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

	frozen add_range (tables: ARRAY [SYSTEM_DATA_DATATABLE]) is
		external
			"IL signature (System.Data.DataTable[]): System.Void use System.Data.DataTableCollection"
		alias
			"AddRange"
		end

	add: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"Add"
		end

	frozen remove_data_table (table: SYSTEM_DATA_DATATABLE) is
		external
			"IL signature (System.Data.DataTable): System.Void use System.Data.DataTableCollection"
		alias
			"Remove"
		end

	add_string (name: STRING): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.String): System.Data.DataTable use System.Data.DataTableCollection"
		alias
			"Add"
		end

	frozen can_remove (table: SYSTEM_DATA_DATATABLE): BOOLEAN is
		external
			"IL signature (System.Data.DataTable): System.Boolean use System.Data.DataTableCollection"
		alias
			"CanRemove"
		end

	index_of_string (table_name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.DataTableCollection"
		alias
			"IndexOf"
		end

feature {NONE} -- Implementation

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.DataTableCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataTableCollection"
		alias
			"OnCollectionChanged"
		end

	on_collection_changing (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataTableCollection"
		alias
			"OnCollectionChanging"
		end

end -- class SYSTEM_DATA_DATATABLECOLLECTION
