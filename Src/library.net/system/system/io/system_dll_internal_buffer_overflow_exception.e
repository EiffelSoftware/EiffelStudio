indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.InternalBufferOverflowException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_INTERNAL_BUFFER_OVERFLOW_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_system_dll_internal_buffer_overflow_exception_2,
	make_system_dll_internal_buffer_overflow_exception,
	make_system_dll_internal_buffer_overflow_exception_1

feature {NONE} -- Initialization

	frozen make_system_dll_internal_buffer_overflow_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.InternalBufferOverflowException"
		end

	frozen make_system_dll_internal_buffer_overflow_exception is
		external
			"IL creator use System.IO.InternalBufferOverflowException"
		end

	frozen make_system_dll_internal_buffer_overflow_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.InternalBufferOverflowException"
		end

end -- class SYSTEM_DLL_INTERNAL_BUFFER_OVERFLOW_EXCEPTION
