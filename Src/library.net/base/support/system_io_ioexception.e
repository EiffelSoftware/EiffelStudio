indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.IOException"

external class
	SYSTEM_IO_IOEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_ioexception_1,
	make_ioexception_3,
	make_ioexception_2,
	make_ioexception

feature {NONE} -- Initialization

	frozen make_ioexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.IOException"
		end

	frozen make_ioexception_3 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.IOException"
		end

	frozen make_ioexception_2 (message: STRING; hresult: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.IO.IOException"
		end

	frozen make_ioexception is
		external
			"IL creator use System.IO.IOException"
		end

end -- class SYSTEM_IO_IOEXCEPTION
