indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.IOException"

external class
	SYSTEM_IO_IOEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_io_exception_1,
	make_io_exception_3,
	make_io_exception_2,
	make_io_exception

feature {NONE} -- Initialization

	frozen make_io_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.IO.IOException"
		end

	frozen make_io_exception_3 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.IOException"
		end

	frozen make_io_exception_2 (message2: STRING; hresult2: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.IO.IOException"
		end

	frozen make_io_exception is
		external
			"IL creator use System.IO.IOException"
		end

end -- class SYSTEM_IO_IOEXCEPTION
