indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Hosting.SimpleWorkerRequest"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_SIMPLE_WORKER_REQUEST

inherit
	WEB_HTTP_WORKER_REQUEST
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
	make_web_simple_worker_request_1,
	make_web_simple_worker_request

feature {NONE} -- Initialization

	frozen make_web_simple_worker_request_1 (app_virtual_dir: SYSTEM_STRING; app_physical_dir: SYSTEM_STRING; page: SYSTEM_STRING; query: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL creator signature (System.String, System.String, System.String, System.String, System.IO.TextWriter) use System.Web.Hosting.SimpleWorkerRequest"
		end

	frozen make_web_simple_worker_request (page: SYSTEM_STRING; query: SYSTEM_STRING; output: TEXT_WRITER) is
		external
			"IL creator signature (System.String, System.String, System.IO.TextWriter) use System.Web.Hosting.SimpleWorkerRequest"
		end

feature -- Access

	get_machine_config_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"get_MachineConfigPath"
		end

	get_machine_install_directory: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"get_MachineInstallDirectory"
		end

feature -- Basic Operations

	map_path (path: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"MapPath"
		end

	get_raw_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetRawUrl"
		end

	send_response_from_memory_array_byte (data: NATIVE_ARRAY [INTEGER_8]; length: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendResponseFromMemory"
		end

	send_response_from_file (filename: SYSTEM_STRING; offset: INTEGER_64; length: INTEGER_64) is
		external
			"IL signature (System.String, System.Int64, System.Int64): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendResponseFromFile"
		end

	send_status (status_code: INTEGER; status_description: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendStatus"
		end

	get_remote_address: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetRemoteAddress"
		end

	get_app_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetAppPath"
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

	get_file_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetFilePath"
		end

	get_query_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetQueryString"
		end

	get_http_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetHttpVersion"
		end

	get_file_path_translated: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetFilePathTranslated"
		end

	send_unknown_response_header (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendUnknownResponseHeader"
		end

	get_path_info: SYSTEM_STRING is
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

	get_local_address: SYSTEM_STRING is
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

	get_server_variable (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetServerVariable"
		end

	get_uri_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetUriPath"
		end

	get_http_verb_name: SYSTEM_STRING is
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

	send_known_response_header (index: INTEGER; value: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"SendKnownResponseHeader"
		end

	get_app_path_translated: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.SimpleWorkerRequest"
		alias
			"GetAppPathTranslated"
		end

end -- class WEB_SIMPLE_WORKER_REQUEST
