indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ThreadInterruptedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	THREAD_INTERRUPTED_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_thread_interrupted_exception,
	make_thread_interrupted_exception_2,
	make_thread_interrupted_exception_1

feature {NONE} -- Initialization

	frozen make_thread_interrupted_exception is
		external
			"IL creator use System.Threading.ThreadInterruptedException"
		end

	frozen make_thread_interrupted_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Threading.ThreadInterruptedException"
		end

	frozen make_thread_interrupted_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Threading.ThreadInterruptedException"
		end

end -- class THREAD_INTERRUPTED_EXCEPTION
