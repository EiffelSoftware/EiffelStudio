indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.MissingPrimaryKeyException"

external class
	SYSTEM_DATA_MISSINGPRIMARYKEYEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_missingprimarykeyexception,
	make_missingprimarykeyexception_2,
	make_missingprimarykeyexception_1

feature {NONE} -- Initialization

	frozen make_missingprimarykeyexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.MissingPrimaryKeyException"
		end

	frozen make_missingprimarykeyexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.MissingPrimaryKeyException"
		end

	frozen make_missingprimarykeyexception_1 is
		external
			"IL creator use System.Data.MissingPrimaryKeyException"
		end

end -- class SYSTEM_DATA_MISSINGPRIMARYKEYEXCEPTION
