indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataException"

external class
	SYSTEM_DATA_DATAEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_dataexception_2,
	make_dataexception_3,
	make_dataexception,
	make_dataexception_1

feature {NONE} -- Initialization

	frozen make_dataexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DataException"
		end

	frozen make_dataexception_3 (s: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Data.DataException"
		end

	frozen make_dataexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.DataException"
		end

	frozen make_dataexception_1 is
		external
			"IL creator use System.Data.DataException"
		end

end -- class SYSTEM_DATA_DATAEXCEPTION
