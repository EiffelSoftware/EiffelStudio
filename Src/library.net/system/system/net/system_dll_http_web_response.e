indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.HttpWebResponse"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_HTTP_WEB_RESPONSE

inherit
	SYSTEM_DLL_WEB_RESPONSE
		redefine
			get_headers,
			get_response_uri,
			get_response_stream,
			get_content_type,
			get_content_length,
			close,
			get_hash_code
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose_void
		select
			system_idisposable_dispose_void
		end

create {NONE}

feature -- Access

	get_content_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_ContentType"
		end

	frozen get_server: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_Server"
		end

	frozen get_status_code: SYSTEM_DLL_HTTP_STATUS_CODE is
		external
			"IL signature (): System.Net.HttpStatusCode use System.Net.HttpWebResponse"
		alias
			"get_StatusCode"
		end

	frozen get_character_set: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_CharacterSet"
		end

	get_content_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.HttpWebResponse"
		alias
			"get_ContentLength"
		end

	frozen get_method: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_Method"
		end

	frozen get_status_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_StatusDescription"
		end

	get_response_uri: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.HttpWebResponse"
		alias
			"get_ResponseUri"
		end

	frozen get_last_modified: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Net.HttpWebResponse"
		alias
			"get_LastModified"
		end

	frozen get_protocol_version: VERSION is
		external
			"IL signature (): System.Version use System.Net.HttpWebResponse"
		alias
			"get_ProtocolVersion"
		end

	frozen get_cookies: SYSTEM_DLL_COOKIE_COLLECTION is
		external
			"IL signature (): System.Net.CookieCollection use System.Net.HttpWebResponse"
		alias
			"get_Cookies"
		end

	frozen get_content_encoding: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_ContentEncoding"
		end

	get_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.HttpWebResponse"
		alias
			"get_Headers"
		end

feature -- Element Change

	frozen set_cookies (value: SYSTEM_DLL_COOKIE_COLLECTION) is
		external
			"IL signature (System.Net.CookieCollection): System.Void use System.Net.HttpWebResponse"
		alias
			"set_Cookies"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.HttpWebResponse"
		alias
			"GetHashCode"
		end

	frozen get_response_header (header_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Net.HttpWebResponse"
		alias
			"GetResponseHeader"
		end

	get_response_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.HttpWebResponse"
		alias
			"GetResponseStream"
		end

	close is
		external
			"IL signature (): System.Void use System.Net.HttpWebResponse"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.HttpWebResponse"
		alias
			"Dispose"
		end

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.HttpWebResponse"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	frozen system_idisposable_dispose_void is
		external
			"IL signature (): System.Void use System.Net.HttpWebResponse"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_DLL_HTTP_WEB_RESPONSE
