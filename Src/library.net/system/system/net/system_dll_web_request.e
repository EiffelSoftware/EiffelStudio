indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebRequest"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_WEB_REQUEST

inherit
	MARSHAL_BY_REF_OBJECT
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

feature -- Access

	get_content_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebRequest"
		alias
			"get_ContentType"
		end

	get_method: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebRequest"
		alias
			"get_Method"
		end

	get_content_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.WebRequest"
		alias
			"get_ContentLength"
		end

	get_request_uri: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.WebRequest"
		alias
			"get_RequestUri"
		end

	get_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebRequest"
		alias
			"get_Headers"
		end

	get_proxy: SYSTEM_DLL_IWEB_PROXY is
		external
			"IL signature (): System.Net.IWebProxy use System.Net.WebRequest"
		alias
			"get_Proxy"
		end

	get_connection_group_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebRequest"
		alias
			"get_ConnectionGroupName"
		end

	get_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.WebRequest"
		alias
			"get_Timeout"
		end

	get_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL signature (): System.Net.ICredentials use System.Net.WebRequest"
		alias
			"get_Credentials"
		end

	get_pre_authenticate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.WebRequest"
		alias
			"get_PreAuthenticate"
		end

feature -- Element Change

	set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.WebRequest"
		alias
			"set_Credentials"
		end

	set_connection_group_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebRequest"
		alias
			"set_ConnectionGroupName"
		end

	set_method (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebRequest"
		alias
			"set_Method"
		end

	set_content_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebRequest"
		alias
			"set_ContentType"
		end

	set_headers (value: SYSTEM_DLL_WEB_HEADER_COLLECTION) is
		external
			"IL signature (System.Net.WebHeaderCollection): System.Void use System.Net.WebRequest"
		alias
			"set_Headers"
		end

	set_proxy (value: SYSTEM_DLL_IWEB_PROXY) is
		external
			"IL signature (System.Net.IWebProxy): System.Void use System.Net.WebRequest"
		alias
			"set_Proxy"
		end

	set_content_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.WebRequest"
		alias
			"set_ContentLength"
		end

	set_pre_authenticate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.WebRequest"
		alias
			"set_PreAuthenticate"
		end

	set_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.WebRequest"
		alias
			"set_Timeout"
		end

feature -- Basic Operations

	end_get_response (async_result: IASYNC_RESULT): SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (System.IAsyncResult): System.Net.WebResponse use System.Net.WebRequest"
		alias
			"EndGetResponse"
		end

	begin_get_request_stream (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.WebRequest"
		alias
			"BeginGetRequestStream"
		end

	get_response: SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (): System.Net.WebResponse use System.Net.WebRequest"
		alias
			"GetResponse"
		end

	abort is
		external
			"IL signature (): System.Void use System.Net.WebRequest"
		alias
			"Abort"
		end

	frozen register_prefix (prefix_: SYSTEM_STRING; creator: SYSTEM_DLL_IWEB_REQUEST_CREATE): BOOLEAN is
		external
			"IL static signature (System.String, System.Net.IWebRequestCreate): System.Boolean use System.Net.WebRequest"
		alias
			"RegisterPrefix"
		end

	get_request_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.WebRequest"
		alias
			"GetRequestStream"
		end

	begin_get_response (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.WebRequest"
		alias
			"BeginGetResponse"
		end

	frozen create__string (request_uri_string: SYSTEM_STRING): SYSTEM_DLL_WEB_REQUEST is
		external
			"IL static signature (System.String): System.Net.WebRequest use System.Net.WebRequest"
		alias
			"Create"
		end

	frozen create_ (request_uri: SYSTEM_DLL_URI): SYSTEM_DLL_WEB_REQUEST is
		external
			"IL static signature (System.Uri): System.Net.WebRequest use System.Net.WebRequest"
		alias
			"Create"
		end

	end_get_request_stream (async_result: IASYNC_RESULT): SYSTEM_STREAM is
		external
			"IL signature (System.IAsyncResult): System.IO.Stream use System.Net.WebRequest"
		alias
			"EndGetRequestStream"
		end

	frozen create_default (request_uri: SYSTEM_DLL_URI): SYSTEM_DLL_WEB_REQUEST is
		external
			"IL static signature (System.Uri): System.Net.WebRequest use System.Net.WebRequest"
		alias
			"CreateDefault"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebRequest"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DLL_WEB_REQUEST
