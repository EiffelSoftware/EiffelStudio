note
	description: "[
					libcurl library opt constants
					For more informaton see:

					http://curl.haxx.se/libcurl/c/curl_easy_setopt.html

					Code related to LIBCURL_VERSION: 7.17.0
				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_OPT_CONSTANTS

feature -- Version

	libcurl_version: STRING
			-- String representation of LIBCURL_VERSION
		do
			create Result.make_from_c (libcurl_version_pointer)
		end

	libcurl_version_pointer: POINTER
			-- String pointer declared as LIBCURL_VERSION
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION;"
		end

	libcurl_version_major: INTEGER
			-- Declared as LIBCURL_VERSION_MAJOR
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION_MAJOR;"
		end

	libcurl_version_minor: INTEGER
			-- Declared as LIBCURL_VERSION_MINOR
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION_MINOR;"
		end

	libcurl_version_patch: INTEGER
			-- Declared as LIBCURL_VERSION_PATCH
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION_PATCH;"
		end

feature -- Behavior

	curlopt_verbose: INTEGER
			-- Declared as CURLOPT_VERBOSE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_VERBOSE;"
		end

	curlopt_header: INTEGER
			-- Declared as CURLOPT_HEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HEADER;"
		end

	curlopt_noprogress: INTEGER
			-- Declared as CURLOPT_NOPROGRESS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_NOPROGRESS;"
		end

feature -- Callback

	curlopt_writefunction: INTEGER
			-- Declared as CURLOPT_WRITEFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_WRITEFUNCTION;"
		end

	curlopt_writedata: INTEGER
			-- Declared as CURLOPT_WRITEDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_WRITEDATA;"
		end

	curlopt_readfunction: INTEGER
			-- Declared as CURLOPT_READFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_READFUNCTION;"
		end

	curlopt_readdata: INTEGER
			-- Declared as CURLOPT_READDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_READDATA;"
		end

	curlopt_debugfunction: INTEGER
			-- Declared as CURLOPT_DEBUGFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_DEBUGFUNCTION;"
		end

	curlopt_progressfunction: INTEGER
			-- Declared as CURLOPT_PROGRESSFUNCTION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROGRESSFUNCTION;"
		end

	curlopt_progressdata: INTEGER
			-- Declared as CURLOPT_PROGRESSDATA
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROGRESSDATA;"
		end

	curlopt_writeheader: INTEGER
			-- Declared as CURLOPT_WRITEHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_WRITEHEADER;"
		end

feature -- Network

	curlopt_url: INTEGER
			-- Declared as CURLOPT_URL.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_URL;"
		end

	curlopt_proxy: INTEGER
			-- Declared as CURLOPT_PROXY.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXY;"
		end

	curlopt_proxyport: INTEGER
			-- Declared as CURLOPT_PROXYPORT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYPORT;"
		end

	curlopt_proxytype: INTEGER
			-- Declared as CURLOPT_PROXYTYPE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYTYPE;"
		end

	curlopt_httpproxytunnel: INTEGER
			-- Declared as CURLOPT_HTTPPROXYTUNNEL.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPPROXYTUNNEL;"
		end

	curlopt_interface: INTEGER
			-- Declared as CURLOPT_INTERFACE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_INTERFACE;"
		end

	curlopt_localport: INTEGER
			-- Declared as CURLOPT_LOCALPORT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOCALPORT;"
		end

	curlopt_localportrange: INTEGER
			-- Declared as CURLOPT_LOCALPORTRANGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOCALPORTRANGE;"
		end

	curlopt_buffersize: INTEGER
			-- Declared as CURLOPT_BUFFERSIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_BUFFERSIZE"
		end

	curlopt_port: INTEGER
			-- Declared as CURLOPT_PORT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PORT;"
		end

	curlopt_tcp_nodelay: INTEGER
			-- Declared as CURLOPT_TCP_NODELAY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TCP_NODELAY;"
		end

feature -- Names and Passwords (Authentication)

	curlopt_userpwd: INTEGER
			-- Declared as CURLOPT_USERPWD.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_USERPWD;"
		end

	curlopt_proxyuserpwd: INTEGER
			-- Declared as CURLOPT_PROXYUSERPWD
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYUSERPWD;"
		end

	curlopt_httpauth: INTEGER
			-- Declared as CURLOPT_HTTPAUTH.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPAUTH;"
		end

	curlauth_none: INTEGER
			-- Declared as CURLAUTH_NONE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_NONE;"
		end

	curlauth_basic: INTEGER
			-- Declared as CURLAUTH_BASIC.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_BASIC;"
		end

	curlauth_digest: INTEGER
			-- Declared as CURLAUTH_DIGEST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_DIGEST;"
		end

	curlauth_any: INTEGER
			-- Declared as CURLAUTH_ANY.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_ANY;"
		end

	curlauth_anysafe: INTEGER
			-- Declared as CURLAUTH_ANYSAFE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_ANYSAFE;"
		end

	curlopt_proxyauth: INTEGER
			-- Declared as CURLOPT_PROXYAUTH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYAUTH;"
		end

feature -- HTTP

	curlopt_autoreferer: INTEGER
			-- Declared as CURLOPT_AUTOREFERER
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_AUTOREFERER;"
		end

	curlopt_encoding: INTEGER
			-- Declared as CURLOPT_ENCODING.
			-- in future version, this is called CURLOPT_ACCEPT_ENCODING
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_ENCODING;"
		end

	curlopt_followlocation: INTEGER
			-- Declared as CURLOPT_FOLLOWLOCATION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FOLLOWLOCATION;"
		end

	curlopt_unrestricted_auth: INTEGER
			-- Declared as CURLOPT_UNRESTRICTED_AUTH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_UNRESTRICTED_AUTH;"
		end

	curlopt_maxredirs: INTEGER
			-- Declared as CURLOPT_MAXREDIRS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXREDIRS;"
		end

	curlopt_put: INTEGER
			-- Declared as CURLOPT_PUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PUT;"
		end

	curlopt_post: INTEGER
			-- Declared as CURLOPT_POST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POST;"
		end

	curlopt_postfields: INTEGER
			-- Declared as CURLOPT_POSTFIELDS.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POSTFIELDS;"
		end

	curlopt_postfieldsize: INTEGER
			-- Declared as CURLOPT_POSTFIELDSIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POSTFIELDSIZE;"
		end

	curlopt_postfieldsize_large: INTEGER
			-- Declared as CURLOPT_POSTFIELDSIZE_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POSTFIELDSIZE_LARGE;"
		end

	curlopt_httppost: INTEGER
			-- Declared as CURLOPT_HTTPPOST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPPOST;"
		end

	curlopt_referer: INTEGER
			-- Declared as CURLOPT_REFERER
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_REFERER;"
		end

	curlopt_useragent: INTEGER
			-- Declared as CURLOPT_USERAGENT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_USERAGENT;"
		end

	curlopt_httpheader: INTEGER
			-- Declared as CURLOPT_HTTPHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPHEADER;"
		end

	curlopt_cookie: INTEGER
			-- Declared as CURLOPT_COOKIE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIE;"
		end

	curlopt_cookiefile: INTEGER
			-- Declared as CURLOPT_COOKIEFILE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIEFILE;"
		end

	curlopt_cookiejar: INTEGER
			-- Declared as CURLOPT_COOKIEJAR
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIEJAR;"
		end

	curlopt_cookiesession: INTEGER
			-- Declared as CURLOPT_COOKIESESSION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIESESSION;"
		end

	curlopt_cookielist: INTEGER
			-- Declared as CURLOPT_COOKIELIST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIELIST"
		end

	curlopt_httpget: INTEGER
			-- Declared as CURLOPT_HTTPGET
			-- Pass a long. If the long is non-zero, this forces the HTTP request to get back to GET. usable if a POST, HEAD, PUT or a custom request have been used previously using the same curl handle.
			-- When setting CURLOPT_HTTPGET to a non-zero value, it will automatically set CURLOPT_NOBODY to 0 (since 7.14.1).
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPGET;"
		end

	curlopt_http_version: INTEGER
			-- Declared as CURLOPT_HTTP_VERSION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTP_VERSION;"
		end

	curlopt_ignore_content_length: INTEGER
			-- Declared as CURLOPT_IGNORE_CONTENT_LENGTH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_IGNORE_CONTENT_LENGTH;"
		end

	curlopt_http_content_decoding: INTEGER
			-- Declared as CURLOPT_HTTP_CONTENT_DECODING
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTP_CONTENT_DECODING;"
		end

feature -- Protocol

	curlopt_transfertext: INTEGER
			-- Declared as CURLOPT_TRANSFERTEXT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TRANSFERTEXT;"
		end

	curlopt_crlf: INTEGER
			-- Declared as CURLOPT_CRLF
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CRLF;"
		end

	curlopt_resume_from: INTEGER
			-- Declared as CURLOPT_RESUME_FROM
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_RESUME_FROM;"
		end

	curlopt_resume_from_large: INTEGER
			-- Declared as CURLOPT_RESUME_FROM_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_RESUME_FROM_LARGE;"
		end

	curlopt_customrequest: INTEGER
			-- Declared as CURLOPT_CUSTOMREQUEST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CUSTOMREQUEST"
		end

	curlopt_filetime: INTEGER
			-- Declared as CURLOPT_FILETIME
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FILETIME;"
		end

	curlopt_nobody: INTEGER
			-- Declared as CURLOPT_NOBODY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_NOBODY;"
		end

	curlopt_infilesize: INTEGER
			-- Declared as CURLOPT_INFILESIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_INFILESIZE;"
		end

	curlopt_infilesize_large: INTEGER
			-- Declared as CURLOPT_INFILESIZE_LARGE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_INFILESIZE_LARGE;"
		end

	curlopt_upload: INTEGER
			-- Declared as CURLOPT_UPLOAD.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_UPLOAD;"
		end

	curlopt_maxfilesize: INTEGER
			-- Declared as CURLOPT_MAXFILESIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXFILESIZE;"
		end

	curlopt_maxfilesize_large: INTEGER
			-- Declared as CURLOPT_MAXFILESIZE_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXFILESIZE_LARGE;"
		end

	curlopt_timecondition: INTEGER
			-- Declared as CURLOPT_TIMECONDITION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMECONDITION;"
		end

	curlopt_timevalue: INTEGER
			-- Declared as CURLOPT_TIMEVALUE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMEVALUE;"
		end

feature -- Connection

	curlopt_timeout: INTEGER
			-- Declared as CURLOPT_TIMEOUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMEOUT"
		end

	curlopt_connect_timeout: INTEGER
			-- The number of seconds to wait while trying to connect. Use 0 to wait indefinitely.
			-- Declared as CURLOPT_CONNECTTIMEOUT
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_CONNECTTIMEOUT
			]"
		end

	curlopt_timeout_ms: INTEGER
			-- Declared as CURLOPT_TIMEOUT_MS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMEOUT_MS;"
		end

	curlopt_low_speed_limit: INTEGER
			-- Declared as CURLOPT_LOW_SPEED_LIMIT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOW_SPEED_LIMIT;"
		end

	curlopt_low_speed_time: INTEGER
			-- Declared as CURLOPT_LOW_SPEED_TIME
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOW_SPEED_TIME;"
		end

	curlopt_max_send_speed_large: INTEGER
			-- Declared as CURLOPT_MAX_SEND_SPEED_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAX_SEND_SPEED_LARGE;"
		end

	curlopt_max_recv_speed_large: INTEGER
			-- Declared as CURLOPT_MAX_RECV_SPEED_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAX_RECV_SPEED_LARGE;"
		end

	curlopt_maxconnects: INTEGER
			-- Declared as CURLOPT_MAXCONNECTS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXCONNECTS;"
		end

	curlopt_fresh_connect: INTEGER
			-- Declared as CURLOPT_FRESH_CONNECT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FRESH_CONNECT;"
		end

	curlopt_forbid_reuse: INTEGER
			-- Declared as CURLOPT_FORBID_REUSE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FORBID_REUSE;"
		end

	curlopt_connecttimeout: INTEGER
			-- Declared as CURLOPT_CONNECTTIMEOUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CONNECTTIMEOUT"
		end

	curlopt_ipresolve: INTEGER
			-- Declared as CURLOPT_IPRESOLVE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_IPRESOLVE;"
		end

	curl_ipresolve_whatever: INTEGER
			-- Declared as CURL_IPRESOLVE_WHATEVER
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_IPRESOLVE_WHATEVER;"
		end

	curl_ipresolve_v4: INTEGER
			-- Declared as CURL_IPRESOLVE_V4
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_IPRESOLVE_V4;"
		end

	curl_ipresolve_v6: INTEGER
			-- Declared as CURL_IPRESOLVE_V6
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_IPRESOLVE_V6;"
		end

	curlopt_connect_only: INTEGER
			-- Declared as CURLOPT_CONNECT_ONLY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CONNECT_ONLY;"
		end

	curlopt_use_ssl: INTEGER
			-- Declared as CURLOPT_USE_SSL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_USE_SSL;"
		end

	curlusessl_none: INTEGER
			-- Declared as CURLUSESSL_NONE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_NONE;"
		end

	curlusessl_try: INTEGER
			-- Declared as CURLUSESSL_TRY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_TRY;"
		end

	curlusessl_control: INTEGER
			-- Declared as CURLUSESSL_CONTROL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_CONTROL;"
		end

	curlusessl_all: INTEGER
			-- Declared as CURLUSESSL_ALL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_ALL;"
		end

feature -- SSL and Security

	curlopt_sslcert: INTEGER
			-- Declared as CURLOPT_SSLCERT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLCERT;"
		end

	curlopt_sslcerttype: INTEGER
			-- Declared as CURLOPT_SSLCERTTYPE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLCERTTYPE;"
		end

	curlopt_sslkey: INTEGER
			-- Declared as CURLOPT_SSLKEY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLKEY;"
		end

	curlopt_sslkeytype: INTEGER
			-- Declared as CURLOPT_SSLKEYTYPE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLKEYTYPE;"
		end

	curlopt_keypasswd: INTEGER
			-- Declared as CURLOPT_KEYPASSWD
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_KEYPASSWD;"
		end

	curlopt_sslengine: INTEGER
			-- Declared as CURLOPT_SSLENGINE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLENGINE;"
		end

	curlopt_sslengine_default: INTEGER
			-- Declared as CURLOPT_SSLENGINE_DEFAULT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLENGINE_DEFAULT;"
		end

	curlopt_sslversion: INTEGER
			-- Declared as CURLOPT_SSLVERSION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLVERSION;"
		end

	curl_sslversion_default: INTEGER
			-- Declared as CURL_SSLVERSION_DEFAULT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_DEFAULT;"
		end

	curl_sslversion_tlsv1: INTEGER
			-- Declared as CURL_SSLVERSION_TLSv1
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_TLSv1;"
		end

	curl_sslversion_sslv2: INTEGER
			-- Declared as CURL_SSLVERSION_SSLv2
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_SSLv2;"
		end

	curl_sslversion_sslv3: INTEGER
			-- Declared as CURL_SSLVERSION_SSLv3
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_SSLv3;"
		end

	curlopt_ssl_verifypeer: INTEGER
			-- Declared as CURLOPT_SSL_VERIFYPEER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_VERIFYPEER;"
		end

	curlopt_cainfo: INTEGER
			-- Declared as CURLOPT_CAINFO
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CAINFO;"
		end

	curlopt_capath: INTEGER
			-- Declared as CURLOPT_CAPATH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CAPATH;"
		end

	curlopt_ssl_verifyhost: INTEGER
			-- Declared as CURLOPT_SSL_VERIFYHOST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_VERIFYHOST;"
		end

	curlopt_random_file: INTEGER
			-- Declared as CURLOPT_RANDOM_FILE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_RANDOM_FILE;"
		end

	curlopt_egdsocket: INTEGER
			-- Declared as CURLOPT_EGDSOCKET
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_EGDSOCKET;"
		end

	curlopt_ssl_cipher_list: INTEGER
			-- Declared as CURLOPT_SSL_CIPHER_LIST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_CIPHER_LIST;"
		end

	curlopt_ssl_sessionid_cache: INTEGER
			-- Declared as CURLOPT_SSL_SESSIONID_CACHE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_SESSIONID_CACHE;"
		end

	curlopt_krblevel: INTEGER
			-- Declared as CURLOPT_KRBLEVEL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_KRBLEVEL;"
		end

feature -- SSH

	curlopt_ssh_auth_types: INTEGER
			-- Declared as CURLOPT_SSH_AUTH_TYPES
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSH_AUTH_TYPES;"
		end

	curlopt_ssh_public_keyfile: INTEGER
			-- Declared as CURLOPT_SSH_PUBLIC_KEYFILE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSH_PUBLIC_KEYFILE;"
		end

	curlopt_ssh_private_keyfile: INTEGER
			-- Declared as CURLOPT_SSH_PRIVATE_KEYFILE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSH_PRIVATE_KEYFILE;"
		end

feature -- Status report

	is_valid (v: INTEGER): BOOLEAN
			-- If `v' value valid?
		do
			Result := 	v = curlopt_verbose	 or
						v = curlopt_header or
						v = curlopt_noprogress or
						v = curlopt_writefunction or
						v = curlopt_writedata or
						v = curlopt_readfunction or
						v = curlopt_readdata or
						v = curlopt_debugfunction or
						v = curlopt_progressfunction or
						v = curlopt_progressdata or
						v = curlopt_writeheader or
						v = curlopt_url or
						v = curlopt_proxy or
						v = curlopt_proxyport or
						v = curlopt_proxytype or
						v = curlopt_httpproxytunnel or
						v = curlopt_interface or
						v = curlopt_localport or
						v = curlopt_localportrange or
						v = curlopt_buffersize or
						v = curlopt_port or
						v = curlopt_tcp_nodelay or
						v = curlopt_userpwd or
						v = curlopt_proxyuserpwd or
						v = curlopt_httpauth or
						v = curlauth_none or
						v = curlauth_basic or
						v = curlauth_digest or
						v = curlauth_any or
						v = curlauth_anysafe or
						v = curlopt_proxyauth or
						v = curlopt_autoreferer or
						v = curlopt_encoding or
						v = curlopt_followlocation or
						v = curlopt_unrestricted_auth or
						v = curlopt_maxredirs or
						v = curlopt_put or
						v = curlopt_post or
						v = curlopt_postfields or
						v = curlopt_postfieldsize or
						v = curlopt_postfieldsize_large or
						v = curlopt_httppost or
						v = curlopt_referer or
						v = curlopt_useragent or
						v = curlopt_httpheader or
						v = curlopt_cookie or
						v = curlopt_cookiefile or
						v = curlopt_cookiejar or
						v = curlopt_cookiesession or
						v = curlopt_cookielist or
						v = curlopt_httpget or
						v = curlopt_http_version or
						v = curlopt_ignore_content_length or
						v = curlopt_http_content_decoding or
						v = curlopt_transfertext or
						v = curlopt_crlf or
						v = curlopt_resume_from or
						v = curlopt_resume_from_large or
						v = curlopt_customrequest or
						v = curlopt_filetime or
						v = curlopt_nobody or
						v = curlopt_infilesize or
						v = curlopt_infilesize_large or
						v = curlopt_upload or
						v = curlopt_maxfilesize or
						v = curlopt_maxfilesize_large or
						v = curlopt_timecondition or
						v = curlopt_timevalue or
						v = curlopt_timeout or
						v = curlopt_timeout_ms or
						v = curlopt_low_speed_limit or
						v = curlopt_low_speed_time or
						v = curlopt_max_send_speed_large or
						v = curlopt_max_recv_speed_large or
						v = curlopt_maxconnects or
						v = curlopt_fresh_connect or
						v = curlopt_forbid_reuse or
						v = curlopt_connecttimeout or
						v = curlopt_ipresolve or
						v = curl_ipresolve_whatever or
						v = curl_ipresolve_v4 or
						v = curl_ipresolve_v6 or
						v = curlopt_connect_only or
						v = curlopt_use_ssl or
						v = curlusessl_none or
						v = curlusessl_try or
						v = curlusessl_control or
						v = curlusessl_all or
						v = curlopt_sslcert or
						v = curlopt_sslcerttype or
						v = curlopt_sslkey or
						v = curlopt_sslkeytype or
						v = curlopt_keypasswd or
						v = curlopt_sslengine or
						v = curlopt_sslengine_default or
						v = curlopt_sslversion or
						v = curl_sslversion_default or
						v = curl_sslversion_tlsv1 or
						v = curl_sslversion_sslv2 or
						v = curl_sslversion_sslv3 or
						v = curlopt_ssl_verifypeer or
						v = curlopt_cainfo or
						v = curlopt_capath or
						v = curlopt_ssl_verifyhost or
						v = curlopt_random_file or
						v = curlopt_egdsocket or
						v = curlopt_ssl_cipher_list or
						v = curlopt_ssl_sessionid_cache or
						v = curlopt_krblevel or
						v = curlopt_ssh_auth_types or
						v = curlopt_ssh_public_keyfile or
						v = curlopt_ssh_private_keyfile
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
