indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileNotFoundException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	FILE_NOT_FOUND_EXCEPTION

inherit
	IOEXCEPTION
		redefine
			get_object_data,
			get_message,
			to_string
		end
	ISERIALIZABLE

create
	make_file_not_found_exception,
	make_file_not_found_exception_4,
	make_file_not_found_exception_1,
	make_file_not_found_exception_3,
	make_file_not_found_exception_2

feature {NONE} -- Initialization

	frozen make_file_not_found_exception is
		external
			"IL creator use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_4 (message: SYSTEM_STRING; file_name: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_3 (message: SYSTEM_STRING; file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.IO.FileNotFoundException"
		end

	frozen make_file_not_found_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.FileNotFoundException"
		end

feature -- Access

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"get_FileName"
		end

	frozen get_fusion_log: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"get_FusionLog"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.IO.FileNotFoundException"
		alias
			"GetObjectData"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.IO.FileNotFoundException"
		alias
			"ToString"
		end

end -- class FILE_NOT_FOUND_EXCEPTION
