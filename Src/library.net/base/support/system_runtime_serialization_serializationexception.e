indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.SerializationException"

external class
	SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_serialization_exception,
	make_serialization_exception_1,
	make_serialization_exception_2

feature {NONE} -- Initialization

	frozen make_serialization_exception is
		external
			"IL creator use System.Runtime.Serialization.SerializationException"
		end

	frozen make_serialization_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Serialization.SerializationException"
		end

	frozen make_serialization_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Serialization.SerializationException"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONEXCEPTION
