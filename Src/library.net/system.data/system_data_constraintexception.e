indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ConstraintException"

external class
	SYSTEM_DATA_CONSTRAINTEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_constraintexception_1,
	make_constraintexception,
	make_constraintexception_2

feature {NONE} -- Initialization

	frozen make_constraintexception_1 is
		external
			"IL creator use System.Data.ConstraintException"
		end

	frozen make_constraintexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.ConstraintException"
		end

	frozen make_constraintexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.ConstraintException"
		end

end -- class SYSTEM_DATA_CONSTRAINTEXCEPTION
