indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRowChangeEventArgs"

external class
	SYSTEM_DATA_DATAROWCHANGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_datarowchangeeventargs

feature {NONE} -- Initialization

	frozen make_datarowchangeeventargs (row: SYSTEM_DATA_DATAROW; action: SYSTEM_DATA_DATAROWACTION) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.DataRowAction) use System.Data.DataRowChangeEventArgs"
		end

feature -- Access

	frozen get_action: SYSTEM_DATA_DATAROWACTION is
		external
			"IL signature (): System.Data.DataRowAction use System.Data.DataRowChangeEventArgs"
		alias
			"get_Action"
		end

	frozen get_row: SYSTEM_DATA_DATAROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataRowChangeEventArgs"
		alias
			"get_Row"
		end

end -- class SYSTEM_DATA_DATAROWCHANGEEVENTARGS
