indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DuplicateNameException"

external class
	SYSTEM_DATA_DUPLICATENAMEEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_duplicatenameexception,
	make_duplicatenameexception_1,
	make_duplicatenameexception_2

feature {NONE} -- Initialization

	frozen make_duplicatenameexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.DuplicateNameException"
		end

	frozen make_duplicatenameexception_1 is
		external
			"IL creator use System.Data.DuplicateNameException"
		end

	frozen make_duplicatenameexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DuplicateNameException"
		end

end -- class SYSTEM_DATA_DUPLICATENAMEEXCEPTION
