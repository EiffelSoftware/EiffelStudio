indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.NoNullAllowedException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_NO_NULL_ALLOWED_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_no_null_allowed_exception,
	make_data_no_null_allowed_exception_1

feature {NONE} -- Initialization

	frozen make_data_no_null_allowed_exception is
		external
			"IL creator use System.Data.NoNullAllowedException"
		end

	frozen make_data_no_null_allowed_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.NoNullAllowedException"
		end

end -- class DATA_NO_NULL_ALLOWED_EXCEPTION
