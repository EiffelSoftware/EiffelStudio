indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebClient"

frozen external class
	SYSTEM_NET_WEBCLIENT

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE

create
	make_webclient

feature {NONE} -- Initialization

	frozen make_webclient is
		external
			"IL creator use System.Net.WebClient"
		end

feature -- Access

	frozen get_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebClient"
		alias
			"get_Headers"
		end

	frozen get_response_headers: SYSTEM_NET_WEBHEADERCOLLECTION is
		external
			"IL signature (): System.Net.WebHeaderCollection use System.Net.WebClient"
		alias
			"get_ResponseHeaders"
		end

	frozen get_query_string: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
		external
			"IL signature (): System.Collections.Specialized.NameValueCollection use System.Net.WebClient"
		alias
			"get_QueryString"
		end

	frozen get_credentials: SYSTEM_NET_ICREDENTIALS is
		external
			"IL signature (): System.Net.ICredentials use System.Net.WebClient"
		alias
			"get_Credentials"
		end

	frozen get_base_address: STRING is
		external
			"IL signature (): System.String use System.Net.WebClient"
		alias
			"get_BaseAddress"
		end

feature -- Element Change

	frozen set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Net.WebClient"
		alias
			"set_Credentials"
		end

	frozen set_query_string (value: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION) is
		external
			"IL signature (System.Collections.Specialized.NameValueCollection): System.Void use System.Net.WebClient"
		alias
			"set_QueryString"
		end

	frozen set_headers (value: SYSTEM_NET_WEBHEADERCOLLECTION) is
		external
			"IL signature (System.Net.WebHeaderCollection): System.Void use System.Net.WebClient"
		alias
			"set_Headers"
		end

	frozen set_base_address (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.WebClient"
		alias
			"set_BaseAddress"
		end

feature -- Basic Operations

	frozen upload_values_string_string (address: STRING; method: STRING; data: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.Collections.Specialized.NameValueCollection): System.Byte[] use System.Net.WebClient"
		alias
			"UploadValues"
		end

	frozen upload_file_string_string_string (address: STRING; method: STRING; file_name: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.String): System.Byte[] use System.Net.WebClient"
		alias
			"UploadFile"
		end

	frozen download_data (address: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String): System.Byte[] use System.Net.WebClient"
		alias
			"DownloadData"
		end

	frozen open_read (address: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Net.WebClient"
		alias
			"OpenRead"
		end

	frozen upload_values (address: STRING; data: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.Collections.Specialized.NameValueCollection): System.Byte[] use System.Net.WebClient"
		alias
			"UploadValues"
		end

	frozen open_write (address: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String): System.IO.Stream use System.Net.WebClient"
		alias
			"OpenWrite"
		end

	frozen upload_data (address: STRING; data: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.Byte[]): System.Byte[] use System.Net.WebClient"
		alias
			"UploadData"
		end

	frozen download_file (address: STRING; file_name: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Net.WebClient"
		alias
			"DownloadFile"
		end

	frozen open_write_string_string (address: STRING; method: STRING): SYSTEM_IO_STREAM is
		external
			"IL signature (System.String, System.String): System.IO.Stream use System.Net.WebClient"
		alias
			"OpenWrite"
		end

	frozen upload_data_string_string (address: STRING; method: STRING; data: ARRAY [INTEGER_8]): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String, System.Byte[]): System.Byte[] use System.Net.WebClient"
		alias
			"UploadData"
		end

	frozen upload_file (address: STRING; file_name: STRING): ARRAY [INTEGER_8] is
		external
			"IL signature (System.String, System.String): System.Byte[] use System.Net.WebClient"
		alias
			"UploadFile"
		end

end -- class SYSTEM_NET_WEBCLIENT
