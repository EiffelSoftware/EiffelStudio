indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.HttpWebResponse"

external class
	SYSTEM_NET_HTTPWEBRESPONSE

inherit
	SYSTEM_NET_WEBRESPONSE
		redefine
			get_headers,
			get_response_uri,
			get_response_stream,
			get_content_type,
			get_content_length,
			close,
			get_hash_code
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose_void
		select
			system_idisposable_dispose_void
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end

create {NONE}

feature -- Access

	get_content_type: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_ContentType"
		end

	frozen get_server: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_Server"
		end

	frozen get_status_code: SYSTEM_NET_HTTPSTATUSCODE is
		external
			"IL signature (): System.Net.HttpStatusCode use System.Net.HttpWebResponse"
		alias
			"get_StatusCode"
		end

	frozen get_character_set: STRING is
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

	frozen get_method: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_Method"
		end

	frozen get_status_description: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_StatusDescription"
		end

	get_response_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.HttpWebResponse"
		alias
			"get_ResponseUri"
		end

	frozen get_last_modified: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Net.HttpWebResponse"
		alias
			"get_LastModified"
		end

	frozen get_protocol_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Net.HttpWebResponse"
		alias
			"get_ProtocolVersion"
		end

	frozen get_cookies: SYSTEM_NET_COOKIECOLLECTION is
		external
			"IL signature (): System.Net.CookieCollection use System.Net.HttpWebResponse"
		alias
			"get_Cookies"
		end

	frozen get_content_encoding: STRING is
		external
			"IL signature (): System.String use System.Net.HttpWebResponse"
		alias
			"get_ContentEncoding"
		end

	get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.HttpWebResponse"
		alias
			"get_Headers"
		end

feature -- Element Change

	frozen set_cookies (value: SYSTEM_NET_COOKIECOLLECTION) is
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

	frozen get_response_header (header_name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Net.HttpWebResponse"
		alias
			"GetResponseHeader"
		end

	get_response_stream: SYSTEM_IO_STREAM is
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

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

end -- class SYSTEM_NET_HTTPWEBRESPONSE
