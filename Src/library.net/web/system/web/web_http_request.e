indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpRequest"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_REQUEST

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (filename: SYSTEM_STRING; url: SYSTEM_STRING; query_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Web.HttpRequest"
		end

feature -- Access

	frozen get_raw_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_RawUrl"
		end

	frozen get_content_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.HttpRequest"
		alias
			"get_ContentEncoding"
		end

	frozen get_application_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_ApplicationPath"
		end

	frozen get_path_info: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_PathInfo"
		end

	frozen get_is_secure_connection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpRequest"
		alias
			"get_IsSecureConnection"
		end

	frozen get_total_bytes: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpRequest"
		alias
			"get_TotalBytes"
		end

	frozen get_params: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_Params"
		end

	frozen get_file_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_FilePath"
		end

	frozen get_browser: WEB_HTTP_BROWSER_CAPABILITIES is
		external
			"IL signature (): System.Web.HttpBrowserCapabilities use System.Web.HttpRequest"
		alias
			"get_Browser"
		end

	frozen get_content_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_ContentType"
		end

	frozen get_user_languages: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpRequest"
		alias
			"get_UserLanguages"
		end

	frozen get_request_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_RequestType"
		end

	frozen get_cookies: WEB_HTTP_COOKIE_COLLECTION is
		external
			"IL signature (): System.Web.HttpCookieCollection use System.Web.HttpRequest"
		alias
			"get_Cookies"
		end

	frozen get_content_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpRequest"
		alias
			"get_ContentLength"
		end

	frozen get_current_execution_file_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_CurrentExecutionFilePath"
		end

	frozen get_filter: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpRequest"
		alias
			"get_Filter"
		end

	frozen get_input_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpRequest"
		alias
			"get_InputStream"
		end

	frozen get_accept_types: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpRequest"
		alias
			"get_AcceptTypes"
		end

	frozen get_form: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_Form"
		end

	frozen get_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_Path"
		end

	frozen get_url: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Web.HttpRequest"
		alias
			"get_Url"
		end

	frozen get_user_host_address: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_UserHostAddress"
		end

	frozen get_query_string: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_QueryString"
		end

	frozen get_physical_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_PhysicalPath"
		end

	frozen get_files: WEB_HTTP_FILE_COLLECTION is
		external
			"IL signature (): System.Web.HttpFileCollection use System.Web.HttpRequest"
		alias
			"get_Files"
		end

	frozen get_physical_application_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_PhysicalApplicationPath"
		end

	frozen get_http_method: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_HttpMethod"
		end

	frozen get_client_certificate: WEB_HTTP_CLIENT_CERTIFICATE is
		external
			"IL signature (): System.Web.HttpClientCertificate use System.Web.HttpRequest"
		alias
			"get_ClientCertificate"
		end

	frozen get_user_agent: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_UserAgent"
		end

	frozen get_item (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpRequest"
		alias
			"get_Item"
		end

	frozen get_server_variables: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_ServerVariables"
		end

	frozen get_url_referrer: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Web.HttpRequest"
		alias
			"get_UrlReferrer"
		end

	frozen get_user_host_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_UserHostName"
		end

	frozen get_headers: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_Headers"
		end

	frozen get_is_authenticated: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpRequest"
		alias
			"get_IsAuthenticated"
		end

feature -- Element Change

	frozen set_content_encoding (value: ENCODING) is
		external
			"IL signature (System.Text.Encoding): System.Void use System.Web.HttpRequest"
		alias
			"set_ContentEncoding"
		end

	frozen set_filter (value: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Web.HttpRequest"
		alias
			"set_Filter"
		end

	frozen set_request_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpRequest"
		alias
			"set_RequestType"
		end

	frozen set_browser (value: WEB_HTTP_BROWSER_CAPABILITIES) is
		external
			"IL signature (System.Web.HttpBrowserCapabilities): System.Void use System.Web.HttpRequest"
		alias
			"set_Browser"
		end

feature -- Basic Operations

	frozen map_path_string_string (virtual_path: SYSTEM_STRING; base_virtual_dir: SYSTEM_STRING; allow_cross_app_mapping: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String, System.Boolean): System.String use System.Web.HttpRequest"
		alias
			"MapPath"
		end

	frozen save_as (filename: SYSTEM_STRING; include_headers: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpRequest"
		alias
			"SaveAs"
		end

	frozen map_image_coordinates (image_field_name: SYSTEM_STRING): NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (System.String): System.Int32[] use System.Web.HttpRequest"
		alias
			"MapImageCoordinates"
		end

	frozen binary_read (count: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Int32): System.Byte[] use System.Web.HttpRequest"
		alias
			"BinaryRead"
		end

	frozen map_path (virtual_path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpRequest"
		alias
			"MapPath"
		end

end -- class WEB_HTTP_REQUEST
