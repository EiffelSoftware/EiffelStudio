indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DuplicateNameException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DUPLICATE_NAME_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_duplicate_name_exception,
	make_data_duplicate_name_exception_1

feature {NONE} -- Initialization

	frozen make_data_duplicate_name_exception is
		external
			"IL creator use System.Data.DuplicateNameException"
		end

	frozen make_data_duplicate_name_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DuplicateNameException"
		end

end -- class DATA_DUPLICATE_NAME_EXCEPTION
