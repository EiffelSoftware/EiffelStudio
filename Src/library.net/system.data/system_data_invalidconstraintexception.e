indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.InvalidConstraintException"

external class
	SYSTEM_DATA_INVALIDCONSTRAINTEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidconstraintexception_1,
	make_invalidconstraintexception,
	make_invalidconstraintexception_2

feature {NONE} -- Initialization

	frozen make_invalidconstraintexception_1 is
		external
			"IL creator use System.Data.InvalidConstraintException"
		end

	frozen make_invalidconstraintexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.InvalidConstraintException"
		end

	frozen make_invalidconstraintexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.InvalidConstraintException"
		end

end -- class SYSTEM_DATA_INVALIDCONSTRAINTEXCEPTION
