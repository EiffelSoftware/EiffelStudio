indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.VersionNotFoundException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_VERSION_NOT_FOUND_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_version_not_found_exception_1,
	make_data_version_not_found_exception

feature {NONE} -- Initialization

	frozen make_data_version_not_found_exception_1 (s: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.VersionNotFoundException"
		end

	frozen make_data_version_not_found_exception is
		external
			"IL creator use System.Data.VersionNotFoundException"
		end

end -- class DATA_VERSION_NOT_FOUND_EXCEPTION
