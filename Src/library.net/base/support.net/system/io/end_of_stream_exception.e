indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.EndOfStreamException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	END_OF_STREAM_EXCEPTION

inherit
	IOEXCEPTION
	ISERIALIZABLE

create
	make_end_of_stream_exception_1,
	make_end_of_stream_exception,
	make_end_of_stream_exception_2

feature {NONE} -- Initialization

	frozen make_end_of_stream_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.EndOfStreamException"
		end

	frozen make_end_of_stream_exception is
		external
			"IL creator use System.IO.EndOfStreamException"
		end

	frozen make_end_of_stream_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.EndOfStreamException"
		end

end -- class END_OF_STREAM_EXCEPTION
