indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EntryPointNotFoundException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ENTRY_POINT_NOT_FOUND_EXCEPTION

inherit
	TYPE_LOAD_EXCEPTION
	ISERIALIZABLE

create
	make_entry_point_not_found_exception_1,
	make_entry_point_not_found_exception_2,
	make_entry_point_not_found_exception

feature {NONE} -- Initialization

	frozen make_entry_point_not_found_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.EntryPointNotFoundException"
		end

	frozen make_entry_point_not_found_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.EntryPointNotFoundException"
		end

	frozen make_entry_point_not_found_exception is
		external
			"IL creator use System.EntryPointNotFoundException"
		end

end -- class ENTRY_POINT_NOT_FOUND_EXCEPTION
