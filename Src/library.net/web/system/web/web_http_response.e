indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpResponse"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_RESPONSE

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (writer: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Web.HttpResponse"
		end

feature -- Access

	frozen get_output: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use System.Web.HttpResponse"
		alias
			"get_Output"
		end

	frozen get_cookies: WEB_HTTP_COOKIE_COLLECTION is
		external
			"IL signature (): System.Web.HttpCookieCollection use System.Web.HttpResponse"
		alias
			"get_Cookies"
		end

	frozen get_expires_absolute: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpResponse"
		alias
			"get_ExpiresAbsolute"
		end

	frozen get_content_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.HttpResponse"
		alias
			"get_ContentEncoding"
		end

	frozen get_is_client_connected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpResponse"
		alias
			"get_IsClientConnected"
		end

	frozen get_status: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpResponse"
		alias
			"get_Status"
		end

	frozen get_status_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpResponse"
		alias
			"get_StatusCode"
		end

	frozen get_expires: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpResponse"
		alias
			"get_Expires"
		end

	frozen get_charset: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpResponse"
		alias
			"get_Charset"
		end

	frozen get_suppress_content: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpResponse"
		alias
			"get_SuppressContent"
		end

	frozen get_cache_control: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpResponse"
		alias
			"get_CacheControl"
		end

	frozen get_buffer: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpResponse"
		alias
			"get_Buffer"
		end

	frozen get_buffer_output: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpResponse"
		alias
			"get_BufferOutput"
		end

	frozen get_content_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpResponse"
		alias
			"get_ContentType"
		end

	frozen get_cache: WEB_HTTP_CACHE_POLICY is
		external
			"IL signature (): System.Web.HttpCachePolicy use System.Web.HttpResponse"
		alias
			"get_Cache"
		end

	frozen get_output_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpResponse"
		alias
			"get_OutputStream"
		end

	frozen get_status_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpResponse"
		alias
			"get_StatusDescription"
		end

	frozen get_filter: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpResponse"
		alias
			"get_Filter"
		end

feature -- Element Change

	frozen set_buffer (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpResponse"
		alias
			"set_Buffer"
		end

	frozen set_cache_control (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"set_CacheControl"
		end

	frozen set_charset (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"set_Charset"
		end

	frozen set_expires (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.HttpResponse"
		alias
			"set_Expires"
		end

	frozen set_buffer_output (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpResponse"
		alias
			"set_BufferOutput"
		end

	frozen set_content_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"set_ContentType"
		end

	frozen set_expires_absolute (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.HttpResponse"
		alias
			"set_ExpiresAbsolute"
		end

	frozen set_status_code (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.HttpResponse"
		alias
			"set_StatusCode"
		end

	frozen set_content_encoding (value: ENCODING) is
		external
			"IL signature (System.Text.Encoding): System.Void use System.Web.HttpResponse"
		alias
			"set_ContentEncoding"
		end

	frozen set_status_description (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"set_StatusDescription"
		end

	frozen set_filter (value: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Web.HttpResponse"
		alias
			"set_Filter"
		end

	frozen set_suppress_content (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpResponse"
		alias
			"set_SuppressContent"
		end

	frozen set_status (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"set_Status"
		end

feature -- Basic Operations

	frozen redirect (url: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"Redirect"
		end

	frozen write_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Web.HttpResponse"
		alias
			"Write"
		end

	frozen write_file_string_int64_int64 (filename: SYSTEM_STRING; offset: INTEGER_64; size: INTEGER_64) is
		external
			"IL signature (System.String, System.Int64, System.Int64): System.Void use System.Web.HttpResponse"
		alias
			"WriteFile"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Web.HttpResponse"
		alias
			"Close"
		end

	frozen flush is
		external
			"IL signature (): System.Void use System.Web.HttpResponse"
		alias
			"Flush"
		end

	frozen write_file_string_boolean (filename: SYSTEM_STRING; read_into_memory: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpResponse"
		alias
			"WriteFile"
		end

	frozen pics (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"Pics"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.HttpResponse"
		alias
			"Clear"
		end

	frozen remove_output_cache_item (path: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"RemoveOutputCacheItem"
		end

	frozen redirect_string_boolean (url: SYSTEM_STRING; end_response: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpResponse"
		alias
			"Redirect"
		end

	frozen write (ch: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Web.HttpResponse"
		alias
			"Write"
		end

	frozen clear_content is
		external
			"IL signature (): System.Void use System.Web.HttpResponse"
		alias
			"ClearContent"
		end

	frozen write_file (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"WriteFile"
		end

	frozen append_header (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.HttpResponse"
		alias
			"AppendHeader"
		end

	frozen write_file_int_ptr (file_handle: POINTER; offset: INTEGER_64; size: INTEGER_64) is
		external
			"IL signature (System.IntPtr, System.Int64, System.Int64): System.Void use System.Web.HttpResponse"
		alias
			"WriteFile"
		end

	frozen binary_write (buffer: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Web.HttpResponse"
		alias
			"BinaryWrite"
		end

	frozen write_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.HttpResponse"
		alias
			"Write"
		end

	frozen set_cookie (cookie: WEB_HTTP_COOKIE) is
		external
			"IL signature (System.Web.HttpCookie): System.Void use System.Web.HttpResponse"
		alias
			"SetCookie"
		end

	frozen add_file_dependency (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"AddFileDependency"
		end

	frozen append_to_log (param: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"AppendToLog"
		end

	frozen append_cookie (cookie: WEB_HTTP_COOKIE) is
		external
			"IL signature (System.Web.HttpCookie): System.Void use System.Web.HttpResponse"
		alias
			"AppendCookie"
		end

	frozen clear_headers is
		external
			"IL signature (): System.Void use System.Web.HttpResponse"
		alias
			"ClearHeaders"
		end

	frozen add_cache_item_dependencies (cache_keys: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Web.HttpResponse"
		alias
			"AddCacheItemDependencies"
		end

	frozen end_ is
		external
			"IL signature (): System.Void use System.Web.HttpResponse"
		alias
			"End"
		end

	frozen write_string (s: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"Write"
		end

	frozen add_file_dependencies (filenames: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Web.HttpResponse"
		alias
			"AddFileDependencies"
		end

	frozen apply_app_path_modifier (virtual_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpResponse"
		alias
			"ApplyAppPathModifier"
		end

	frozen add_cache_item_dependency (cache_key: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpResponse"
		alias
			"AddCacheItemDependency"
		end

	frozen add_header (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.HttpResponse"
		alias
			"AddHeader"
		end

end -- class WEB_HTTP_RESPONSE
