indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.BadImageFormatException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	BAD_IMAGE_FORMAT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_message,
			to_string
		end
	ISERIALIZABLE

create
	make_bad_image_format_exception,
	make_bad_image_format_exception_4,
	make_bad_image_format_exception_3,
	make_bad_image_format_exception_2,
	make_bad_image_format_exception_1

feature {NONE} -- Initialization

	frozen make_bad_image_format_exception is
		external
			"IL creator use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_4 (message: SYSTEM_STRING; file_name: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_3 (message: SYSTEM_STRING; file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.BadImageFormatException"
		end

feature -- Access

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_FileName"
		end

	frozen get_fusion_log: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_FusionLog"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.BadImageFormatException"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"ToString"
		end

end -- class BAD_IMAGE_FORMAT_EXCEPTION
