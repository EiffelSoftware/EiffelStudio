indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.HttpWebRequest"

external class
	SYSTEM_NET_HTTPWEBREQUEST

inherit
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end
	SYSTEM_NET_WEBREQUEST
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

create {NONE}

feature -- Access

	get_pre_authenticate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_PreAuthenticate"
		end

	frozen get_client_certificates: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATECOLLECTION is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509CertificateCollection use System.Net.HttpWebRequest"
		alias
			"get_ClientCertificates"
		end

	frozen get_referer: STRING is
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

	frozen get_transfer_encoding: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_TransferEncoding"
		end

	frozen get_continue_delegate: SYSTEM_NET_HTTPCONTINUEDELEGATE is
		external
			"IL signature (): System.Net.HttpContinueDelegate use System.Net.HttpWebRequest"
		alias
			"get_ContinueDelegate"
		end

	frozen get_media_type: STRING is
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

	get_connection_group_name: STRING is
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

	frozen get_enable_cookies: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.HttpWebRequest"
		alias
			"get_EnableCookies"
		end

	get_request_uri: SYSTEM_URI is
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

	frozen get_if_modified_since: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Net.HttpWebRequest"
		alias
			"get_IfModifiedSince"
		end

	get_proxy: SYSTEM_NET_IWEBPROXY is
		external
			"IL signature (): System.Net.IWebProxy use System.Net.HttpWebRequest"
		alias
			"get_Proxy"
		end

	get_credentials: SYSTEM_NET_ICREDENTIALS is
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

	frozen get_service_point: SYSTEM_NET_SERVICEPOINT is
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

	frozen get_connection: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Connection"
		end

	get_method: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Method"
		end

	get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
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

	get_content_type: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_ContentType"
		end

	frozen get_protocol_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Net.HttpWebRequest"
		alias
			"get_ProtocolVersion"
		end

	frozen get_cookie_container: SYSTEM_NET_COOKIECONTAINER is
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

	frozen get_expect: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Expect"
		end

	frozen get_address: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.HttpWebRequest"
		alias
			"get_Address"
		end

	frozen get_accept: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_Accept"
		end

	frozen get_user_agent: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebRequest"
		alias
			"get_UserAgent"
		end

feature -- Element Change

	frozen set_connection (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Connection"
		end

	frozen set_send_chunked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_SendChunked"
		end

	set_proxy (value: SYSTEM_NET_IWEBPROXY) is
		external
			"IL signature (System.Net.IWebProxy): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Proxy"
		end

	frozen set_accept (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Accept"
		end

	frozen set_pipelined (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Pipelined"
		end

	set_method (value: STRING) is
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

	frozen set_user_agent (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_UserAgent"
		end

	frozen set_transfer_encoding (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_TransferEncoding"
		end

	frozen set_referer (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Referer"
		end

	frozen set_media_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_MediaType"
		end

	frozen set_expect (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Expect"
		end

	set_headers (value: SYSTEM_NET_WEBHEADERCOLLECTION) is
		external
			"IL signature (System.Net.WebHeaderCollection): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Headers"
		end

	set_content_type (value: STRING) is
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

	set_connection_group_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ConnectionGroupName"
		end

	set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.HttpWebRequest"
		alias
			"set_Credentials"
		end

	frozen set_enable_cookies (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_EnableCookies"
		end

	frozen set_allow_auto_redirect (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebRequest"
		alias
			"set_AllowAutoRedirect"
		end

	frozen set_continue_delegate (value: SYSTEM_NET_HTTPCONTINUEDELEGATE) is
		external
			"IL signature (System.Net.HttpContinueDelegate): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ContinueDelegate"
		end

	set_content_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ContentLength"
		end

	frozen set_protocol_version (value: SYSTEM_VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Net.HttpWebRequest"
		alias
			"set_ProtocolVersion"
		end

	frozen set_if_modified_since (value: SYSTEM_DATETIME) is
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

	frozen set_cookie_container (value: SYSTEM_NET_COOKIECONTAINER) is
		external
			"IL signature (System.Net.CookieContainer): System.Void use System.Net.HttpWebRequest"
		alias
			"set_CookieContainer"
		end

feature -- Basic Operations

	end_get_response (async_result: SYSTEM_IASYNCRESULT): SYSTEM_NET_WEBRESPONSE is
		external
			"IL signature (System.IAsyncResult): System.Net.WebResponse use System.Net.HttpWebRequest"
		alias
			"EndGetResponse"
		end

	begin_get_request_stream (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.HttpWebRequest"
		alias
			"BeginGetRequestStream"
		end

	get_response: SYSTEM_NET_WEBRESPONSE is
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

	frozen add_range_string_int32_int32 (range_specifier: STRING; from_: INTEGER; to: INTEGER) is
		external
			"IL signature (System.String, System.Int32, System.Int32): System.Void use System.Net.HttpWebRequest"
		alias
			"AddRange"
		end

	get_request_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.HttpWebRequest"
		alias
			"GetRequestStream"
		end

	begin_get_response (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.HttpWebRequest"
		alias
			"BeginGetResponse"
		end

	frozen add_range_string_int32 (range_specifier: STRING; range: INTEGER) is
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

	end_get_request_stream (async_result: SYSTEM_IASYNCRESULT): SYSTEM_IO_STREAM is
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

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.HttpWebRequest"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_NET_HTTPWEBREQUEST
