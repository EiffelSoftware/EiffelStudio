indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DeletedRowInaccessibleException"

external class
	SYSTEM_DATA_DELETEDROWINACCESSIBLEEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_deletedrowinaccessibleexception_1,
	make_deletedrowinaccessibleexception_2,
	make_deletedrowinaccessibleexception

feature {NONE} -- Initialization

	frozen make_deletedrowinaccessibleexception_1 is
		external
			"IL creator use System.Data.DeletedRowInaccessibleException"
		end

	frozen make_deletedrowinaccessibleexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.DeletedRowInaccessibleException"
		end

	frozen make_deletedrowinaccessibleexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.DeletedRowInaccessibleException"
		end

end -- class SYSTEM_DATA_DELETEDROWINACCESSIBLEEXCEPTION
