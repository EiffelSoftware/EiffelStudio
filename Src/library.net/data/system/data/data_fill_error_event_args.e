indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.FillErrorEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_FILL_ERROR_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_data_fill_error_event_args

feature {NONE} -- Initialization

	frozen make_data_fill_error_event_args (data_table: DATA_DATA_TABLE; values: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL creator signature (System.Data.DataTable, System.Object[]) use System.Data.FillErrorEventArgs"
		end

feature -- Access

	frozen get_errors: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Data.FillErrorEventArgs"
		alias
			"get_Errors"
		end

	frozen get_values: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Data.FillErrorEventArgs"
		alias
			"get_Values"
		end

	frozen get_data_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.FillErrorEventArgs"
		alias
			"get_DataTable"
		end

	frozen get_continue: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.FillErrorEventArgs"
		alias
			"get_Continue"
		end

feature -- Element Change

	frozen set_continue (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.FillErrorEventArgs"
		alias
			"set_Continue"
		end

	frozen set_errors (value: EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Data.FillErrorEventArgs"
		alias
			"set_Errors"
		end

end -- class DATA_FILL_ERROR_EVENT_ARGS
