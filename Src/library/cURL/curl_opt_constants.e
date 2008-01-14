indexing
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

	curlopt_httpheader: INTEGER is
			-- Declared as CURLOPT_HTTPHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_HTTPHEADER;
			]"
		end

	curlopt_writedata: INTEGER is
			-- Declared as CURLOPT_WRITEDATA.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_WRITEDATA;
			]"
		end

	curlopt_writeheader: INTEGER is
			-- Declared as CURLOPT_WRITEHEADER.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_WRITEHEADER;
			]"
		end

	curlopt_debugfunction: INTEGER is
			-- Declared as CURLOPT_DEBUGFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_DEBUGFUNCTION;
			]"
		end

	curlopt_followlocation: INTEGER is
			-- Declared as CURLOPT_FOLLOWLOCATION
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_FOLLOWLOCATION;
			]"
		end

	curlopt_verbose: INTEGER is
			-- Declared as CURLOPT_VERBOSE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_VERBOSE;
			]"
		end

	curlopt_useragent: INTEGER is
			-- Declared as CURLOPT_USERAGENT.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_USERAGENT;
			]"
		end

	curlopt_url: INTEGER is
			-- Declared as CURLOPT_URL.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_URL;
			]"
		end

	curlopt_cookiefile: INTEGER is
			-- Declared as CURLOPT_COOKIEFILE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_COOKIEFILE;
			]"
		end

	curlopt_ssl_verifypeer: INTEGER is
			-- Declared as CURLOPT_SSL_VERIFYPEER.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_SSL_VERIFYPEER;
			]"
		end

	curlopt_cookie: INTEGER is
			-- Declared as CURLOPT_COOKIE.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_COOKIE;
			]"
		end

	curlopt_post: INTEGER is
			-- Declared as CURLOPT_POST.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_POST;
			]"
		end

	curlopt_postfields: INTEGER is
			-- Declared as CURLOPT_POSTFIELDS.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_POSTFIELDS;
			]"
		end

	curlopt_httppost: INTEGER is
			-- Declared as CURLOPT_HTTPPOST.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_HTTPPOST;
			]"
		end

	curlopt_writefunction: INTEGER is
			-- Declared as CURLOPT_WRITEFUNCTION.
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_WRITEFUNCTION;
			]"
		end

	curlopt_progressfunction: INTEGER is
			-- Declared as CURLOPT_PROGRESSFUNCTION
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_PROGRESSFUNCTION;
			]"
		end

	curlopt_noprogress: INTEGER is
			-- Declared as CURLOPT_NOPROGRESS
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_NOPROGRESS;
			]"
		end

	curlopt_progressdata: INTEGER is
			-- Declared as CURLOPT_PROGRESSDATA
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_PROGRESSDATA;
			]"
		end

	curlopt_referer: INTEGER is
			-- Declared as CURLOPT_REFERER
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURLOPT_REFERER;
			]"
		end

	curlopt_httpget: INTEGER is
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

	is_valid (a_integer: INTEGER): BOOLEAN is
			-- If `a_integer' value vaild?
		do
			Result := 	a_integer = curlopt_cookie or
						a_integer = curlopt_cookiefile or
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
						a_integer = curlopt_httpget
		end

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
