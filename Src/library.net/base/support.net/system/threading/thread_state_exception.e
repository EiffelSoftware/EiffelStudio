indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadStateException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	THREAD_STATE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_thread_state_exception,
	make_thread_state_exception_2,
	make_thread_state_exception_1

feature {NONE} -- Initialization

	frozen make_thread_state_exception is
		external
			"IL creator use System.Threading.ThreadStateException"
		end

	frozen make_thread_state_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Threading.ThreadStateException"
		end

	frozen make_thread_state_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Threading.ThreadStateException"
		end

end -- class THREAD_STATE_EXCEPTION
