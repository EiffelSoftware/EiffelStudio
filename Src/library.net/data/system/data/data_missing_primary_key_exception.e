indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.MissingPrimaryKeyException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_MISSING_PRIMARY_KEY_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_missing_primary_key_exception_1,
	make_data_missing_primary_key_exception

feature {NONE} -- Initialization

	frozen make_data_missing_primary_key_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.MissingPrimaryKeyException"
		end

	frozen make_data_missing_primary_key_exception is
		external
			"IL creator use System.Data.MissingPrimaryKeyException"
		end

end -- class DATA_MISSING_PRIMARY_KEY_EXCEPTION
