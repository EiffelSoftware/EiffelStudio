indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.FileWebResponse"

external class
	SYSTEM_NET_FILEWEBRESPONSE

inherit
	SYSTEM_NET_WEBRESPONSE
		redefine
			get_headers,
			get_response_uri,
			get_response_stream,
			get_content_type,
			get_content_length,
			close
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

	get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.FileWebResponse"
		alias
			"get_Headers"
		end

	get_response_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.FileWebResponse"
		alias
			"get_ResponseUri"
		end

	get_content_type: STRING is
		external
			"IL signature (): System.String use System.Net.FileWebResponse"
		alias
			"get_ContentType"
		end

	get_content_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.FileWebResponse"
		alias
			"get_ContentLength"
		end

feature -- Basic Operations

	get_response_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.FileWebResponse"
		alias
			"GetResponseStream"
		end

	close is
		external
			"IL signature (): System.Void use System.Net.FileWebResponse"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.FileWebResponse"
		alias
			"Dispose"
		end

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.FileWebResponse"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	frozen system_idisposable_dispose_void is
		external
			"IL signature (): System.Void use System.Net.FileWebResponse"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_NET_FILEWEBRESPONSE
