indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.BadImageFormatException"

external class
	SYSTEM_BADIMAGEFORMATEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_badimageformatexception_1,
	make_badimageformatexception_2,
	make_badimageformatexception,
	make_badimageformatexception_3,
	make_badimageformatexception_4

feature {NONE} -- Initialization

	frozen make_badimageformatexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.BadImageFormatException"
		end

	frozen make_badimageformatexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.BadImageFormatException"
		end

	frozen make_badimageformatexception is
		external
			"IL creator use System.BadImageFormatException"
		end

	frozen make_badimageformatexception_3 (message: STRING; file_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.BadImageFormatException"
		end

	frozen make_badimageformatexception_4 (message: STRING; file_name: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.BadImageFormatException"
		end

feature -- Access

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_FileName"
		end

	frozen get_fusion_log: STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_FusionLog"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.BadImageFormatException"
		alias
			"GetObjectData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"ToString"
		end

end -- class SYSTEM_BADIMAGEFORMATEXCEPTION
