indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.StrongTypingException"

external class
	SYSTEM_DATA_STRONGTYPINGEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_strongtypingexception,
	make_strongtypingexception_1,
	make_strongtypingexception_2

feature {NONE} -- Initialization

	frozen make_strongtypingexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.StrongTypingException"
		end

	frozen make_strongtypingexception_1 is
		external
			"IL creator use System.Data.StrongTypingException"
		end

	frozen make_strongtypingexception_2 (s: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Data.StrongTypingException"
		end

end -- class SYSTEM_DATA_STRONGTYPINGEXCEPTION
