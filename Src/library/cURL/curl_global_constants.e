indexing
	description: "[
					cURL library constants used by curl_global_init () 
																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_GLOBAL_CONSTANTS

feature -- Query

	curl_global_ssl: NATURAL_64 is
			-- Delcared as CURL_GLOBAL_SSL
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_SSL;
			]"
		end

	curl_global_win32: NATURAL_64 is
			-- Delcared as CURL_GLOBAL_WIN32
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_WIN32;
			]"
		end

	curl_global_all: NATURAL_64 is
			-- Delcared as CURL_GLOBAL_ALL
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_ALL;
			]"
		end

	curl_global_nothing: NATURAL_64 is
			-- Delcared as CURL_GLOBAL_NOTHING
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_NOTHING;
			]"
		end

	curl_global_default: NATURAL_64 is
			-- Delcared as CURL_GLOBAL_DEFAULT
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_DEFAULT;
			]"
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

