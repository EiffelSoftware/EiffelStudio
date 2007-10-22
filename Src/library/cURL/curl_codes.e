indexing
	description: "[
						All possible error codes from all sorts of curl functions.
						Future versions	may return other values, stay prepared.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_CODES

feature -- Constants

	curle_ok: INTEGER is 0
			-- Declared as CURLE_OK

	curle_unsupported_protocol: INTEGER is 1
			-- Declared as CURLE_UNSUPPORTED_PROTOCOL

	curle_failed_init: INTEGER is 2
			-- Declared as CURLE_FAILED_INIT

  	curle_url_malformat: INTEGER is 3
  			-- Declared as CURLE_URL_MALFORMAT

 	curle_obsolete4: INTEGER is 4
 	 		-- Declared as CURLE_OBSOLETE4
 	 		-- NOT USED

 	curle_couldnt_resolve_proxy: INTEGER is 5
 			-- Declared as CURLE_COULDNT_RESOLVE_PROXY

  	curle_couldnt_resolve_host: INTEGER is 6
  			-- Declared as CURLE_COULDNT_RESOLVE_HOST

  	curle_couldnt_connect: INTEGER is 7
  			-- Declared as CURLE_COULDNT_CONNECT

  	curle_ftp_weird_server_reply: INTEGER is 8
  			-- Declared as CURLE_FTP_WEIRD_SERVER_REPLY

	curle_remote_access_denied: INTEGER is 9
			-- Declared as CURLE_REMOTE_ACCESS_DENIED
			-- A service was denied by the server due to lack of access
			-- when login fails this is not returned.

	curle_obsolete10: INTEGER is 10
			-- Declared as CURLE_OBSOLETE10 NOT USED

	curle_ftp_weird_pass_reply: INTEGER is 11
			-- Declared as CURLE_FTP_WEIRD_PASS_REPLY

  	curle_obsolete12: INTEGER is 12
  			-- Declared as CURLE_OBSOLETE12 NOT USED

	curle_ftp_weird_pasv_reply: INTEGER is 13
			-- Declared as CURLE_FTP_WEIRD_PASV_REPLY

  	curle_ftp_weird_227_format: INTEGER is 14
  			-- Declared as CURLE_FTP_WEIRD_227_FORMAT

	curle_ftp_cant_get_host: INTEGER is 15
			-- Declared as CURLE_FTP_CANT_GET_HOST

  	curle_obsolete16: INTEGER is 16
  			-- Declared as CURLE_OBSOLETE16
  			-- NOT USED

	curle_ftp_couldnt_set_type: INTEGER is 17
			-- Declared as CURLE_FTP_COULDNT_SET_TYPE

	curle_partial_file: INTEGER is 18
			-- Declared as CURLE_PARTIAL_FILE

  	curle_ftp_couldnt_retr_file: INTEGER is 19
  			-- Declared as CURLE_FTP_COULDNT_RETR_FILE

  	curle_obsolete20: INTEGER is 20
  			-- Declared as CURLE_OBSOLETE20
  			-- NOT USED

  	curle_quote_error: INTEGER is 21
  			-- Declared as CURLE_QUOTE_ERROR
  			-- quote command failure

  	curle_http_returned_error: INTEGER is 22
  			-- Declared as CURLE_HTTP_RETURNED_ERROR

  	curle_write_error: INTEGER is 23
  			-- Declared as CURLE_WRITE_ERROR

  	curle_obsolete24: INTEGER is 24
  			-- Declared as CURLE_OBSOLETE24 NOT USED

	curle_upload_failed: INTEGER is 25
  			-- Declared as CURLE_UPLOAD_FAILED
  			-- failed upload "command"

	curle_read_error: INTEGER is 26
  			-- Declared as CURLE_READ_ERROR
  			-- couldn't open/read from file

	curle_out_of_memory: INTEGER is 27
  			-- Declared as CURLE_OUT_OF_MEMORY
  			-- Note: CURLE_OUT_OF_MEMORY may sometimes indicate a conversion error
  			-- instead of a memory allocation error if CURL_DOES_CONVERSIONS
  			-- is defined

	curle_operation_timedout: INTEGER is 28
  			-- Declared as CURLE_OPERATION_TIMEDOUT
  			-- the timeout time was reached

	curle_obsolete29: INTEGER is 29
			-- Declared as CURLE_OBSOLETE29
			-- NOT USED

	curle_ftp_port_failed: INTEGER is 30
			-- Declared as CURLE_FTP_PORT_FAILED
			-- FTP PORT operation failed

	curle_ftp_couldnt_use_rest: INTEGER is 31
			-- Declared as CURLE_FTP_COULDNT_USE_REST
			-- the REST command failed

	curle_obsolete32: INTEGER is 32
			-- Declared as CURLE_OBSOLETE32
			-- NOT USED

	curle_range_error: INTEGER is 33
			-- Declared as CURLE_RANGE_ERROR
			-- RANGE "command" didn't work

	curle_http_post_error: INTEGER is 34
			-- Declared as CURLE_HTTP_POST_ERROR

	curle_ssl_connect_error: INTEGER is 35
			-- Declared CURLE_SSL_CONNECT_ERROR
			-- wrong when connecting with SSL

	curle_bad_download_resume: INTEGER is 36
			-- Declared as CURLE_BAD_DOWNLOAD_RESUME
			-- couldn't resume download

	curle_file_couldnt_read_file: INTEGER is 37
			-- Declared as CURLE_FILE_COULDNT_READ_FILE

	curle_ldap_cannot_bind: INTEGER is 38
			-- Declared as CURLE_LDAP_CANNOT_BIND

	curle_ldap_search_failed: INTEGER is 39
			-- Declared as CURLE_LDAP_SEARCH_FAILED

	curle_obsolete40: INTEGER is 40
			-- Declared as CURLE_OBSOLETE40
			-- NOT USED

	curle_function_not_found: INTEGER is 41
			-- Declared as CURLE_FUNCTION_NOT_FOUND

	curle_aborted_by_callback: INTEGER is 42
			-- Declared as CURLE_ABORTED_BY_CALLBACK

	curle_bad_function_argument: INTEGER is 43
			-- Declared as CURLE_BAD_FUNCTION_ARGUMENT

	curle_obsolete44: INTEGER is 44
			-- Declared as CURLE_OBSOLETE44
			-- NOT USED

	curle_interface_failed: INTEGER is 45
			-- Declared as CURLE_INTERFACE_FAILED
			-- CURLOPT_INTERFACE failed

	curle_obsolete46: INTEGER is 46
			-- Declared as CURLE_OBSOLETE46
			-- NOT USED

	curle_too_many_redirects: INTEGER is 47
			-- Declared as CURLE_TOO_MANY_REDIRECTS
			-- catch endless re-direct loops

	curle_unknown_telnet_option: INTEGER is 48
			-- Declared as CURLE_UNKNOWN_TELNET_OPTION
			-- User specified an unknown option

	curle_telnet_option_syntax: INTEGER is 49
			-- Declared as CURLE_TELNET_OPTION_SYNTAX
			-- Malformed telnet option

	curle_obsolete50: INTEGER is 50
			-- Declared as CURLE_OBSOLETE50
			-- NOT USED

	curle_ssl_peer_certificate: INTEGER is 51
			-- Declared as CURLE_SSL_PEER_CERTIFICATE
			-- peer's certificate wasn't ok

	curle_got_nothing: INTEGER is 52
			-- Declared as CURLE_GOT_NOTHING
			-- when this is a specific error

	curle_ssl_engine_notfound: INTEGER is 53
			-- Declared as CURLE_SSL_ENGINE_NOTFOUND
			-- SSL crypto engine not found */

	curle_ssl_engine_setfailed: INTEGER is 54
			-- Declared as CURLE_SSL_ENGINE_SETFAILED
			-- can not set SSL crypto engine as default

	curle_send_error: INTEGER is 55
			-- Declared as CURLE_SEND_ERROR
			-- failed sending network data

	curle_recv_error: INTEGER is 56
			-- Declared as CURLE_RECV_ERROR
			-- failure in receiving network data

	curle_obsolete57: INTEGER is 57
			-- Declared as CURLE_OBSOLETE57
			-- NOT IN USE

	curle_ssl_certproblem: INTEGER is 58
			-- Declared as CURLE_SSL_CERTPROBLEM
			-- problem with the local certificate

	curle_ssl_cipher: INTEGER is 59
			-- Declared as CURLE_SSL_CIPHER
			-- couldn't use specified cipher

	curle_ssl_cacert: INTEGER is 60
			-- Declared as CURLE_SSL_CACERT
			-- problem with the CA cert (path?)

	curle_bad_content_encoding: INTEGER is 61
			-- Declared as CURLE_BAD_CONTENT_ENCODING
			-- Unrecognized transfer encoding

	curle_ldap_invalid_url: INTEGER is 62
			-- Declared as CURLE_LDAP_INVALID_URL
			-- Invalid LDAP URL

	curle_filesize_exceeded: INTEGER is 63
			-- Declared as CURLE_FILESIZE_EXCEEDED
			-- Maximum file size exceeded

	curle_use_ssl_failed: INTEGER is 64
			-- Declared as CURLE_USE_SSL_FAILED
			-- Requested FTP SSL level failed

	curle_send_fail_rewind: INTEGER is 65
			-- Declared as CURLE_SEND_FAIL_REWIND
			-- Sending the data requires a rewind that failed

	curle_ssl_engine_initfailed: INTEGER is 66
			-- Declared as CURLE_SSL_ENGINE_INITFAILED
			-- failed to initialise ENGINE

	curle_login_denied: INTEGER is 67
			-- Declared as CURLE_LOGIN_DENIED
			-- user, password or similar was not accepted and we failed to login

	curle_tftp_notfound: INTEGER is 68
			-- Declared as CURLE_TFTP_NOTFOUND
			-- file not found on server

	curle_tftp_perm: INTEGER is 69
			-- Declared as CURLE_TFTP_PERM
			-- permission problem on server

	curle_remote_disk_full: INTEGER is 70
			-- Declared as CURLE_REMOTE_DISK_FULL
			-- out of disk space on server

	curle_tftp_illegal: INTEGER is 71
			-- Declared as CURLE_TFTP_ILLEGAL
			-- Illegal TFTP operation

	curle_tftp_unknownid: INTEGER is 72
			-- Declared as CURLE_TFTP_UNKNOWNID
			-- Unknown transfer ID

	curle_remote_file_exists: INTEGER is 73
			-- Declared as CURLE_REMOTE_FILE_EXISTS
			-- File already exists

	curle_tftp_nosuchuser: INTEGER is 74
			-- Declared as CURLE_TFTP_NOSUCHUSER
			-- No such user

	curle_conv_failed: INTEGER is 75
			-- Declared as CURLE_CONV_FAILED
			-- conversion failed

	curle_conv_reqd: INTEGER is 76
			-- Declared as CURLE_CONV_REQD
			-- caller must register conversion callbacks using curl_easy_setopt options
            -- CURLOPT_CONV_FROM_NETWORK_FUNCTION, CURLOPT_CONV_TO_NETWORK_FUNCTION, and
            -- CURLOPT_CONV_FROM_UTF8_FUNCTION

	curle_ssl_cacert_badfile: INTEGER is 77
			-- Declared as CURLE_SSL_CACERT_BADFILE
			-- could not load CACERT file, missing or wrong format

	curle_remote_file_not_found: INTEGER is 78
			-- Declared as CURLE_REMOTE_FILE_NOT_FOUND
			-- remote file not found

	curle_ssh: INTEGER is 79
			-- Declared as CURLE_SSH
			-- error from the SSH layer, somewhat generic so the error message will be of
            -- interest when this has happened

	curle_ssl_shutdown_failed: INTEGER is 80;
			-- Declared as CURLE_SSL_SHUTDOWN_FAILED
			-- Failed to shut down the SSL connection
	
indexing
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
