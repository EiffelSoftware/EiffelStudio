indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.EndOfStreamException"

external class
	SYSTEM_IO_ENDOFSTREAMEXCEPTION

inherit
	SYSTEM_IO_IOEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_end_of_stream_exception_2,
	make_end_of_stream_exception,
	make_end_of_stream_exception_1

feature {NONE} -- Initialization

	frozen make_end_of_stream_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.EndOfStreamException"
		end

	frozen make_end_of_stream_exception is
		external
			"IL creator use System.IO.EndOfStreamException"
		end

	frozen make_end_of_stream_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.IO.EndOfStreamException"
		end

end -- class SYSTEM_IO_ENDOFSTREAMEXCEPTION
