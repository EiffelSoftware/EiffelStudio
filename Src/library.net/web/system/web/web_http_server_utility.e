indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpServerUtility"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_SERVER_UTILITY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_script_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpServerUtility"
		alias
			"get_ScriptTimeout"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpServerUtility"
		alias
			"get_MachineName"
		end

feature -- Element Change

	frozen set_script_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.HttpServerUtility"
		alias
			"set_ScriptTimeout"
		end

feature -- Basic Operations

	frozen map_path (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"MapPath"
		end

	frozen execute (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpServerUtility"
		alias
			"Execute"
		end

	frozen clear_error is
		external
			"IL signature (): System.Void use System.Web.HttpServerUtility"
		alias
			"ClearError"
		end

	frozen url_decode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"UrlDecode"
		end

	frozen html_decode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"HtmlDecode"
		end

	frozen transfer (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpServerUtility"
		alias
			"Transfer"
		end

	frozen url_decode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"UrlDecode"
		end

	frozen url_encode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"UrlEncode"
		end

	frozen transfer_string_boolean (path: SYSTEM_STRING; preserve_form: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpServerUtility"
		alias
			"Transfer"
		end

	frozen html_encode_string_text_writer (s: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"HtmlEncode"
		end

	frozen get_last_error: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Web.HttpServerUtility"
		alias
			"GetLastError"
		end

	frozen create_object_string (prog_id: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.HttpServerUtility"
		alias
			"CreateObject"
		end

	frozen html_decode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"HtmlDecode"
		end

	frozen create_object_from_clsid (clsid: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.HttpServerUtility"
		alias
			"CreateObjectFromClsid"
		end

	frozen html_encode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"HtmlEncode"
		end

	frozen url_path_encode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"UrlPathEncode"
		end

	frozen execute_string_text_writer (path: SYSTEM_STRING; writer: TEXT_WRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"Execute"
		end

	frozen url_encode (s: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"UrlEncode"
		end

	frozen create_object (type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Web.HttpServerUtility"
		alias
			"CreateObject"
		end

end -- class WEB_HTTP_SERVER_UTILITY
