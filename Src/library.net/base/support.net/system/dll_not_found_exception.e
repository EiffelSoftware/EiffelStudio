indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DllNotFoundException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DLL_NOT_FOUND_EXCEPTION

inherit
	TYPE_LOAD_EXCEPTION
	ISERIALIZABLE

create
	make_dll_not_found_exception_2,
	make_dll_not_found_exception_1,
	make_dll_not_found_exception

feature {NONE} -- Initialization

	frozen make_dll_not_found_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.DllNotFoundException"
		end

	frozen make_dll_not_found_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.DllNotFoundException"
		end

	frozen make_dll_not_found_exception is
		external
			"IL creator use System.DllNotFoundException"
		end

end -- class DLL_NOT_FOUND_EXCEPTION
