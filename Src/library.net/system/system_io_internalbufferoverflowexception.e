indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.InternalBufferOverflowException"

external class
	SYSTEM_IO_INTERNALBUFFEROVERFLOWEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_internalbufferoverflowexception,
	make_internalbufferoverflowexception_1,
	make_internalbufferoverflowexception_2

feature {NONE} -- Initialization

	frozen make_internalbufferoverflowexception is
		external
			"IL creator use System.IO.InternalBufferOverflowException"
		end

	frozen make_internalbufferoverflowexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.InternalBufferOverflowException"
		end

	frozen make_internalbufferoverflowexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.InternalBufferOverflowException"
		end

end -- class SYSTEM_IO_INTERNALBUFFEROVERFLOWEXCEPTION
