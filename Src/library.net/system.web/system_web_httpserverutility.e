indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpServerUtility"

frozen external class
	SYSTEM_WEB_HTTPSERVERUTILITY

create {NONE}

feature -- Access

	frozen get_script_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpServerUtility"
		alias
			"get_ScriptTimeout"
		end

	frozen get_machine_name: STRING is
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

	frozen map_path (path: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"MapPath"
		end

	frozen execute (path: STRING) is
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

	frozen url_decode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"UrlDecode"
		end

	frozen html_decode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"HtmlDecode"
		end

	frozen transfer (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpServerUtility"
		alias
			"Transfer"
		end

	frozen url_decode (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"UrlDecode"
		end

	frozen url_encode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"UrlEncode"
		end

	frozen transfer_string_boolean (path: STRING; preserve_form: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpServerUtility"
		alias
			"Transfer"
		end

	frozen html_encode_string_text_writer (s: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"HtmlEncode"
		end

	frozen get_last_error: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Web.HttpServerUtility"
		alias
			"GetLastError"
		end

	frozen create_object_string (prog_id: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.HttpServerUtility"
		alias
			"CreateObject"
		end

	frozen html_decode (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"HtmlDecode"
		end

	frozen create_object_from_clsid (clsid: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.HttpServerUtility"
		alias
			"CreateObjectFromClsid"
		end

	frozen html_encode (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"HtmlEncode"
		end

	frozen url_path_encode (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"UrlPathEncode"
		end

	frozen execute_string_text_writer (path: STRING; writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.String, System.IO.TextWriter): System.Void use System.Web.HttpServerUtility"
		alias
			"Execute"
		end

	frozen url_encode (s: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpServerUtility"
		alias
			"UrlEncode"
		end

	frozen create_object (type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Web.HttpServerUtility"
		alias
			"CreateObject"
		end

end -- class SYSTEM_WEB_HTTPSERVERUTILITY
