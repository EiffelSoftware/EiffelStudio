indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.EvaluateException"

external class
	SYSTEM_DATA_EVALUATEEXCEPTION

inherit
	SYSTEM_DATA_INVALIDEXPRESSIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_evaluateexception_2,
	make_evaluateexception_1,
	make_evaluateexception

feature {NONE} -- Initialization

	frozen make_evaluateexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.EvaluateException"
		end

	frozen make_evaluateexception_1 is
		external
			"IL creator use System.Data.EvaluateException"
		end

	frozen make_evaluateexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.EvaluateException"
		end

end -- class SYSTEM_DATA_EVALUATEEXCEPTION
