indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebException"

external class
	SYSTEM_NET_WEBEXCEPTION

inherit
	SYSTEM_EXCEPTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_webexception_3,
	make_webexception_2,
	make_webexception_1,
	make_webexception,
	make_webexception_4

feature {NONE} -- Initialization

	frozen make_webexception_3 (message: STRING; status: SYSTEM_NET_WEBEXCEPTIONSTATUS) is
		external
			"IL creator signature (System.String, System.Net.WebExceptionStatus) use System.Net.WebException"
		end

	frozen make_webexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Net.WebException"
		end

	frozen make_webexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Net.WebException"
		end

	frozen make_webexception is
		external
			"IL creator use System.Net.WebException"
		end

	frozen make_webexception_4 (message: STRING; inner_exception: SYSTEM_EXCEPTION; status: SYSTEM_NET_WEBEXCEPTIONSTATUS; response: SYSTEM_NET_WEBRESPONSE) is
		external
			"IL creator signature (System.String, System.Exception, System.Net.WebExceptionStatus, System.Net.WebResponse) use System.Net.WebException"
		end

feature -- Access

	frozen get_status: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL signature (): System.Net.WebExceptionStatus use System.Net.WebException"
		alias
			"get_Status"
		end

	frozen get_response: SYSTEM_NET_WEBRESPONSE is
		external
			"IL signature (): System.Net.WebResponse use System.Net.WebException"
		alias
			"get_Response"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_NET_WEBEXCEPTION
