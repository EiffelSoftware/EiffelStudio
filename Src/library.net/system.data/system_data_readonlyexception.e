indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ReadOnlyException"

external class
	SYSTEM_DATA_READONLYEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_readonlyexception,
	make_readonlyexception_1,
	make_readonlyexception_2

feature {NONE} -- Initialization

	frozen make_readonlyexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.ReadOnlyException"
		end

	frozen make_readonlyexception_1 is
		external
			"IL creator use System.Data.ReadOnlyException"
		end

	frozen make_readonlyexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.ReadOnlyException"
		end

end -- class SYSTEM_DATA_READONLYEXCEPTION
