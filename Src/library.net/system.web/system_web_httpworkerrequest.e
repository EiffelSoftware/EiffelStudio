indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpWorkerRequest"

deferred external class
	SYSTEM_WEB_HTTPWORKERREQUEST

feature -- Access

	frozen header_if_modified_since: INTEGER is 0x1e

	frozen request_header_maximum: INTEGER is 0x28

	frozen header_location: INTEGER is 0x17

	frozen header_transfer_encoding: INTEGER is 0x6

	frozen reason_response_cache_miss: INTEGER is 0x0

	frozen header_accept_charset: INTEGER is 0x15

	frozen header_authorization: INTEGER is 0x18

	frozen header_content_location: INTEGER is 0xf

	frozen header_retry_after: INTEGER is 0x19

	frozen header_if_none_match: INTEGER is 0x1f

	frozen header_cache_control: INTEGER is 0x0

	frozen header_upgrade: INTEGER is 0x7

	frozen header_vary: INTEGER is 0x1c

	frozen header_content_encoding: INTEGER is 0xd

	frozen header_allow: INTEGER is 0xa

	frozen header_if_range: INTEGER is 0x20

	frozen header_if_unmodified_since: INTEGER is 0x21

	frozen header_content_md5: INTEGER is 0x10

	frozen reason_default: INTEGER is 0x0

	frozen header_content_language: INTEGER is 0xe

	frozen reason_cache_security: INTEGER is 0x3

	frozen header_date: INTEGER is 0x2

	frozen header_connection: INTEGER is 0x1

	frozen header_expires: INTEGER is 0x12

	frozen header_accept_encoding: INTEGER is 0x16

	frozen header_pragma: INTEGER is 0x4

	frozen header_proxy_authorization: INTEGER is 0x23

	frozen header_proxy_authenticate: INTEGER is 0x18

	frozen reason_cache_policy: INTEGER is 0x2

	get_machine_install_directory: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"get_MachineInstallDirectory"
		end

	get_machine_config_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"get_MachineConfigPath"
		end

	frozen header_if_match: INTEGER is 0x1d

	frozen header_accept: INTEGER is 0x14

	frozen header_trailer: INTEGER is 0x5

	frozen header_warning: INTEGER is 0x9

	frozen header_via: INTEGER is 0x8

	frozen header_expect: INTEGER is 0x1a

	frozen response_header_maximum: INTEGER is 0x1e

	frozen header_referer: INTEGER is 0x24

	frozen header_server: INTEGER is 0x1a

	frozen header_from: INTEGER is 0x1b

	frozen header_content_type: INTEGER is 0xc

	frozen header_range: INTEGER is 0x25

	frozen header_last_modified: INTEGER is 0x13

	frozen header_age: INTEGER is 0x15

	frozen reason_file_handle_cache_miss: INTEGER is 0x1

	frozen header_etag: INTEGER is 0x16

	frozen header_content_range: INTEGER is 0x11

	frozen header_accept_language: INTEGER is 0x17

	frozen header_user_agent: INTEGER is 0x27

	frozen header_cookie: INTEGER is 0x19

	frozen header_max_forwards: INTEGER is 0x22

	frozen header_accept_ranges: INTEGER is 0x14

	frozen reason_client_disconnect: INTEGER is 0x4

	frozen header_host: INTEGER is 0x1c

	frozen header_keep_alive: INTEGER is 0x3

	frozen header_content_length: INTEGER is 0xb

	frozen header_www_authenticate: INTEGER is 0x1d

	frozen header_set_cookie: INTEGER is 0x1b

	frozen header_te: INTEGER is 0x26

feature -- Basic Operations

	get_preloaded_entity_body: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpWorkerRequest"
		alias
			"GetPreloadedEntityBody"
		end

	get_client_certificate_encoding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"GetClientCertificateEncoding"
		end

	send_status (status_code: INTEGER; status_description: STRING) is
		external
			"IL deferred signature (System.Int32, System.String): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendStatus"
		end

	get_request_reason: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"GetRequestReason"
		end

	get_remote_port: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"GetRemotePort"
		end

	end_of_request is
		external
			"IL deferred signature (): System.Void use System.Web.HttpWorkerRequest"
		alias
			"EndOfRequest"
		end

	get_raw_url: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetRawUrl"
		end

	get_remote_address: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetRemoteAddress"
		end

	frozen get_known_request_header_name (index: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetKnownRequestHeaderName"
		end

	get_uri_path: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetUriPath"
		end

	get_server_name: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetServerName"
		end

	get_client_certificate_binary_issuer: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpWorkerRequest"
		alias
			"GetClientCertificateBinaryIssuer"
		end

	get_client_certificate: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpWorkerRequest"
		alias
			"GetClientCertificate"
		end

	get_url_context_id: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Web.HttpWorkerRequest"
		alias
			"GetUrlContextID"
		end

	get_connection_id: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Web.HttpWorkerRequest"
		alias
			"GetConnectionID"
		end

	frozen get_known_request_header_index (header: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"GetKnownRequestHeaderIndex"
		end

	get_query_string: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetQueryString"
		end

	get_query_string_raw_bytes: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpWorkerRequest"
		alias
			"GetQueryStringRawBytes"
		end

	frozen has_entity_body: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpWorkerRequest"
		alias
			"HasEntityBody"
		end

	get_file_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetFilePath"
		end

	get_http_verb_name: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetHttpVerbName"
		end

	get_app_pool_id: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetAppPoolID"
		end

	send_known_response_header (index: INTEGER; value: STRING) is
		external
			"IL deferred signature (System.Int32, System.String): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendKnownResponseHeader"
		end

	frozen get_known_response_header_name (index: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetKnownResponseHeaderName"
		end

	is_secure: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpWorkerRequest"
		alias
			"IsSecure"
		end

	read_entity_body (buffer: ARRAY [INTEGER_8]; size: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"ReadEntityBody"
		end

	get_unknown_request_header (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetUnknownRequestHeader"
		end

	send_response_from_file_int_ptr (handle: POINTER; offset: INTEGER_64; length: INTEGER_64) is
		external
			"IL deferred signature (System.IntPtr, System.Int64, System.Int64): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendResponseFromFile"
		end

	get_local_address: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetLocalAddress"
		end

	send_unknown_response_header (name: STRING; value: STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendUnknownResponseHeader"
		end

	get_app_path: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetAppPath"
		end

	get_known_request_header (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetKnownRequestHeader"
		end

	get_client_certificate_valid_from: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpWorkerRequest"
		alias
			"GetClientCertificateValidFrom"
		end

	get_local_port: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"GetLocalPort"
		end

	headers_sent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpWorkerRequest"
		alias
			"HeadersSent"
		end

	send_response_from_memory (data: ARRAY [INTEGER_8]; length: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendResponseFromMemory"
		end

	set_end_of_send_notification (callback: ENDOFSENDNOTIFICATION_IN_SYSTEM_WEB_HTTPWORKERREQUEST; extra_data: ANY) is
		external
			"IL signature (System.Web.HttpWorkerRequest+EndOfSendNotification, System.Object): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SetEndOfSendNotification"
		end

	is_entire_entity_body_is_preloaded: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpWorkerRequest"
		alias
			"IsEntireEntityBodyIsPreloaded"
		end

	get_http_version: STRING is
		external
			"IL deferred signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetHttpVersion"
		end

	frozen get_status_description (code: INTEGER): STRING is
		external
			"IL static signature (System.Int32): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetStatusDescription"
		end

	get_app_path_translated: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetAppPathTranslated"
		end

	get_protocol: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetProtocol"
		end

	get_client_certificate_valid_until: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpWorkerRequest"
		alias
			"GetClientCertificateValidUntil"
		end

	get_user_token: POINTER is
		external
			"IL signature (): System.IntPtr use System.Web.HttpWorkerRequest"
		alias
			"GetUserToken"
		end

	send_response_from_file (filename: STRING; offset: INTEGER_64; length: INTEGER_64) is
		external
			"IL deferred signature (System.String, System.Int64, System.Int64): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendResponseFromFile"
		end

	get_file_path_translated: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetFilePathTranslated"
		end

	is_client_connected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpWorkerRequest"
		alias
			"IsClientConnected"
		end

	close_connection is
		external
			"IL signature (): System.Void use System.Web.HttpWorkerRequest"
		alias
			"CloseConnection"
		end

	get_bytes_read: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Web.HttpWorkerRequest"
		alias
			"GetBytesRead"
		end

	send_calculated_content_length (content_length: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendCalculatedContentLength"
		end

	get_client_certificate_public_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpWorkerRequest"
		alias
			"GetClientCertificatePublicKey"
		end

	get_server_variable (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetServerVariable"
		end

	get_path_info: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetPathInfo"
		end

	get_remote_name: STRING is
		external
			"IL signature (): System.String use System.Web.HttpWorkerRequest"
		alias
			"GetRemoteName"
		end

	flush_response (final_flush: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Web.HttpWorkerRequest"
		alias
			"FlushResponse"
		end

	send_response_from_memory_int_ptr (data: POINTER; length: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use System.Web.HttpWorkerRequest"
		alias
			"SendResponseFromMemory"
		end

	get_virtual_path_token: POINTER is
		external
			"IL signature (): System.IntPtr use System.Web.HttpWorkerRequest"
		alias
			"GetVirtualPathToken"
		end

	frozen get_known_response_header_index (header: STRING): INTEGER is
		external
			"IL static signature (System.String): System.Int32 use System.Web.HttpWorkerRequest"
		alias
			"GetKnownResponseHeaderIndex"
		end

	map_path (virtual_path: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpWorkerRequest"
		alias
			"MapPath"
		end

end -- class SYSTEM_WEB_HTTPWORKERREQUEST
