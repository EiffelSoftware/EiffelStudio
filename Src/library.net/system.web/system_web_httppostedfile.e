indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpPostedFile"

frozen external class
	SYSTEM_WEB_HTTPPOSTEDFILE

create {NONE}

feature -- Access

	frozen get_input_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpPostedFile"
		alias
			"get_InputStream"
		end

	frozen get_content_type: STRING is
		external
			"IL signature (): System.String use System.Web.HttpPostedFile"
		alias
			"get_ContentType"
		end

	frozen get_content_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpPostedFile"
		alias
			"get_ContentLength"
		end

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.Web.HttpPostedFile"
		alias
			"get_FileName"
		end

feature -- Basic Operations

	frozen save_as (filename: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpPostedFile"
		alias
			"SaveAs"
		end

end -- class SYSTEM_WEB_HTTPPOSTEDFILE
