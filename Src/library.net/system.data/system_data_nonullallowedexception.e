indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.NoNullAllowedException"

external class
	SYSTEM_DATA_NONULLALLOWEDEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_nonullallowedexception,
	make_nonullallowedexception_1,
	make_nonullallowedexception_2

feature {NONE} -- Initialization

	frozen make_nonullallowedexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.NoNullAllowedException"
		end

	frozen make_nonullallowedexception_1 is
		external
			"IL creator use System.Data.NoNullAllowedException"
		end

	frozen make_nonullallowedexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.NoNullAllowedException"
		end

end -- class SYSTEM_DATA_NONULLALLOWEDEXCEPTION
