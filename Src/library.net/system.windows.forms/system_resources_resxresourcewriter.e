indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResXResourceWriter"

external class
	SYSTEM_RESOURCES_RESXRESOURCEWRITER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RESOURCES_IRESOURCEWRITER
	SYSTEM_IDISPOSABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (text_writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Resources.ResXResourceWriter"
		end

	frozen make (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResXResourceWriter"
		end

	frozen make_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResXResourceWriter"
		end

feature -- Access

	frozen soap_serialized_object_mime_type: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"SoapSerializedObjectMimeType"
		end

	frozen version: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"Version"
		end

	frozen bin_serialized_object_mime_type: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"BinSerializedObjectMimeType"
		end

	frozen resource_schema: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"ResourceSchema"
		end

	frozen res_mime_type: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"ResMimeType"
		end

	frozen default_serialized_object_mime_type: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"DefaultSerializedObjectMimeType"
		end

	frozen mlserialized_object_mime_type: STRING is
		external
			"IL static_field signature :System.String use System.Resources.ResXResourceWriter"
		alias
			"MLSerializedObjectMimeType"
		end

feature -- Basic Operations

	to_string: STRING is
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

	frozen add_resource (name: STRING; value: STRING) is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResXResourceWriter"
		alias
			"Equals"
		end

	frozen add_resource_string_array_byte (name: STRING; value: ARRAY [INTEGER_8]) is
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

	frozen add_resource_string_object (name: STRING; value: ANY) is
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

end -- class SYSTEM_RESOURCES_RESXRESOURCEWRITER
