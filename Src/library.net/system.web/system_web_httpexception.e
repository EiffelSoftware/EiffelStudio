indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpException"

external class
	SYSTEM_WEB_HTTPEXCEPTION

inherit
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_httpexception_6,
	make_httpexception_5,
	make_httpexception_4,
	make_httpexception_3,
	make_httpexception_2,
	make_httpexception_1,
	make_httpexception

feature {NONE} -- Initialization

	frozen make_httpexception_6 (http_code: INTEGER; message: STRING; hr: INTEGER) is
		external
			"IL creator signature (System.Int32, System.String, System.Int32) use System.Web.HttpException"
		end

	frozen make_httpexception_5 (http_code: INTEGER; message: STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Web.HttpException"
		end

	frozen make_httpexception_4 (http_code: INTEGER; message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Int32, System.String, System.Exception) use System.Web.HttpException"
		end

	frozen make_httpexception_3 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Web.HttpException"
		end

	frozen make_httpexception_2 (message: STRING; hr: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Web.HttpException"
		end

	frozen make_httpexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Web.HttpException"
		end

	frozen make_httpexception is
		external
			"IL creator use System.Web.HttpException"
		end

feature -- Basic Operations

	frozen get_http_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpException"
		alias
			"GetHttpCode"
		end

	frozen create_from_last_error (message: STRING): SYSTEM_WEB_HTTPEXCEPTION is
		external
			"IL static signature (System.String): System.Web.HttpException use System.Web.HttpException"
		alias
			"CreateFromLastError"
		end

	frozen get_html_error_message: STRING is
		external
			"IL signature (): System.String use System.Web.HttpException"
		alias
			"GetHtmlErrorMessage"
		end

end -- class SYSTEM_WEB_HTTPEXCEPTION
