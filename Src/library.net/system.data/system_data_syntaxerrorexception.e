indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SyntaxErrorException"

external class
	SYSTEM_DATA_SYNTAXERROREXCEPTION

inherit
	SYSTEM_DATA_INVALIDEXPRESSIONEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_syntaxerrorexception,
	make_syntaxerrorexception_2,
	make_syntaxerrorexception_1

feature {NONE} -- Initialization

	frozen make_syntaxerrorexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.SyntaxErrorException"
		end

	frozen make_syntaxerrorexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.SyntaxErrorException"
		end

	frozen make_syntaxerrorexception_1 is
		external
			"IL creator use System.Data.SyntaxErrorException"
		end

end -- class SYSTEM_DATA_SYNTAXERROREXCEPTION
