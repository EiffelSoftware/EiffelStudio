indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.InvalidComObjectException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	INVALID_COM_OBJECT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_invalid_com_object_exception_1,
	make_invalid_com_object_exception_2,
	make_invalid_com_object_exception

feature {NONE} -- Initialization

	frozen make_invalid_com_object_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.InvalidComObjectException"
		end

	frozen make_invalid_com_object_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.InvalidComObjectException"
		end

	frozen make_invalid_com_object_exception is
		external
			"IL creator use System.Runtime.InteropServices.InvalidComObjectException"
		end

end -- class INVALID_COM_OBJECT_EXCEPTION
