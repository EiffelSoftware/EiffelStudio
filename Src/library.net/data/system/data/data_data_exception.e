indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DATA_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_data_data_exception_2,
	make_data_data_exception_1,
	make_data_data_exception

feature {NONE} -- Initialization

	frozen make_data_data_exception_2 (s: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Data.DataException"
		end

	frozen make_data_data_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataException"
		end

	frozen make_data_data_exception is
		external
			"IL creator use System.Data.DataException"
		end

end -- class DATA_DATA_EXCEPTION
