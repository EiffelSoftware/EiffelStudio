indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.RowNotInTableException"

external class
	SYSTEM_DATA_ROWNOTINTABLEEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_rownotintableexception,
	make_rownotintableexception_1,
	make_rownotintableexception_2

feature {NONE} -- Initialization

	frozen make_rownotintableexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.RowNotInTableException"
		end

	frozen make_rownotintableexception_1 is
		external
			"IL creator use System.Data.RowNotInTableException"
		end

	frozen make_rownotintableexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.RowNotInTableException"
		end

end -- class SYSTEM_DATA_ROWNOTINTABLEEXCEPTION
