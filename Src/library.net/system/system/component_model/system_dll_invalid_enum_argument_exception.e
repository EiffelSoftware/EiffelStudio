indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.InvalidEnumArgumentException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INVALID_ENUM_ARGUMENT_EXCEPTION

inherit
	ARGUMENT_EXCEPTION
	ISERIALIZABLE

create
	make_system_dll_invalid_enum_argument_exception,
	make_system_dll_invalid_enum_argument_exception_1,
	make_system_dll_invalid_enum_argument_exception_2

feature {NONE} -- Initialization

	frozen make_system_dll_invalid_enum_argument_exception is
		external
			"IL creator use System.ComponentModel.InvalidEnumArgumentException"
		end

	frozen make_system_dll_invalid_enum_argument_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.InvalidEnumArgumentException"
		end

	frozen make_system_dll_invalid_enum_argument_exception_2 (argument_name: SYSTEM_STRING; invalid_value: INTEGER; enum_class: TYPE) is
		external
			"IL creator signature (System.String, System.Int32, System.Type) use System.ComponentModel.InvalidEnumArgumentException"
		end

end -- class SYSTEM_DLL_INVALID_ENUM_ARGUMENT_EXCEPTION
