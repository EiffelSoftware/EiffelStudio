indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.RowNotInTableException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_ROW_NOT_IN_TABLE_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_row_not_in_table_exception,
	make_data_row_not_in_table_exception_1

feature {NONE} -- Initialization

	frozen make_data_row_not_in_table_exception is
		external
			"IL creator use System.Data.RowNotInTableException"
		end

	frozen make_data_row_not_in_table_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.RowNotInTableException"
		end

end -- class DATA_ROW_NOT_IN_TABLE_EXCEPTION
