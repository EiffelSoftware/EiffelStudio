indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.DirectoryNotFoundException"

external class
	SYSTEM_IO_DIRECTORYNOTFOUNDEXCEPTION

inherit
	SYSTEM_IO_IOEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_directory_not_found_exception,
	make_directory_not_found_exception_1,
	make_directory_not_found_exception_2

feature {NONE} -- Initialization

	frozen make_directory_not_found_exception is
		external
			"IL creator use System.IO.DirectoryNotFoundException"
		end

	frozen make_directory_not_found_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.IO.DirectoryNotFoundException"
		end

	frozen make_directory_not_found_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.DirectoryNotFoundException"
		end

end -- class SYSTEM_IO_DIRECTORYNOTFOUNDEXCEPTION
