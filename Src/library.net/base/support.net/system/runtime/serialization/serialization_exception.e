indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.SerializationException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SERIALIZATION_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_serialization_exception,
	make_serialization_exception_2,
	make_serialization_exception_1

feature {NONE} -- Initialization

	frozen make_serialization_exception is
		external
			"IL creator use System.Runtime.Serialization.SerializationException"
		end

	frozen make_serialization_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Serialization.SerializationException"
		end

	frozen make_serialization_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Serialization.SerializationException"
		end

end -- class SERIALIZATION_EXCEPTION
