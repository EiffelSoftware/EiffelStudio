indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.SerializationException"

external class
	SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_serializationexception,
	make_serializationexception_1,
	make_serializationexception_2

feature {NONE} -- Initialization

	frozen make_serializationexception is
		external
			"IL creator use System.Runtime.Serialization.SerializationException"
		end

	frozen make_serializationexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Serialization.SerializationException"
		end

	frozen make_serializationexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.Serialization.SerializationException"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONEXCEPTION
