indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRowCollection"

external class
	SYSTEM_DATA_DATAROWCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_DATA_INTERNALDATACOLLECTIONBASE
		redefine
			get_list
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Int32): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen find (keys: ARRAY [ANY]): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Object[]): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"Find"
		end

	frozen find_object (key: ANY): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Object): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"Find"
		end

	frozen insert_at (row: SYSTEM_DATA_DATAROW; pos: INTEGER) is
		external
			"IL signature (System.Data.DataRow, System.Int32): System.Void use System.Data.DataRowCollection"
		alias
			"InsertAt"
		end

	add_array_object (values: ARRAY [ANY]): SYSTEM_DATA_DATAROW is
		external
			"IL signature (System.Object[]): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Data.DataRowCollection"
		alias
			"Clear"
		end

	frozen contains (keys: ARRAY [ANY]): BOOLEAN is
		external
			"IL signature (System.Object[]): System.Boolean use System.Data.DataRowCollection"
		alias
			"Contains"
		end

	frozen add (row: SYSTEM_DATA_DATAROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataRowCollection"
		alias
			"Add"
		end

	frozen contains_object (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataRowCollection"
		alias
			"Contains"
		end

	frozen remove (row: SYSTEM_DATA_DATAROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataRowCollection"
		alias
			"Remove"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.DataRowCollection"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.DataRowCollection"
		alias
			"get_List"
		end

end -- class SYSTEM_DATA_DATAROWCOLLECTION
