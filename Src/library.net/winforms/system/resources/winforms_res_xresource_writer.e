indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResXResourceWriter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_RES_XRESOURCE_WRITER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IRESOURCE_WRITER
	IDISPOSABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (text_writer: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Resources.ResXResourceWriter"
		end

	frozen make (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResXResourceWriter"
		end

	frozen make_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResXResourceWriter"
		end

feature -- Access

	frozen soap_serialized_object_mime_type: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"SoapSerializedObjectMimeType"
		end

	frozen default_serialized_object_mime_type: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"DefaultSerializedObjectMimeType"
		end

	frozen byte_array_serialized_object_mime_type: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"ByteArraySerializedObjectMimeType"
		end

	frozen bin_serialized_object_mime_type: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"BinSerializedObjectMimeType"
		end

	frozen resource_schema: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"ResourceSchema"
		end

	frozen version: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"Version"
		end

	frozen res_mime_type: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"ResMimeType"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.ResXResourceWriter"
		alias
			"ToString"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceWriter"
		alias
			"Close"
		end

	frozen add_resource (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Resources.ResXResourceWriter"
		alias
			"AddResource"
		end

	frozen generate is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceWriter"
		alias
			"Generate"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResXResourceWriter"
		alias
			"Equals"
		end

	frozen add_resource_string_array_byte (name: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Resources.ResXResourceWriter"
		alias
			"AddResource"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceWriter"
		alias
			"Dispose"
		end

	frozen add_resource_string_object (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Resources.ResXResourceWriter"
		alias
			"AddResource"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResXResourceWriter"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Resources.ResXResourceWriter"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceWriter"
		alias
			"Finalize"
		end

end -- class WINFORMS_RES_XRESOURCE_WRITER
