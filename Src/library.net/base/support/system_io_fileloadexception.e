indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileLoadException"

external class
	SYSTEM_IO_FILELOADEXCEPTION

inherit
	SYSTEM_IO_IOEXCEPTION
		redefine
			get_object_data,
			get_message,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_fileloadexception_2,
	make_fileloadexception_1,
	make_fileloadexception,
	make_fileloadexception_4,
	make_fileloadexception_3

feature {NONE} -- Initialization

	frozen make_fileloadexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.FileLoadException"
		end

	frozen make_fileloadexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileLoadException"
		end

	frozen make_fileloadexception is
		external
			"IL creator use System.IO.FileLoadException"
		end

	frozen make_fileloadexception_4 (message: STRING; file_name: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.IO.FileLoadException"
		end

	frozen make_fileloadexception_3 (message: STRING; file_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.IO.FileLoadException"
		end

feature -- Access

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.IO.FileLoadException"
		alias
			"get_FileName"
		end

	frozen get_fusion_log: STRING is
		external
			"IL signature (): System.String use System.IO.FileLoadException"
		alias
			"get_FusionLog"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.IO.FileLoadException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.IO.FileLoadException"
		alias
			"GetObjectData"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.IO.FileLoadException"
		alias
			"ToString"
		end

end -- class SYSTEM_IO_FILELOADEXCEPTION
