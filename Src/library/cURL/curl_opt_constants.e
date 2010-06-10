note
	description: "[
					libcurl library opt constants
					For more informaton see:
					http://curl.haxx.se/libcurl/c/curl_easy_setopt.html
																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_OPT_CONSTANTS

feature -- Enumerations.

	curlopt_httpheader: INTEGER
			-- Declared as CURLOPT_HTTPHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_HTTPHEADER;
			]"
		end

	curlopt_writedata: INTEGER
			-- Declared as CURLOPT_WRITEDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_WRITEDATA;
			]"
		end

	curlopt_writeheader: INTEGER
			-- Declared as CURLOPT_WRITEHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_WRITEHEADER;
			]"
		end

	curlopt_debugfunction: INTEGER
			-- Declared as CURLOPT_DEBUGFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_DEBUGFUNCTION;
			]"
		end

	curlopt_followlocation: INTEGER
			-- Declared as CURLOPT_FOLLOWLOCATION
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_FOLLOWLOCATION;
			]"
		end

	curlopt_verbose: INTEGER
			-- Declared as CURLOPT_VERBOSE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_VERBOSE;
			]"
		end

	curlopt_useragent: INTEGER
			-- Declared as CURLOPT_USERAGENT.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_USERAGENT;
			]"
		end

	curlopt_userpwd: INTEGER
			-- Declared as CURLOPT_USERPWD.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_USERPWD;
			]"
		end

	curlopt_url: INTEGER
			-- Declared as CURLOPT_URL.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_URL;
			]"
		end

	curlopt_cookiefile: INTEGER
			-- Declared as CURLOPT_COOKIEFILE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_COOKIEFILE;
			]"
		end

	curlopt_cookielist: INTEGER
			-- Declared as CURLOPT_COOKIELIST.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_COOKIELIST
			]"
		end

	curlopt_ssl_verifypeer: INTEGER
			-- Declared as CURLOPT_SSL_VERIFYPEER.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_SSL_VERIFYPEER;
			]"
		end

	curlopt_cookie: INTEGER
			-- Declared as CURLOPT_COOKIE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_COOKIE;
			]"
		end

	curlopt_post: INTEGER
			-- Declared as CURLOPT_POST.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_POST;
			]"
		end

	curlopt_postfields: INTEGER
			-- Declared as CURLOPT_POSTFIELDS.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_POSTFIELDS;
			]"
		end

	curlopt_httppost: INTEGER
			-- Declared as CURLOPT_HTTPPOST.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_HTTPPOST;
			]"
		end

	curlopt_writefunction: INTEGER
			-- Declared as CURLOPT_WRITEFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_WRITEFUNCTION;
			]"
		end

	curlopt_progressfunction: INTEGER
			-- Declared as CURLOPT_PROGRESSFUNCTION
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_PROGRESSFUNCTION;
			]"
		end

	curlopt_noprogress: INTEGER
			-- Declared as CURLOPT_NOPROGRESS
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_NOPROGRESS;
			]"
		end

	curlopt_progressdata: INTEGER
			-- Declared as CURLOPT_PROGRESSDATA
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_PROGRESSDATA;
			]"
		end

	curlopt_referer: INTEGER
			-- Declared as CURLOPT_REFERER
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_REFERER;
			]"
		end

	curlopt_httpget: INTEGER
			-- Declared as CURLOPT_HTTPGET
			-- Pass a long. If the long is non-zero, this forces the HTTP request to get back to GET. usable if a POST, HEAD, PUT or a custom request have been used previously using the same curl handle.
			-- When setting CURLOPT_HTTPGET to a non-zero value, it will automatically set CURLOPT_NOBODY to 0 (since 7.14.1).
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_HTTPGET;
			]"
		end

	curlopt_readfunction: INTEGER
			-- Declared as CURLOPT_READFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_READFUNCTION;
			]"
		end

	curlopt_upload: INTEGER
			-- Declared as CURLOPT_UPLOAD.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_UPLOAD;
			]"
		end

	curlopt_put: INTEGER
			-- Declared as CURLOPT_PUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_PUT;
			]"
		end

	curlopt_readdata: INTEGER
			-- Declared as CURLOPT_READDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_READDATA;
			]"
		end

	curlopt_infilesize_large: INTEGER
			-- Declared as CURLOPT_INFILESIZE_LARGE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_INFILESIZE_LARGE;
			]"
		end

	curlopt_proxy: INTEGER
			-- Declared as CURLOPT_PROXY.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_PROXY;
			]"
		end

	curlopt_encoding: INTEGER
			-- Declared as CURLOPT_ENCODING.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_ENCODING;
			]"
		end

	curlopt_timeout: INTEGER
			-- Declared as CURLOPT_TIMEOUT.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_TIMEOUT
			]"
		end

	curlopt_customrequest: INTEGER
			-- Declared as CURLOPT_CUSTOMREQUEST
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_CUSTOMREQUEST
			]"
		end

	is_valid (a_integer: INTEGER): BOOLEAN
			-- If `a_integer' value valid?
		do
			Result := 	a_integer = curlopt_cookie or
						a_integer = curlopt_cookiefile or
						a_integer = curlopt_cookielist or
						a_integer = curlopt_debugfunction or
						a_integer = curlopt_followlocation or
						a_integer = curlopt_httpheader or
						a_integer = curlopt_httppost or
						a_integer = curlopt_post or
						a_integer = curlopt_postfields or
						a_integer = curlopt_ssl_verifypeer or
						a_integer = curlopt_url or
						a_integer = curlopt_useragent or
						a_integer = curlopt_verbose or
						a_integer = curlopt_writedata or
						a_integer = curlopt_writeheader or
						a_integer = curlopt_writefunction or
						a_integer = curlopt_progressfunction or
						a_integer = curlopt_progressdata or
						a_integer = curlopt_noprogress or
						a_integer = curlopt_referer or
						a_integer = curlopt_httpget or
						a_integer = curlopt_readfunction or
						a_integer = curlopt_upload or
						a_integer = curlopt_put or
						a_integer = curlopt_readdata or
						a_integer = curlopt_infilesize_large or
						a_integer = curlopt_proxy or
						a_integer = curlopt_encoding or
						a_integer = curlopt_timeout or
						a_integer = curlopt_userpwd or
						a_integer = curlopt_customrequest
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
