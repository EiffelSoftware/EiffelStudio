indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataRowCollection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_ROW_COLLECTION

inherit
	DATA_INTERNAL_DATA_COLLECTION_BASE
		redefine
			get_list
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): DATA_DATA_ROW is
		external
			"IL signature (System.Int32): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen insert_at (row: DATA_DATA_ROW; pos: INTEGER) is
		external
			"IL signature (System.Data.DataRow, System.Int32): System.Void use System.Data.DataRowCollection"
		alias
			"InsertAt"
		end

	frozen find_array_object (keys: NATIVE_ARRAY [SYSTEM_OBJECT]): DATA_DATA_ROW is
		external
			"IL signature (System.Object[]): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"Find"
		end

	frozen contains_array_object (keys: NATIVE_ARRAY [SYSTEM_OBJECT]): BOOLEAN is
		external
			"IL signature (System.Object[]): System.Boolean use System.Data.DataRowCollection"
		alias
			"Contains"
		end

	add_array_object (values: NATIVE_ARRAY [SYSTEM_OBJECT]): DATA_DATA_ROW is
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

	frozen contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.DataRowCollection"
		alias
			"Contains"
		end

	frozen add (row: DATA_DATA_ROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DataRowCollection"
		alias
			"Add"
		end

	frozen find (key: SYSTEM_OBJECT): DATA_DATA_ROW is
		external
			"IL signature (System.Object): System.Data.DataRow use System.Data.DataRowCollection"
		alias
			"Find"
		end

	frozen remove (row: DATA_DATA_ROW) is
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

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Data.DataRowCollection"
		alias
			"get_List"
		end

end -- class DATA_DATA_ROW_COLLECTION
