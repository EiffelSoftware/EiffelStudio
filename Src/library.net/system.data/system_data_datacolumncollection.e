indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataColumnCollection"

external class
	SYSTEM_DATA_DATACOLUMNCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_DATA_INTERNALDATACOLLECTIONBASE
		redefine
			get_list
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	get_item (index: INTEGER): SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (System.Int32): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"get_Item"
		end

	get_item_string (name: STRING): SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (System.String): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataColumnCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Data.DataColumnCollection"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	frozen add_data_column (column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	add_string_type (column_name: STRING; type: SYSTEM_TYPE): SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (System.String, System.Type): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen remove (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.DataColumnCollection"
		alias
			"Remove"
		end

	frozen remove_data_column (column: SYSTEM_DATA_DATACOLUMN) is
		external
			"IL signature (System.Data.DataColumn): System.Void use System.Data.DataColumnCollection"
		alias
			"Remove"
		end

	frozen has (name: STRING): BOOLEAN is
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

	add_string_type_string (column_name: STRING; type: SYSTEM_TYPE; expression: STRING): SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (System.String, System.Type, System.String): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen add_range (columns: ARRAY [SYSTEM_DATA_DATACOLUMN]) is
		external
			"IL signature (System.Data.DataColumn[]): System.Void use System.Data.DataColumnCollection"
		alias
			"AddRange"
		end

	extend: SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen index_of (column_name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.DataColumnCollection"
		alias
			"IndexOf"
		end

	add_string (column_name: STRING): SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (System.String): System.Data.DataColumn use System.Data.DataColumnCollection"
		alias
			"Add"
		end

	frozen can_remove (column: SYSTEM_DATA_DATACOLUMN): BOOLEAN is
		external
			"IL signature (System.Data.DataColumn): System.Boolean use System.Data.DataColumnCollection"
		alias
			"CanRemove"
		end

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataColumnCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.DataColumnCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataColumnCollection"
		alias
			"OnCollectionChanged"
		end

	on_collection_changing (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Data.DataColumnCollection"
		alias
			"OnCollectionChanging"
		end

end -- class SYSTEM_DATA_DATACOLUMNCOLLECTION
