indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ArgumentException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ARGUMENT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_argument_exception_4,
	make_argument_exception_3,
	make_argument_exception_2,
	make_argument_exception_1,
	make_argument_exception

feature {NONE} -- Initialization

	frozen make_argument_exception_4 (message: SYSTEM_STRING; param_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ArgumentException"
		end

	frozen make_argument_exception_3 (message: SYSTEM_STRING; param_name: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.ArgumentException"
		end

	frozen make_argument_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.ArgumentException"
		end

	frozen make_argument_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ArgumentException"
		end

	frozen make_argument_exception is
		external
			"IL creator use System.ArgumentException"
		end

feature -- Access

	get_param_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ArgumentException"
		alias
			"get_ParamName"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ArgumentException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ArgumentException"
		alias
			"GetObjectData"
		end

end -- class ARGUMENT_EXCEPTION
