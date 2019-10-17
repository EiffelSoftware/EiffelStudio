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
		ensure
			is_class: class
		end

	libcurl_version_major: INTEGER
			-- Declared as LIBCURL_VERSION_MAJOR
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION_MAJOR;"
		ensure
			is_class: class
		end

	libcurl_version_minor: INTEGER
			-- Declared as LIBCURL_VERSION_MINOR
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION_MINOR;"
		ensure
			is_class: class
		end

	libcurl_version_patch: INTEGER
			-- Declared as LIBCURL_VERSION_PATCH
		external
			"C inline use <curl/curlver.h>"
		alias
			"return LIBCURL_VERSION_PATCH;"
		ensure
			is_class: class
		end

feature -- Behavior

	curlopt_verbose: INTEGER
			-- Declared as CURLOPT_VERBOSE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_VERBOSE;"
		ensure
			is_class: class
		end

	curlopt_header: INTEGER
			-- Declared as CURLOPT_HEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HEADER;"
		ensure
			is_class: class
		end

	curlopt_noprogress: INTEGER
			-- Declared as CURLOPT_NOPROGRESS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_NOPROGRESS;"
		ensure
			is_class: class
		end

feature -- Callback

	curlopt_writefunction: INTEGER
			-- Declared as CURLOPT_WRITEFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_WRITEFUNCTION;"
		ensure
			is_class: class
		end

	curlopt_writedata: INTEGER
			-- Declared as CURLOPT_WRITEDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_WRITEDATA;"
		ensure
			is_class: class
		end

	curlopt_readfunction: INTEGER
			-- Declared as CURLOPT_READFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_READFUNCTION;"
		ensure
			is_class: class
		end

	curlopt_readdata: INTEGER
			-- Declared as CURLOPT_READDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_READDATA;"
		ensure
			is_class: class
		end

	curlopt_debugfunction: INTEGER
			-- Declared as CURLOPT_DEBUGFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_DEBUGFUNCTION;"
		ensure
			is_class: class
		end

	curlopt_progressfunction: INTEGER
			-- Declared as CURLOPT_PROGRESSFUNCTION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROGRESSFUNCTION;"
		ensure
			is_class: class
		end

	curlopt_progressdata: INTEGER
			-- Declared as CURLOPT_PROGRESSDATA
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROGRESSDATA;"
		ensure
			is_class: class
		end

	curlopt_writeheader: INTEGER
			-- Declared as CURLOPT_WRITEHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_WRITEHEADER;"
		ensure
			is_class: class
		end

feature -- Network

	curlopt_url: INTEGER
			-- Declared as CURLOPT_URL.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_URL;"
		ensure
			is_class: class
		end

	curlopt_proxy: INTEGER
			-- Declared as CURLOPT_PROXY.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXY;"
		ensure
			is_class: class
		end

	curlopt_proxyport: INTEGER
			-- Declared as CURLOPT_PROXYPORT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYPORT;"
		ensure
			is_class: class
		end

	curlopt_proxytype: INTEGER
			-- Declared as CURLOPT_PROXYTYPE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYTYPE;"
		ensure
			is_class: class
		end

	curlopt_httpproxytunnel: INTEGER
			-- Declared as CURLOPT_HTTPPROXYTUNNEL.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPPROXYTUNNEL;"
		ensure
			is_class: class
		end

	curlopt_interface: INTEGER
			-- Declared as CURLOPT_INTERFACE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_INTERFACE;"
		ensure
			is_class: class
		end

	curlopt_localport: INTEGER
			-- Declared as CURLOPT_LOCALPORT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOCALPORT;"
		ensure
			is_class: class
		end

	curlopt_localportrange: INTEGER
			-- Declared as CURLOPT_LOCALPORTRANGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOCALPORTRANGE;"
		ensure
			is_class: class
		end

	curlopt_buffersize: INTEGER
			-- Declared as CURLOPT_BUFFERSIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_BUFFERSIZE"
		ensure
			is_class: class
		end

	curlopt_port: INTEGER
			-- Declared as CURLOPT_PORT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PORT;"
		ensure
			is_class: class
		end

	curlopt_tcp_nodelay: INTEGER
			-- Declared as CURLOPT_TCP_NODELAY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TCP_NODELAY;"
		ensure
			is_class: class
		end

	curlopt_nosignal: INTEGER
			-- Declared as CURLOPT_NOSIGNAL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_NOSIGNAL;"
		ensure
			is_class: class
		end

feature -- Names and Passwords (Authentication)

	curlopt_userpwd: INTEGER
			-- Declared as CURLOPT_USERPWD.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_USERPWD;"
		ensure
			is_class: class
		end

	curlopt_proxyuserpwd: INTEGER
			-- Declared as CURLOPT_PROXYUSERPWD
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYUSERPWD;"
		ensure
			is_class: class
		end

	curlopt_httpauth: INTEGER
			-- Declared as CURLOPT_HTTPAUTH.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPAUTH;"
		ensure
			is_class: class
		end

	curlauth_none: INTEGER
			-- Declared as CURLAUTH_NONE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_NONE;"
		ensure
			is_class: class
		end

	curlauth_basic: INTEGER
			-- Declared as CURLAUTH_BASIC.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_BASIC;"
		ensure
			is_class: class
		end

	curlauth_digest: INTEGER
			-- Declared as CURLAUTH_DIGEST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_DIGEST;"
		ensure
			is_class: class
		end

	curlauth_any: INTEGER
			-- Declared as CURLAUTH_ANY.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_ANY;"
		ensure
			is_class: class
		end

	curlauth_anysafe: INTEGER
			-- Declared as CURLAUTH_ANYSAFE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLAUTH_ANYSAFE;"
		ensure
			is_class: class
		end

	curlopt_proxyauth: INTEGER
			-- Declared as CURLOPT_PROXYAUTH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PROXYAUTH;"
		ensure
			is_class: class
		end

	curlopt_tcp_keepalive: INTEGER
			-- Declared as CURLOPT_TCP_KEEPALIVE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TCP_KEEPALIVE;"
		ensure
			is_class: class
		end

feature -- HTTP

	curlopt_autoreferer: INTEGER
			-- Declared as CURLOPT_AUTOREFERER
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_AUTOREFERER;"
		ensure
			is_class: class
		end

	curlopt_encoding: INTEGER
			-- Declared as CURLOPT_ENCODING.
			-- in future version, this is called CURLOPT_ACCEPT_ENCODING
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_ENCODING;"
		ensure
			is_class: class
		end

	curlopt_followlocation: INTEGER
			-- Declared as CURLOPT_FOLLOWLOCATION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FOLLOWLOCATION;"
		ensure
			is_class: class
		end

	curlopt_unrestricted_auth: INTEGER
			-- Declared as CURLOPT_UNRESTRICTED_AUTH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_UNRESTRICTED_AUTH;"
		ensure
			is_class: class
		end

	curlopt_maxredirs: INTEGER
			-- Declared as CURLOPT_MAXREDIRS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXREDIRS;"
		ensure
			is_class: class
		end

	curlopt_put: INTEGER
			-- Declared as CURLOPT_PUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_PUT;"
		ensure
			is_class: class
		end

	curlopt_post: INTEGER
			-- Declared as CURLOPT_POST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POST;"
		ensure
			is_class: class
		end

	curlopt_postfields: INTEGER
			-- Declared as CURLOPT_POSTFIELDS.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POSTFIELDS;"
		ensure
			is_class: class
		end

	curlopt_postfieldsize: INTEGER
			-- Declared as CURLOPT_POSTFIELDSIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POSTFIELDSIZE;"
		ensure
			is_class: class
		end

	curlopt_postfieldsize_large: INTEGER
			-- Declared as CURLOPT_POSTFIELDSIZE_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_POSTFIELDSIZE_LARGE;"
		ensure
			is_class: class
		end

	curlopt_httppost: INTEGER
			-- Declared as CURLOPT_HTTPPOST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPPOST;"
		ensure
			is_class: class
		end

	curlopt_referer: INTEGER
			-- Declared as CURLOPT_REFERER
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_REFERER;"
		ensure
			is_class: class
		end

	curlopt_useragent: INTEGER
			-- Declared as CURLOPT_USERAGENT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_USERAGENT;"
		ensure
			is_class: class
		end

	curlopt_httpheader: INTEGER
			-- Declared as CURLOPT_HTTPHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPHEADER;"
		ensure
			is_class: class
		end

	curlopt_cookie: INTEGER
			-- Declared as CURLOPT_COOKIE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIE;"
		ensure
			is_class: class
		end

	curlopt_cookiefile: INTEGER
			-- Declared as CURLOPT_COOKIEFILE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIEFILE;"
		ensure
			is_class: class
		end

	curlopt_cookiejar: INTEGER
			-- Declared as CURLOPT_COOKIEJAR
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIEJAR;"
		ensure
			is_class: class
		end

	curlopt_cookiesession: INTEGER
			-- Declared as CURLOPT_COOKIESESSION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIESESSION;"
		ensure
			is_class: class
		end

	curlopt_cookielist: INTEGER
			-- Declared as CURLOPT_COOKIELIST.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_COOKIELIST"
		ensure
			is_class: class
		end

	curlopt_httpget: INTEGER
			-- Declared as CURLOPT_HTTPGET
			-- Pass a long. If the long is non-zero, this forces the HTTP request to get back to GET. usable if a POST, HEAD, PUT or a custom request have been used previously using the same curl handle.
			-- When setting CURLOPT_HTTPGET to a non-zero value, it will automatically set CURLOPT_NOBODY to 0 (since 7.14.1).
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTPGET;"
		ensure
			is_class: class
		end

	curlopt_http_version: INTEGER
			-- Declared as CURLOPT_HTTP_VERSION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTP_VERSION;"
		ensure
			is_class: class
		end

	curl_http_version_none: INTEGER
			-- Value used for CURL_HTTP_VERSION.
			-- Let the library to choose the best possible.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_HTTP_VERSION_NONE"
		ensure
			is_class: class
		end

	curl_http_version_1_0: INTEGER
			-- Value used for CURL_HTTP_VERSION.
			-- Use CURL_HTTP_VERSION_1_0
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_HTTP_VERSION_1_0"
		ensure
			is_class: class
		end

	curl_http_version_1_1: INTEGER
			-- Value used for CURL_HTTP_VERSION.
			-- Use CURL_HTTP_VERSION_1_1
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_HTTP_VERSION_1_1"
		ensure
			is_class: class
		end

	curlopt_ignore_content_length: INTEGER
			-- Declared as CURLOPT_IGNORE_CONTENT_LENGTH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_IGNORE_CONTENT_LENGTH;"
		ensure
			is_class: class
		end

	curlopt_http_content_decoding: INTEGER
			-- Declared as CURLOPT_HTTP_CONTENT_DECODING
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HTTP_CONTENT_DECODING;"
		ensure
			is_class: class
		end

feature -- Protocol

	curlopt_transfertext: INTEGER
			-- Declared as CURLOPT_TRANSFERTEXT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TRANSFERTEXT;"
		ensure
			is_class: class
		end

	curlopt_crlf: INTEGER
			-- Declared as CURLOPT_CRLF
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CRLF;"
		ensure
			is_class: class
		end

	curlopt_resume_from: INTEGER
			-- Declared as CURLOPT_RESUME_FROM
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_RESUME_FROM;"
		ensure
			is_class: class
		end

	curlopt_resume_from_large: INTEGER
			-- Declared as CURLOPT_RESUME_FROM_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_RESUME_FROM_LARGE;"
		ensure
			is_class: class
		end

	curlopt_customrequest: INTEGER
			-- Declared as CURLOPT_CUSTOMREQUEST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CUSTOMREQUEST"
		ensure
			is_class: class
		end

	curlopt_filetime: INTEGER
			-- Declared as CURLOPT_FILETIME
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FILETIME;"
		ensure
			is_class: class
		end

	curlopt_nobody: INTEGER
			-- Declared as CURLOPT_NOBODY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_NOBODY;"
		ensure
			is_class: class
		end

	curlopt_infilesize: INTEGER
			-- Declared as CURLOPT_INFILESIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_INFILESIZE;"
		ensure
			is_class: class
		end

	curlopt_infilesize_large: INTEGER
			-- Declared as CURLOPT_INFILESIZE_LARGE.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_INFILESIZE_LARGE;"
		ensure
			is_class: class
		end

	curlopt_upload: INTEGER
			-- Declared as CURLOPT_UPLOAD.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_UPLOAD;"
		ensure
			is_class: class
		end

	curlopt_maxfilesize: INTEGER
			-- Declared as CURLOPT_MAXFILESIZE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXFILESIZE;"
		ensure
			is_class: class
		end

	curlopt_maxfilesize_large: INTEGER
			-- Declared as CURLOPT_MAXFILESIZE_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXFILESIZE_LARGE;"
		ensure
			is_class: class
		end

	curlopt_timecondition: INTEGER
			-- Declared as CURLOPT_TIMECONDITION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMECONDITION;"
		ensure
			is_class: class
		end

	curlopt_timevalue: INTEGER
			-- Declared as CURLOPT_TIMEVALUE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMEVALUE;"
		ensure
			is_class: class
		end

	curlopt_mimepost: INTEGER
			-- Declared as CURLOPT_MIMEPOST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MIMEPOST;"
		ensure
			is_class: class
		end

	curlopt_headerdata: INTEGER
			-- Declared as CURLOPT_HEADERDATA
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_HEADERDATA;"
		ensure
			is_class: class
		end

feature -- Connection

	curlopt_timeout: INTEGER
			-- Declared as CURLOPT_TIMEOUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMEOUT"
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

	curlopt_timeout_ms: INTEGER
			-- Declared as CURLOPT_TIMEOUT_MS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_TIMEOUT_MS;"
		ensure
			is_class: class
		end

	curlopt_low_speed_limit: INTEGER
			-- Declared as CURLOPT_LOW_SPEED_LIMIT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOW_SPEED_LIMIT;"
		ensure
			is_class: class
		end

	curlopt_low_speed_time: INTEGER
			-- Declared as CURLOPT_LOW_SPEED_TIME
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_LOW_SPEED_TIME;"
		ensure
			is_class: class
		end

	curlopt_max_send_speed_large: INTEGER
			-- Declared as CURLOPT_MAX_SEND_SPEED_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAX_SEND_SPEED_LARGE;"
		ensure
			is_class: class
		end

	curlopt_max_recv_speed_large: INTEGER
			-- Declared as CURLOPT_MAX_RECV_SPEED_LARGE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAX_RECV_SPEED_LARGE;"
		ensure
			is_class: class
		end

	curlopt_maxconnects: INTEGER
			-- Declared as CURLOPT_MAXCONNECTS
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAXCONNECTS;"
		ensure
			is_class: class
		end

	curlopt_fresh_connect: INTEGER
			-- Declared as CURLOPT_FRESH_CONNECT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FRESH_CONNECT;"
		ensure
			is_class: class
		end

	curlopt_forbid_reuse: INTEGER
			-- Declared as CURLOPT_FORBID_REUSE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_FORBID_REUSE;"
		ensure
			is_class: class
		end

	curlopt_connecttimeout: INTEGER
			-- Declared as CURLOPT_CONNECTTIMEOUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CONNECTTIMEOUT"
		ensure
			is_class: class
		end

	curlopt_ipresolve: INTEGER
			-- Declared as CURLOPT_IPRESOLVE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_IPRESOLVE;"
		ensure
			is_class: class
		end

	curl_ipresolve_whatever: INTEGER
			-- Declared as CURL_IPRESOLVE_WHATEVER
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_IPRESOLVE_WHATEVER;"
		ensure
			is_class: class
		end

	curl_ipresolve_v4: INTEGER
			-- Declared as CURL_IPRESOLVE_V4
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_IPRESOLVE_V4;"
		ensure
			is_class: class
		end

	curl_ipresolve_v6: INTEGER
			-- Declared as CURL_IPRESOLVE_V6
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_IPRESOLVE_V6;"
		ensure
			is_class: class
		end

	curlopt_connect_only: INTEGER
			-- Declared as CURLOPT_CONNECT_ONLY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CONNECT_ONLY;"
		ensure
			is_class: class
		end

	curlopt_use_ssl: INTEGER
			-- Declared as CURLOPT_USE_SSL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_USE_SSL;"
		ensure
			is_class: class
		end

	curlusessl_none: INTEGER
			-- Declared as CURLUSESSL_NONE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_NONE;"
		ensure
			is_class: class
		end

	curlusessl_try: INTEGER
			-- Declared as CURLUSESSL_TRY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_TRY;"
		ensure
			is_class: class
		end

	curlusessl_control: INTEGER
			-- Declared as CURLUSESSL_CONTROL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_CONTROL;"
		ensure
			is_class: class
		end

	curlusessl_all: INTEGER
			-- Declared as CURLUSESSL_ALL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLUSESSL_ALL;"
		ensure
			is_class: class
		end

feature -- SSL and Security

	curlopt_sslcert: INTEGER
			-- Declared as CURLOPT_SSLCERT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLCERT;"
		ensure
			is_class: class
		end

	curlopt_sslcerttype: INTEGER
			-- Declared as CURLOPT_SSLCERTTYPE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLCERTTYPE;"
		ensure
			is_class: class
		end

	curlopt_sslkey: INTEGER
			-- Declared as CURLOPT_SSLKEY
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLKEY;"
		ensure
			is_class: class
		end

	curlopt_sslkeytype: INTEGER
			-- Declared as CURLOPT_SSLKEYTYPE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLKEYTYPE;"
		ensure
			is_class: class
		end

	curlopt_keypasswd: INTEGER
			-- Declared as CURLOPT_KEYPASSWD
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_KEYPASSWD;"
		ensure
			is_class: class
		end

	curlopt_sslengine: INTEGER
			-- Declared as CURLOPT_SSLENGINE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLENGINE;"
		ensure
			is_class: class
		end

	curlopt_sslengine_default: INTEGER
			-- Declared as CURLOPT_SSLENGINE_DEFAULT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLENGINE_DEFAULT;"
		ensure
			is_class: class
		end

	curlopt_sslversion: INTEGER
			-- Declared as CURLOPT_SSLVERSION
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSLVERSION;"
		ensure
			is_class: class
		end

	curl_sslversion_default: INTEGER
			-- Declared as CURL_SSLVERSION_DEFAULT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_DEFAULT;"
		ensure
			is_class: class
		end

	curl_sslversion_tlsv1: INTEGER
			-- Declared as CURL_SSLVERSION_TLSv1
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_TLSv1;"
		ensure
			is_class: class
		end

	curl_sslversion_tlsv1_2: INTEGER
			-- Declared as CURL_SSLVERSION_MAX_TLSv1_2
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_MAX_TLSv1_2;"
		ensure
			is_class: class
		end

	curl_sslversion_tlsv1_3: INTEGER
			-- Declared as CURL_SSLVERSION_TLSv1_3
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_TLSv1_3;"
		ensure
			is_class: class
		end

	curl_sslversion_sslv2: INTEGER
			-- Declared as CURL_SSLVERSION_SSLv2
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_SSLv2;"
		ensure
			is_class: class
		end

	curl_sslversion_sslv3: INTEGER
			-- Declared as CURL_SSLVERSION_SSLv3
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_SSLVERSION_SSLv3;"
		ensure
			is_class: class
		end

	curlopt_ssl_verifypeer: INTEGER
			-- Declared as CURLOPT_SSL_VERIFYPEER.
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_VERIFYPEER;"
		ensure
			is_class: class
		end

	curlopt_cainfo: INTEGER
			-- Declared as CURLOPT_CAINFO
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CAINFO;"
		ensure
			is_class: class
		end

	curlopt_capath: INTEGER
			-- Declared as CURLOPT_CAPATH
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_CAPATH;"
		ensure
			is_class: class
		end

	curlopt_ssl_verifyhost: INTEGER
			-- Declared as CURLOPT_SSL_VERIFYHOST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_VERIFYHOST;"
		ensure
			is_class: class
		end

	curlopt_random_file: INTEGER
			-- Declared as CURLOPT_RANDOM_FILE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_RANDOM_FILE;"
		ensure
			is_class: class
		end

	curlopt_egdsocket: INTEGER
			-- Declared as CURLOPT_EGDSOCKET
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_EGDSOCKET;"
		ensure
			is_class: class
		end

	curlopt_ssl_cipher_list: INTEGER
			-- Declared as CURLOPT_SSL_CIPHER_LIST
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_CIPHER_LIST;"
		ensure
			is_class: class
		end

	curlopt_ssl_sessionid_cache: INTEGER
			-- Declared as CURLOPT_SSL_SESSIONID_CACHE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSL_SESSIONID_CACHE;"
		ensure
			is_class: class
		end

	curlopt_krblevel: INTEGER
			-- Declared as CURLOPT_KRBLEVEL
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_KRBLEVEL;"
		ensure
			is_class: class
		end

feature -- SSH

	curlopt_ssh_auth_types: INTEGER
			-- Declared as CURLOPT_SSH_AUTH_TYPES
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSH_AUTH_TYPES;"
		ensure
			is_class: class
		end

	curlopt_ssh_public_keyfile: INTEGER
			-- Declared as CURLOPT_SSH_PUBLIC_KEYFILE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSH_PUBLIC_KEYFILE;"
		ensure
			is_class: class
		end

	curlopt_ssh_private_keyfile: INTEGER
			-- Declared as CURLOPT_SSH_PRIVATE_KEYFILE
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_SSH_PRIVATE_KEYFILE;"
		ensure
			is_class: class
		end

	curlopt_mail_from: INTEGER
			-- Declared as CURLOPT_MAIL_FROM
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAIL_FROM;"
		ensure
			is_class: class
		end

	curlopt_mail_rcpt: INTEGER
			-- Declared as CURLOPT_MAIL_RCPT
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURLOPT_MAIL_RCPT;"
		ensure
			is_class: class
		end

	curl_zero_terminated: INTEGER
			-- Declared as CURL_ZERO_TERMINATED
		external
			"C inline use <curl/curl.h>"
		alias
			"return CURL_ZERO_TERMINATED;"
		ensure
			is_class: class
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
						v = curlopt_ssh_private_keyfile or
						v = curlopt_mail_from or
						v = curlopt_mail_rcpt or
						v = curl_zero_terminated or
						v = curl_sslversion_tlsv1_2 or
						v = curl_sslversion_tlsv1_3 or
						v = curlopt_headerdata or
						v = curlopt_tcp_keepalive
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
