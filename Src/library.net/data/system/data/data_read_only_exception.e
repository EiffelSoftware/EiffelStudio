indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ReadOnlyException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_READ_ONLY_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_read_only_exception_1,
	make_data_read_only_exception

feature {NONE} -- Initialization

	frozen make_data_read_only_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.ReadOnlyException"
		end

	frozen make_data_read_only_exception is
		external
			"IL creator use System.Data.ReadOnlyException"
		end

end -- class DATA_READ_ONLY_EXCEPTION
