indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ObjectDisposedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	OBJECT_DISPOSED_EXCEPTION

inherit
	INVALID_OPERATION_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_object_disposed_exception,
	make_object_disposed_exception_1

feature {NONE} -- Initialization

	frozen make_object_disposed_exception (object_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ObjectDisposedException"
		end

	frozen make_object_disposed_exception_1 (object_name: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ObjectDisposedException"
		end

feature -- Access

	frozen get_object_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ObjectDisposedException"
		alias
			"get_ObjectName"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ObjectDisposedException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ObjectDisposedException"
		alias
			"GetObjectData"
		end

end -- class OBJECT_DISPOSED_EXCEPTION
