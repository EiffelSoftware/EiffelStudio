indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.WebClient"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_WEB_CLIENT

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_system_dll_web_client

feature {NONE} -- Initialization

	frozen make_system_dll_web_client is
		external
			"IL creator use System.Net.WebClient"
		end

feature -- Access

	frozen get_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebClient"
		alias
			"get_Headers"
		end

	frozen get_response_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebClient"
		alias
			"get_ResponseHeaders"
		end

	frozen get_query_string: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Net.WebClient"
		alias
			"get_QueryString"
		end

	frozen get_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL signature (): System.Net.ICredentials use System.Net.WebClient"
		alias
			"get_Credentials"
		end

	frozen get_base_address: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.WebClient"
		alias
			"get_BaseAddress"
		end

feature -- Element Change

	frozen set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.WebClient"
		alias
			"set_Credentials"
		end

	frozen set_query_string (value: SYSTEM_DLL_NAME_VALUE_COLLECTION) is
		external
			"IL signature (System.Collections.Specialized.NameValueCollection): System.Void use System.Net.WebClient"
		alias
			"set_QueryString"
		end

	frozen set_headers (value: SYSTEM_DLL_WEB_HEADER_COLLECTION) is
		external
			"IL signature (System.Net.WebHeaderCollection): System.Void use System.Net.WebClient"
		alias
			"set_Headers"
		end

	frozen set_base_address (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebClient"
		alias
			"set_BaseAddress"
		end

feature -- Basic Operations

	frozen upload_values_string_string (address: SYSTEM_STRING; method: SYSTEM_STRING; data: SYSTEM_DLL_NAME_VALUE_COLLECTION): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.Collections.Specialized.NameValueCollection): System.Byte[] use System.Net.WebClient"
		alias
			"UploadValues"
		end

	frozen upload_file_string_string_string (address: SYSTEM_STRING; method: SYSTEM_STRING; file_name: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.String): System.Byte[] use System.Net.WebClient"
		alias
			"UploadFile"
		end

	frozen download_data (address: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String): System.Byte[] use System.Net.WebClient"
		alias
			"DownloadData"
		end

	frozen open_read (address: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Net.WebClient"
		alias
			"OpenRead"
		end

	frozen upload_values (address: SYSTEM_STRING; data: SYSTEM_DLL_NAME_VALUE_COLLECTION): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Byte[] use System.Net.WebClient"
		alias
			"UploadValues"
		end

	frozen open_write (address: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Net.WebClient"
		alias
			"OpenWrite"
		end

	frozen upload_data (address: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.Byte[]): System.Byte[] use System.Net.WebClient"
		alias
			"UploadData"
		end

	frozen download_file (address: SYSTEM_STRING; file_name: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebClient"
		alias
			"DownloadFile"
		end

	frozen open_write_string_string (address: SYSTEM_STRING; method: SYSTEM_STRING): SYSTEM_STREAM is
		external
			"IL signature (System.String, System.String): System.IO.Stream use System.Net.WebClient"
		alias
			"OpenWrite"
		end

	frozen upload_data_string_string (address: SYSTEM_STRING; method: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.Byte[]): System.Byte[] use System.Net.WebClient"
		alias
			"UploadData"
		end

	frozen upload_file (address: SYSTEM_STRING; file_name: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String): System.Byte[] use System.Net.WebClient"
		alias
			"UploadFile"
		end

end -- class SYSTEM_DLL_WEB_CLIENT
