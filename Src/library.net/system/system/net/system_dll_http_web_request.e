indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.HttpWebRequest"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_HTTP_WEB_REQUEST

inherit
	SYSTEM_DLL_WEB_REQUEST
		redefine
			abort,
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
			set_headers,
			get_headers,
			set_connection_group_name,
			get_connection_group_name,
			get_request_uri,
			set_method,
			get_method,
			get_hash_code
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end

create {NONE}

feature -- Access

	get_pre_authenticate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_PreAuthenticate"
		end

	frozen get_client_certificates: SYSTEM_DLL_X509_CERTIFICATE_COLLECTION is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509CertificateCollection use System.Net.HttpWebRequest"
		alias
			"get_ClientCertificates"
		end

	frozen get_referer: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Referer"
		end

	frozen get_have_response: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_HaveResponse"
		end

	frozen get_transfer_encoding: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_TransferEncoding"
		end

	frozen get_continue_delegate: SYSTEM_DLL_HTTP_CONTINUE_DELEGATE is
		external
			"IL signature (): System.Net.HttpContinueDelegate use System.Net.HttpWebRequest"
		alias
			"get_ContinueDelegate"
		end

	frozen get_media_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_MediaType"
		end

	frozen get_keep_alive: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_KeepAlive"
		end

	get_connection_group_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_ConnectionGroupName"
		end

	frozen get_maximum_automatic_redirections: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.HttpWebRequest"
		alias
			"get_MaximumAutomaticRedirections"
		end

	get_request_uri: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.HttpWebRequest"
		alias
			"get_RequestUri"
		end

	get_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.HttpWebRequest"
		alias
			"get_Timeout"
		end

	frozen get_send_chunked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_SendChunked"
		end

	frozen get_if_modified_since: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Net.HttpWebRequest"
		alias
			"get_IfModifiedSince"
		end

	get_proxy: SYSTEM_DLL_IWEB_PROXY is
		external
			"IL signature (): System.Net.IWebProxy use System.Net.HttpWebRequest"
		alias
			"get_Proxy"
		end

	get_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL signature (): System.Net.ICredentials use System.Net.HttpWebRequest"
		alias
			"get_Credentials"
		end

	get_content_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.HttpWebRequest"
		alias
			"get_ContentLength"
		end

	frozen get_service_point: SYSTEM_DLL_SERVICE_POINT is
		external
			"IL signature (): System.Net.ServicePoint use System.Net.HttpWebRequest"
		alias
			"get_ServicePoint"
		end

	frozen get_allow_write_stream_buffering: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_AllowWriteStreamBuffering"
		end

	frozen get_connection: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Connection"
		end

	get_method: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Method"
		end

	get_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.HttpWebRequest"
		alias
			"get_Headers"
		end

	frozen get_allow_auto_redirect: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_AllowAutoRedirect"
		end

	get_content_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_ContentType"
		end

	frozen get_protocol_version: VERSION is
		external
			"IL signature (): System.Version use System.Net.HttpWebRequest"
		alias
			"get_ProtocolVersion"
		end

	frozen get_cookie_container: SYSTEM_DLL_COOKIE_CONTAINER is
		external
			"IL signature (): System.Net.CookieContainer use System.Net.HttpWebRequest"
		alias
			"get_CookieContainer"
		end

	frozen get_pipelined: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_Pipelined"
		end

	frozen get_expect: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Expect"
		end

	frozen get_address: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.HttpWebRequest"
		alias
			"get_Address"
		end

	frozen get_accept: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Accept"
		end

	frozen get_user_agent: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_UserAgent"
		end

feature -- Element Change

	frozen set_connection (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Connection"
		end

	frozen set_accept (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Accept"
		end

	frozen set_send_chunked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_SendChunked"
		end

	set_proxy (value: SYSTEM_DLL_IWEB_PROXY) is
		external
			"IL signature (System.Net.IWebProxy): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Proxy"
		end

	set_content_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ContentLength"
		end

	frozen set_pipelined (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Pipelined"
		end

	set_method (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Method"
		end

	frozen set_keep_alive (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_KeepAlive"
		end

	frozen set_user_agent (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_UserAgent"
		end

	frozen set_transfer_encoding (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_TransferEncoding"
		end

	frozen set_referer (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Referer"
		end

	frozen set_media_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_MediaType"
		end

	frozen set_expect (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Expect"
		end

	set_headers (value: SYSTEM_DLL_WEB_HEADER_COLLECTION) is
		external
			"IL signature (System.Net.WebHeaderCollection): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Headers"
		end

	set_content_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ContentType"
		end

	set_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Timeout"
		end

	frozen set_allow_write_stream_buffering (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_AllowWriteStreamBuffering"
		end

	frozen set_maximum_automatic_redirections (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"set_MaximumAutomaticRedirections"
		end

	set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Credentials"
		end

	frozen set_allow_auto_redirect (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_AllowAutoRedirect"
		end

	set_connection_group_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ConnectionGroupName"
		end

	frozen set_continue_delegate (value: SYSTEM_DLL_HTTP_CONTINUE_DELEGATE) is
		external
			"IL signature (System.Net.HttpContinueDelegate): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ContinueDelegate"
		end

	frozen set_protocol_version (value: VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ProtocolVersion"
		end

	frozen set_if_modified_since (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Net.HttpWebRequest"
		alias
			"set_IfModifiedSince"
		end

	set_pre_authenticate (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_PreAuthenticate"
		end

	frozen set_cookie_container (value: SYSTEM_DLL_COOKIE_CONTAINER) is
		external
			"IL signature (System.Net.CookieContainer): System.Void use System.Net.HttpWebRequest"
		alias
			"set_CookieContainer"
		end

feature -- Basic Operations

	end_get_response (async_result: IASYNC_RESULT): SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (System.IAsyncResult): System.Net.WebResponse use System.Net.HttpWebRequest"
		alias
			"EndGetResponse"
		end

	begin_get_request_stream (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.HttpWebRequest"
		alias
			"BeginGetRequestStream"
		end

	get_response: SYSTEM_DLL_WEB_RESPONSE is
		external
			"IL signature (): System.Net.WebResponse use System.Net.HttpWebRequest"
		alias
			"GetResponse"
		end

	abort is
		external
			"IL signature (): System.Void use System.Net.HttpWebRequest"
		alias
			"Abort"
		end

	frozen add_range_string_int32_int32 (range_specifier: SYSTEM_STRING; from_: INTEGER; to: INTEGER) is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"AddRange"
		end

	get_request_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.HttpWebRequest"
		alias
			"GetRequestStream"
		end

	begin_get_response (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.HttpWebRequest"
		alias
			"BeginGetResponse"
		end

	frozen add_range_string_int32 (range_specifier: SYSTEM_STRING; range: INTEGER) is
		external
			"IL signature (System.String, System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"AddRange"
		end

	frozen add_range (range: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"AddRange"
		end

	end_get_request_stream (async_result: IASYNC_RESULT): SYSTEM_STREAM is
		external
			"IL signature (System.IAsyncResult): System.IO.Stream use System.Net.HttpWebRequest"
		alias
			"EndGetRequestStream"
		end

	frozen add_range_int32_int32 (from_: INTEGER; to: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"AddRange"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.HttpWebRequest"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.HttpWebRequest"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DLL_HTTP_WEB_REQUEST
