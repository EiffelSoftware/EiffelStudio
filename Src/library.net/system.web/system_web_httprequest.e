indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpRequest"

frozen external class
	SYSTEM_WEB_HTTPREQUEST

create
	make

feature {NONE} -- Initialization

	frozen make (filename: STRING; url: STRING; query_string: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Web.HttpRequest"
		end

feature -- Access

	frozen get_raw_url: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_RawUrl"
		end

	frozen get_content_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.HttpRequest"
		alias
			"get_ContentEncoding"
		end

	frozen get_application_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_ApplicationPath"
		end

	frozen get_path_info: STRING is
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

	frozen get_params: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_Params"
		end

	frozen get_file_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_FilePath"
		end

	frozen get_browser: SYSTEM_WEB_HTTPBROWSERCAPABILITIES is
		external
			"IL signature (): System.Web.HttpBrowserCapabilities use System.Web.HttpRequest"
		alias
			"get_Browser"
		end

	frozen get_content_type: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_ContentType"
		end

	frozen get_user_languages: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpRequest"
		alias
			"get_UserLanguages"
		end

	frozen get_request_type: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_RequestType"
		end

	frozen get_cookies: SYSTEM_WEB_HTTPCOOKIECOLLECTION is
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

	frozen get_input_stream: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpRequest"
		alias
			"get_InputStream"
		end

	frozen get_physical_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_PhysicalPath"
		end

	frozen get_accept_types: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpRequest"
		alias
			"get_AcceptTypes"
		end

	frozen get_form: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_Form"
		end

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_Path"
		end

	frozen get_url: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Web.HttpRequest"
		alias
			"get_Url"
		end

	frozen get_user_host_address: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_UserHostAddress"
		end

	frozen get_query_string: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_QueryString"
		end

	frozen get_filter: SYSTEM_IO_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Web.HttpRequest"
		alias
			"get_Filter"
		end

	frozen get_files: SYSTEM_WEB_HTTPFILECOLLECTION is
		external
			"IL signature (): System.Web.HttpFileCollection use System.Web.HttpRequest"
		alias
			"get_Files"
		end

	frozen get_physical_application_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_PhysicalApplicationPath"
		end

	frozen get_http_method: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_HttpMethod"
		end

	frozen get_client_certificate: SYSTEM_WEB_HTTPCLIENTCERTIFICATE is
		external
			"IL signature (): System.Web.HttpClientCertificate use System.Web.HttpRequest"
		alias
			"get_ClientCertificate"
		end

	frozen get_user_agent: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_UserAgent"
		end

	frozen get_item (key: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpRequest"
		alias
			"get_Item"
		end

	frozen get_server_variables: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Web.HttpRequest"
		alias
			"get_ServerVariables"
		end

	frozen get_url_referrer: SYSTEM_URI is
		external
			"IL signature (): System.Uri use System.Web.HttpRequest"
		alias
			"get_UrlReferrer"
		end

	frozen get_user_host_name: STRING is
		external
			"IL signature (): System.String use System.Web.HttpRequest"
		alias
			"get_UserHostName"
		end

	frozen get_headers: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
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

	frozen set_filter (value: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Web.HttpRequest"
		alias
			"set_Filter"
		end

	frozen set_request_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpRequest"
		alias
			"set_RequestType"
		end

	frozen set_browser (value: SYSTEM_WEB_HTTPBROWSERCAPABILITIES) is
		external
			"IL signature (System.Web.HttpBrowserCapabilities): System.Void use System.Web.HttpRequest"
		alias
			"set_Browser"
		end

feature -- Basic Operations

	frozen map_path_string_string (virtual_path: STRING; base_virtual_dir: STRING; allow_cross_app_mapping: BOOLEAN): STRING is
		external
			"IL signature (System.String, System.String, System.Boolean): System.String use System.Web.HttpRequest"
		alias
			"MapPath"
		end

	frozen save_as (filename: STRING; include_headers: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Web.HttpRequest"
		alias
			"SaveAs"
		end

	frozen map_image_coordinates (image_field_name: STRING): ARRAY [INTEGER] is
		external
			"IL signature (System.String): System.Int32[] use System.Web.HttpRequest"
		alias
			"MapImageCoordinates"
		end

	frozen binary_read (count: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Int32): System.Byte[] use System.Web.HttpRequest"
		alias
			"BinaryRead"
		end

	frozen map_path (virtual_path: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpRequest"
		alias
			"MapPath"
		end

end -- class SYSTEM_WEB_HTTPREQUEST
