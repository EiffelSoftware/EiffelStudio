indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebResponse"

deferred external class
	SYSTEM_NET_WEBRESPONSE

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

feature -- Access

	get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebResponse"
		alias
			"get_Headers"
		end

	get_response_uri: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Net.WebResponse"
		alias
			"get_ResponseUri"
		end

	get_content_type: STRING is
		external
			"IL signature (): System.String use System.Net.WebResponse"
		alias
			"get_ContentType"
		end

	get_content_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.WebResponse"
		alias
			"get_ContentLength"
		end

feature -- Element Change

	set_content_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.WebResponse"
		alias
			"set_ContentLength"
		end

	set_content_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebResponse"
		alias
			"set_ContentType"
		end

feature -- Basic Operations

	get_response_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Net.WebResponse"
		alias
			"GetResponseStream"
		end

	close is
		external
			"IL signature (): System.Void use System.Net.WebResponse"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; streaming_context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.WebResponse"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Net.WebResponse"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_NET_WEBRESPONSE
