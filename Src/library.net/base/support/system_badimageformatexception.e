indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.BadImageFormatException"

external class
	SYSTEM_BADIMAGEFORMATEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_bad_image_format_exception_1,
	make_bad_image_format_exception_2,
	make_bad_image_format_exception,
	make_bad_image_format_exception_3,
	make_bad_image_format_exception_4

feature {NONE} -- Initialization

	frozen make_bad_image_format_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception is
		external
			"IL creator use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_3 (message2: STRING; fileName2: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.BadImageFormatException"
		end

	frozen make_bad_image_format_exception_4 (message2: STRING; fileName2: STRING; inner: SYSTEM_EXCEPTION) is
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

	get_message: STRING is
		external
			"IL signature (): System.String use System.BadImageFormatException"
		alias
			"get_Message"
		end

end -- class SYSTEM_BADIMAGEFORMATEXCEPTION
