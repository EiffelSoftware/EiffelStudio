indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.IOException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	IOEXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_ioexception_1,
	make_ioexception_3,
	make_ioexception_2,
	make_ioexception

feature {NONE} -- Initialization

	frozen make_ioexception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.IOException"
		end

	frozen make_ioexception_3 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.IOException"
		end

	frozen make_ioexception_2 (message: SYSTEM_STRING; hresult: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.IO.IOException"
		end

	frozen make_ioexception is
		external
			"IL creator use System.IO.IOException"
		end

end -- class IOEXCEPTION
