indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_WEB_EXCEPTION

inherit
	INVALID_OPERATION_EXCEPTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_system_dll_web_exception_4,
	make_system_dll_web_exception_2,
	make_system_dll_web_exception_1,
	make_system_dll_web_exception_3,
	make_system_dll_web_exception

feature {NONE} -- Initialization

	frozen make_system_dll_web_exception_4 (message: SYSTEM_STRING; inner_exception: EXCEPTION; status: SYSTEM_DLL_WEB_EXCEPTION_STATUS; response: SYSTEM_DLL_WEB_RESPONSE) is
		external
			"IL creator signature (System.String, System.Exception, System.Net.WebExceptionStatus, System.Net.WebResponse) use System.Net.WebException"
		end

	frozen make_system_dll_web_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Net.WebException"
		end

	frozen make_system_dll_web_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Net.WebException"
		end

	frozen make_system_dll_web_exception_3 (message: SYSTEM_STRING; status: SYSTEM_DLL_WEB_EXCEPTION_STATUS) is
		external
			"IL creator signature (System.String, System.Net.WebExceptionStatus) use System.Net.WebException"
		end

	frozen make_system_dll_web_exception is
		external
			"IL creator use System.Net.WebException"
		end

feature -- Access

	frozen get_status: SYSTEM_DLL_WEB_EXCEPTION_STATUS is
		external
			"IL signature (): System.Net.WebExceptionStatus use System.Net.WebException"
		alias
			"get_Status"
		end

	frozen get_response: SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (): System.Net.WebResponse use System.Net.WebException"
		alias
			"get_Response"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DLL_WEB_EXCEPTION
