indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpException"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTTP_EXCEPTION

inherit
	EXTERNAL_EXCEPTION
	ISERIALIZABLE

create
	make_web_http_exception_2,
	make_web_http_exception_1,
	make_web_http_exception,
	make_web_http_exception_6,
	make_web_http_exception_5,
	make_web_http_exception_4,
	make_web_http_exception_3

feature {NONE} -- Initialization

	frozen make_web_http_exception_2 (message: SYSTEM_STRING; hr: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Web.HttpException"
		end

	frozen make_web_http_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.HttpException"
		end

	frozen make_web_http_exception is
		external
			"IL creator use System.Web.HttpException"
		end

	frozen make_web_http_exception_6 (http_code: INTEGER; message: SYSTEM_STRING; hr: INTEGER) is
		external
			"IL creator signature (System.Int32, System.String, System.Int32) use System.Web.HttpException"
		end

	frozen make_web_http_exception_5 (http_code: INTEGER; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Web.HttpException"
		end

	frozen make_web_http_exception_4 (http_code: INTEGER; message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.Int32, System.String, System.Exception) use System.Web.HttpException"
		end

	frozen make_web_http_exception_3 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Web.HttpException"
		end

feature -- Basic Operations

	frozen get_http_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpException"
		alias
			"GetHttpCode"
		end

	frozen create_from_last_error (message: SYSTEM_STRING): WEB_HTTP_EXCEPTION is
		external
			"IL static signature (System.String): System.Web.HttpException use System.Web.HttpException"
		alias
			"CreateFromLastError"
		end

	frozen get_html_error_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpException"
		alias
			"GetHtmlErrorMessage"
		end

end -- class WEB_HTTP_EXCEPTION
