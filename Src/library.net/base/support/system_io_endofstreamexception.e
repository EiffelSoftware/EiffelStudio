indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.EndOfStreamException"

external class
	SYSTEM_IO_ENDOFSTREAMEXCEPTION

inherit
	SYSTEM_IO_IOEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_endofstreamexception_2,
	make_endofstreamexception,
	make_endofstreamexception_1

feature {NONE} -- Initialization

	frozen make_endofstreamexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.EndOfStreamException"
		end

	frozen make_endofstreamexception is
		external
			"IL creator use System.IO.EndOfStreamException"
		end

	frozen make_endofstreamexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.EndOfStreamException"
		end

end -- class SYSTEM_IO_ENDOFSTREAMEXCEPTION
