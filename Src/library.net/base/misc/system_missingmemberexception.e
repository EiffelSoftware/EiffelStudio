indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.MissingMemberException"

external class
	SYSTEM_MISSINGMEMBEREXCEPTION

inherit
	SYSTEM_MEMBERACCESSEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_missingmemberexception,
	make_missingmemberexception_3,
	make_missingmemberexception_2,
	make_missingmemberexception_1

feature {NONE} -- Initialization

	frozen make_missingmemberexception is
		external
			"IL creator use System.MissingMemberException"
		end

	frozen make_missingmemberexception_3 (class_name: STRING; member_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.MissingMemberException"
		end

	frozen make_missingmemberexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MissingMemberException"
		end

	frozen make_missingmemberexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.MissingMemberException"
		end

feature -- Access

	get_message: STRING is
		external
			"IL signature (): System.String use System.MissingMemberException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.MissingMemberException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_MISSINGMEMBEREXCEPTION
