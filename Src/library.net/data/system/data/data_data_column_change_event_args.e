indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataColumnChangeEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_COLUMN_CHANGE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_data_data_column_change_event_args

feature {NONE} -- Initialization

	frozen make_data_data_column_change_event_args (row: DATA_DATA_ROW; column: DATA_DATA_COLUMN; value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Data.DataRow, System.Data.DataColumn, System.Object) use System.Data.DataColumnChangeEventArgs"
		end

feature -- Access

	frozen get_column: DATA_DATA_COLUMN is
		external
			"IL signature (): System.Data.DataColumn use System.Data.DataColumnChangeEventArgs"
		alias
			"get_Column"
		end

	frozen get_proposed_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.DataColumnChangeEventArgs"
		alias
			"get_ProposedValue"
		end

	frozen get_row: DATA_DATA_ROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DataColumnChangeEventArgs"
		alias
			"get_Row"
		end

feature -- Element Change

	frozen set_proposed_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Data.DataColumnChangeEventArgs"
		alias
			"set_ProposedValue"
		end

end -- class DATA_DATA_COLUMN_CHANGE_EVENT_ARGS
