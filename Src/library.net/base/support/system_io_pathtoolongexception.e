indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.PathTooLongException"

external class
	SYSTEM_IO_PATHTOOLONGEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_path_too_long_exception_1,
	make_path_too_long_exception_2,
	make_path_too_long_exception

feature {NONE} -- Initialization

	frozen make_path_too_long_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.IO.PathTooLongException"
		end

	frozen make_path_too_long_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.PathTooLongException"
		end

	frozen make_path_too_long_exception is
		external
			"IL creator use System.IO.PathTooLongException"
		end

end -- class SYSTEM_IO_PATHTOOLONGEXCEPTION
