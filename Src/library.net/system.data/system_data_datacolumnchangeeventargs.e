indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataColumnChangeEventArgs"

external class
	SYSTEM_DATA_DATACOLUMNCHANGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_datacolumnchangeeventargs

feature {NONE} -- Initialization

	frozen make_datacolumnchangeeventargs (row: SYSTEM_DATA_DATAROW; column: SYSTEM_DATA_DATACOLUMN; value: ANY) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.DataColumn, System.Object) use System.Data.DataColumnChangeEventArgs"
		end

feature -- Access

	frozen get_column: SYSTEM_DATA_DATACOLUMN is
		external
			"IL signature (): System.Data.DataColumn use System.Data.DataColumnChangeEventArgs"
		alias
			"get_Column"
		end

	frozen get_proposed_value: ANY is
		external
			"IL signature (): System.Object use System.Data.DataColumnChangeEventArgs"
		alias
			"get_ProposedValue"
		end

	frozen get_row: SYSTEM_DATA_DATAROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataColumnChangeEventArgs"
		alias
			"get_Row"
		end

feature -- Element Change

	frozen set_proposed_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Data.DataColumnChangeEventArgs"
		alias
			"set_ProposedValue"
		end

end -- class SYSTEM_DATA_DATACOLUMNCHANGEEVENTARGS
