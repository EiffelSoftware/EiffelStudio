indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Hosting.SimpleWorkerRequest"

external class
	SYSTEM_WEB_HOSTING_SIMPLEWORKERREQUEST

inherit
	SYSTEM_WEB_HTTPWORKERREQUEST
		redefine
			get_machine_config_path,
			map_path,
			get_machine_install_directory,
			get_server_variable,
			get_app_path_translated,
			get_app_path,
			get_path_info,
			get_file_path_translated,
			get_file_path,
			get_user_token
		end

create
	make_simpleworkerrequest_1,
	make_simpleworkerrequest

feature {NONE} -- Initialization

	frozen make_simpleworkerrequest_1 (app_virtual_dir: STRING; app_physical_dir: STRING; page: STRING; query: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String, System.IO.TextWriter) use System.Web.Hosting.SimpleWorkerRequest"
		end

	frozen make_simpleworkerrequest (page: STRING; query: STRING; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.String, System.String, System.IO.TextWriter) use System.Web.Hosting.SimpleWorkerRequest"
		end

feature -- Access

	get_machine_config_path: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"get_MachineConfigPath"
		end

	get_machine_install_directory: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"get_MachineInstallDirectory"
		end

feature -- Basic Operations

	map_path (path: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"MapPath"
		end

	get_raw_url: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetRawUrl"
		end

	send_response_from_memory (data: ARRAY [INTEGER_8]; length: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendResponseFromMemory"
		end

	get_query_string: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetQueryString"
		end

	get_app_path: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetAppPath"
		end

	send_status (status_code: INTEGER; status_description: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendStatus"
		end

	get_remote_address: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetRemoteAddress"
		end

	get_file_path: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetFilePath"
		end

	get_remote_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetRemotePort"
		end

	flush_response (final_flush: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"FlushResponse"
		end

	send_response_from_file (filename: STRING; offset: INTEGER_64; length: INTEGER_64) is
		external
			"IL signature (System.String, System.Int64, System.Int64): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendResponseFromFile"
		end

	get_http_version: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetHttpVersion"
		end

	get_file_path_translated: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetFilePathTranslated"
		end

	send_unknown_response_header (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendUnknownResponseHeader"
		end

	get_path_info: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetPathInfo"
		end

	get_local_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetLocalPort"
		end

	get_local_address: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetLocalAddress"
		end

	end_of_request is
		external
			"IL signature (): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"EndOfRequest"
		end

	get_server_variable (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetServerVariable"
		end

	get_uri_path: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetUriPath"
		end

	get_http_verb_name: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetHttpVerbName"
		end

	send_response_from_file_int_ptr (handle: POINTER; offset: INTEGER_64; length: INTEGER_64) is
		external
			"IL signature (System.IntPtr, System.Int64, System.Int64): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendResponseFromFile"
		end

	get_user_token: POINTER is
		external
			"IL signature (): System.IntPtr use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetUserToken"
		end

	send_known_response_header (index: INTEGER; value: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendKnownResponseHeader"
		end

	get_app_path_translated: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetAppPathTranslated"
		end

end -- class SYSTEM_WEB_HOSTING_SIMPLEWORKERREQUEST
