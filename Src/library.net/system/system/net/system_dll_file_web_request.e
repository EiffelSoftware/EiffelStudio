indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.FileWebRequest"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_FILE_WEB_REQUEST

inherit
	SYSTEM_DLL_WEB_REQUEST
		redefine
			end_get_request_stream,
			begin_get_request_stream,
			end_get_response,
			begin_get_response,
			get_response,
			get_request_stream,
			set_timeout,
			get_timeout,
			set_pre_authenticate,
			get_pre_authenticate,
			set_proxy,
			get_proxy,
			set_credentials,
			get_credentials,
			set_content_type,
			get_content_type,
			set_content_length,
			get_content_length,
			get_headers,
			set_connection_group_name,
			get_connection_group_name,
			get_request_uri,
			set_method,
			get_method
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end

create {NONE}

feature -- Access

	get_content_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.FileWebRequest"
		alias
			"get_ContentType"
		end

	get_method: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.FileWebRequest"
		alias
			"get_Method"
		end

	get_content_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.FileWebRequest"
		alias
			"get_ContentLength"
		end

	get_request_uri: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.FileWebRequest"
		alias
			"get_RequestUri"
		end

	get_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.FileWebRequest"
		alias
			"get_Headers"
		end

	get_proxy: SYSTEM_DLL_IWEB_PROXY is
		external
			"IL signature (): System.Net.IWebProxy use System.Net.FileWebRequest"
		alias
			"get_Proxy"
		end

	get_connection_group_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.FileWebRequest"
		alias
			"get_ConnectionGroupName"
		end

	get_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.FileWebRequest"
		alias
			"get_Timeout"
		end

	get_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL signature (): System.Net.ICredentials use System.Net.FileWebRequest"
		alias
			"get_Credentials"
		end

	get_pre_authenticate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.FileWebRequest"
		alias
			"get_PreAuthenticate"
		end

feature -- Element Change

	set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.FileWebRequest"
		alias
			"set_Credentials"
		end

	set_content_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.FileWebRequest"
		alias
			"set_ContentLength"
		end

	set_method (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.FileWebRequest"
		alias
			"set_Method"
		end

	set_content_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.FileWebRequest"
		alias
			"set_ContentType"
		end

	set_proxy (value: SYSTEM_DLL_IWEB_PROXY) is
		external
			"IL signature (System.Net.IWebProxy): System.Void use System.Net.FileWebRequest"
		alias
			"set_Proxy"
		end

	set_connection_group_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.FileWebRequest"
		alias
			"set_ConnectionGroupName"
		end

	set_pre_authenticate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.FileWebRequest"
		alias
			"set_PreAuthenticate"
		end

	set_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.FileWebRequest"
		alias
			"set_Timeout"
		end

feature -- Basic Operations

	begin_get_response (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.FileWebRequest"
		alias
			"BeginGetResponse"
		end

	end_get_request_stream (async_result: IASYNC_RESULT): SYSTEM_STREAM is
		external
			"IL signature (System.IAsyncResult): System.IO.Stream use System.Net.FileWebRequest"
		alias
			"EndGetRequestStream"
		end

	begin_get_request_stream (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.FileWebRequest"
		alias
			"BeginGetRequestStream"
		end

	get_request_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.FileWebRequest"
		alias
			"GetRequestStream"
		end

	get_response: SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (): System.Net.WebResponse use System.Net.FileWebRequest"
		alias
			"GetResponse"
		end

	end_get_response (async_result: IASYNC_RESULT): SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (System.IAsyncResult): System.Net.WebResponse use System.Net.FileWebRequest"
		alias
			"EndGetResponse"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.FileWebRequest"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DLL_FILE_WEB_REQUEST
