indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.FileNotFoundException"

external class
	SYSTEM_IO_FILENOTFOUNDEXCEPTION

inherit
	SYSTEM_IO_IOEXCEPTION
		redefine
			get_message,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_file_not_found_exception_4,
	make_file_not_found_exception,
	make_file_not_found_exception_2,
	make_file_not_found_exception_3,
	make_file_not_found_exception_1

feature {NONE} -- Initialization

	frozen make_file_not_found_exception_4 (message2: STRING; fileName2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception is
		external
			"IL creator use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_3 (message2: STRING; fileName2: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileNotFoundException"
		end

feature -- Access

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"get_FileName"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"ToString"
		end

end -- class SYSTEM_IO_FILENOTFOUNDEXCEPTION
