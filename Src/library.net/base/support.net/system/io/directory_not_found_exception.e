indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.DirectoryNotFoundException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DIRECTORY_NOT_FOUND_EXCEPTION

inherit
	IOEXCEPTION
	ISERIALIZABLE

create
	make_directory_not_found_exception_2,
	make_directory_not_found_exception_1,
	make_directory_not_found_exception

feature {NONE} -- Initialization

	frozen make_directory_not_found_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.DirectoryNotFoundException"
		end

	frozen make_directory_not_found_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.DirectoryNotFoundException"
		end

	frozen make_directory_not_found_exception is
		external
			"IL creator use System.IO.DirectoryNotFoundException"
		end

end -- class DIRECTORY_NOT_FOUND_EXCEPTION
