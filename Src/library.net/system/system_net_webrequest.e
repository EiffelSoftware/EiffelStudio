indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebRequest"

deferred external class
	SYSTEM_NET_WEBREQUEST

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

feature -- Access

	get_content_type: STRING is
		external
			"IL signature (): System.String use System.Net.WebRequest"
		alias
			"get_ContentType"
		end

	get_method: STRING is
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

	get_request_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.WebRequest"
		alias
			"get_RequestUri"
		end

	get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebRequest"
		alias
			"get_Headers"
		end

	get_proxy: SYSTEM_NET_IWEBPROXY is
		external
			"IL signature (): System.Net.IWebProxy use System.Net.WebRequest"
		alias
			"get_Proxy"
		end

	get_connection_group_name: STRING is
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

	get_credentials: SYSTEM_NET_ICREDENTIALS is
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

	set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.WebRequest"
		alias
			"set_Credentials"
		end

	set_connection_group_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebRequest"
		alias
			"set_ConnectionGroupName"
		end

	set_method (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebRequest"
		alias
			"set_Method"
		end

	set_content_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebRequest"
		alias
			"set_ContentType"
		end

	set_headers (value: SYSTEM_NET_WEBHEADERCOLLECTION) is
		external
			"IL signature (System.Net.WebHeaderCollection): System.Void use System.Net.WebRequest"
		alias
			"set_Headers"
		end

	set_proxy (value: SYSTEM_NET_IWEBPROXY) is
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

	end_get_response (async_result: SYSTEM_IASYNCRESULT): SYSTEM_NET_WEBRESPONSE is
		external
			"IL signature (System.IAsyncResult): System.Net.WebResponse use System.Net.WebRequest"
		alias
			"EndGetResponse"
		end

	begin_get_request_stream (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.WebRequest"
		alias
			"BeginGetRequestStream"
		end

	get_response: SYSTEM_NET_WEBRESPONSE is
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

	get_request_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.WebRequest"
		alias
			"GetRequestStream"
		end

	begin_get_response (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.WebRequest"
		alias
			"BeginGetResponse"
		end

	frozen create__string (request_uri_string: STRING): SYSTEM_NET_WEBREQUEST is
		external
			"IL static signature (System.String): System.Net.WebRequest use System.Net.WebRequest"
		alias
			"Create"
		end

	frozen register_prefix (prefix_: STRING; creator: SYSTEM_NET_IWEBREQUESTCREATE): BOOLEAN is
		external
			"IL static signature (System.String, System.Net.IWebRequestCreate): System.Boolean use System.Net.WebRequest"
		alias
			"RegisterPrefix"
		end

	frozen Create_ (request_uri: SYSTEM_URI): SYSTEM_NET_WEBREQUEST is
		external
			"IL static signature (System.Uri): System.Net.WebRequest use System.Net.WebRequest"
		alias
			"Create"
		end

	end_get_request_stream (async_result: SYSTEM_IASYNCRESULT): SYSTEM_IO_STREAM is
		external
			"IL signature (System.IAsyncResult): System.IO.Stream use System.Net.WebRequest"
		alias
			"EndGetRequestStream"
		end

	frozen create_default (request_uri: SYSTEM_URI): SYSTEM_NET_WEBREQUEST is
		external
			"IL static signature (System.Uri): System.Net.WebRequest use System.Net.WebRequest"
		alias
			"CreateDefault"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebRequest"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_NET_WEBREQUEST
