indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ArgumentException"

external class
	SYSTEM_ARGUMENTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_argument_exception,
	make_argument_exception_4,
	make_argument_exception_1,
	make_argument_exception_2,
	make_argument_exception_3

feature {NONE} -- Initialization

	frozen make_argument_exception is
		external
			"IL creator use System.ArgumentException"
		end

	frozen make_argument_exception_4 (message2: STRING; paramName2: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentException"
		end

	frozen make_argument_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentException"
		end

	frozen make_argument_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArgumentException"
		end

	frozen make_argument_exception_3 (message2: STRING; paramName2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.ArgumentException"
		end

feature -- Access

	get_message: STRING is
		external
			"IL signature (): System.String use System.ArgumentException"
		alias
			"get_Message"
		end

	get_param_name: STRING is
		external
			"IL signature (): System.String use System.ArgumentException"
		alias
			"get_ParamName"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ArgumentException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_ARGUMENTEXCEPTION
