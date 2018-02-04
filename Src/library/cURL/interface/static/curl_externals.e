note
	description: "[
					cURL externals.
					For more information, see:
					http://curl.haxx.se/libcurl/c/
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_EXTERNALS

inherit
	CURL_EXTERNALS_I

feature -- Status report

	is_api_available: BOOLEAN
		do
			Result := {CURL_UTILITY}.is_static
		end

	is_dynamic_library_exists: BOOLEAN
		obsolete
			"Use is_api_available [2018-01-15]"
		do
			Result := False
		end

feature -- Function pointer

	curl_global_init_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_global_init"
		end

	curl_global_cleanup_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_global_cleanup"
		end

	curl_slist_append_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_slist_append"
		end

	curl_slist_free_all_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_slist_free_all"
		end

	curl_easy_strerror_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_easy_strerror"
		end

	curl_formfree_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_formfree"
		end

	curl_formadd_ptr: POINTER
		external
			"C inline use <curl/curl.h>"
		alias
			"&curl_formadd"
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
