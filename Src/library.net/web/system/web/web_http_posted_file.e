indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpPostedFile"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_POSTED_FILE

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_input_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpPostedFile"
		alias
			"get_InputStream"
		end

	frozen get_content_type: SYSTEM_STRING is
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

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpPostedFile"
		alias
			"get_FileName"
		end

feature -- Basic Operations

	frozen save_as (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpPostedFile"
		alias
			"SaveAs"
		end

end -- class WEB_HTTP_POSTED_FILE
