indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.FileWebRequest"

external class
	SYSTEM_NET_FILEWEBREQUEST

inherit
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end
	SYSTEM_NET_WEBREQUEST
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

create {NONE}

feature -- Access

	get_content_type: STRING is
		external
			"IL signature (): System.String use System.Net.FileWebRequest"
		alias
			"get_ContentType"
		end

	get_method: STRING is
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

	get_request_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.FileWebRequest"
		alias
			"get_RequestUri"
		end

	get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.FileWebRequest"
		alias
			"get_Headers"
		end

	get_proxy: SYSTEM_NET_IWEBPROXY is
		external
			"IL signature (): System.Net.IWebProxy use System.Net.FileWebRequest"
		alias
			"get_Proxy"
		end

	get_connection_group_name: STRING is
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

	get_credentials: SYSTEM_NET_ICREDENTIALS is
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

	set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
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

	set_method (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.FileWebRequest"
		alias
			"set_Method"
		end

	set_content_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.FileWebRequest"
		alias
			"set_ContentType"
		end

	set_proxy (value: SYSTEM_NET_IWEBPROXY) is
		external
			"IL signature (System.Net.IWebProxy): System.Void use System.Net.FileWebRequest"
		alias
			"set_Proxy"
		end

	set_connection_group_name (value: STRING) is
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

	begin_get_response (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.FileWebRequest"
		alias
			"BeginGetResponse"
		end

	end_get_request_stream (async_result: SYSTEM_IASYNCRESULT): SYSTEM_IO_STREAM is
		external
			"IL signature (System.IAsyncResult): System.IO.Stream use System.Net.FileWebRequest"
		alias
			"EndGetRequestStream"
		end

	begin_get_request_stream (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.FileWebRequest"
		alias
			"BeginGetRequestStream"
		end

	get_request_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.FileWebRequest"
		alias
			"GetRequestStream"
		end

	get_response: SYSTEM_NET_WEBRESPONSE is
		external
			"IL signature (): System.Net.WebResponse use System.Net.FileWebRequest"
		alias
			"GetResponse"
		end

	end_get_response (async_result: SYSTEM_IASYNCRESULT): SYSTEM_NET_WEBRESPONSE is
		external
			"IL signature (System.IAsyncResult): System.Net.WebResponse use System.Net.FileWebRequest"
		alias
			"EndGetResponse"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.FileWebRequest"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_NET_FILEWEBREQUEST
