indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.InvalidExpressionException"

external class
	SYSTEM_DATA_INVALIDEXPRESSIONEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidexpressionexception,
	make_invalidexpressionexception_1,
	make_invalidexpressionexception_2

feature {NONE} -- Initialization

	frozen make_invalidexpressionexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.InvalidExpressionException"
		end

	frozen make_invalidexpressionexception_1 is
		external
			"IL creator use System.Data.InvalidExpressionException"
		end

	frozen make_invalidexpressionexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.InvalidExpressionException"
		end

end -- class SYSTEM_DATA_INVALIDEXPRESSIONEXCEPTION
