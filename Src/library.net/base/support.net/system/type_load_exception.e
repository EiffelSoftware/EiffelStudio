indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.TypeLoadException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TYPE_LOAD_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_type_load_exception_1,
	make_type_load_exception,
	make_type_load_exception_2

feature {NONE} -- Initialization

	frozen make_type_load_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.TypeLoadException"
		end

	frozen make_type_load_exception is
		external
			"IL creator use System.TypeLoadException"
		end

	frozen make_type_load_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.TypeLoadException"
		end

feature -- Access

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.TypeLoadException"
		alias
			"get_TypeName"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.TypeLoadException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.TypeLoadException"
		alias
			"GetObjectData"
		end

end -- class TYPE_LOAD_EXCEPTION
