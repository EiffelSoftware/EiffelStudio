indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MissingMemberException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	MISSING_MEMBER_EXCEPTION

inherit
	MEMBER_ACCESS_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_missing_member_exception_1,
	make_missing_member_exception,
	make_missing_member_exception_3,
	make_missing_member_exception_2

feature {NONE} -- Initialization

	frozen make_missing_member_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.MissingMemberException"
		end

	frozen make_missing_member_exception is
		external
			"IL creator use System.MissingMemberException"
		end

	frozen make_missing_member_exception_3 (class_name: SYSTEM_STRING; member_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.MissingMemberException"
		end

	frozen make_missing_member_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MissingMemberException"
		end

feature -- Access

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.MissingMemberException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.MissingMemberException"
		alias
			"GetObjectData"
		end

end -- class MISSING_MEMBER_EXCEPTION
