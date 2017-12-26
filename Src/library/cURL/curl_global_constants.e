note
	description: "cURL library constants used by curl_global_init ()"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_GLOBAL_CONSTANTS

feature -- Query

	curl_global_ssl: NATURAL_64
			-- Delcared as CURL_GLOBAL_SSL
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_SSL;
			]"
		ensure
			is_class: class
		end

	curl_global_win32: NATURAL_64
			-- Delcared as CURL_GLOBAL_WIN32
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_WIN32;
			]"
		ensure
			is_class: class
		end

	curl_global_all: NATURAL_64
			-- Delcared as CURL_GLOBAL_ALL
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_ALL;
			]"
		ensure
			is_class: class
		end

	curl_global_nothing: NATURAL_64
			-- Delcared as CURL_GLOBAL_NOTHING
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_NOTHING;
			]"
		ensure
			is_class: class
		end

	curl_global_default: NATURAL_64
			-- Delcared as CURL_GLOBAL_DEFAULT
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return CURL_GLOBAL_DEFAULT;
			]"
		ensure
			is_class: class
		end

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
