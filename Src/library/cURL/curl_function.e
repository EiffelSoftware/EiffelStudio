note
	description: "[
						cURL curl_easy_setopt callback functions' Eiffel wrappers.
						We need this class since cURL need a c function pointer as value but
						Eiffel function need frist parameter of any funciton call is object address.
						Client programmers can inherit this class to fit their needs.
																											]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CURL_FUNCTION

inherit
	DISPOSABLE

feature -- Interactive with C

	set_object_and_function_address
			-- Set object and function addresses.
			-- Call this feature before call `c_set_progress_function', `c_set_debug_function' and `c_set_write_function'.
		do
			c_set_object ($Current)
			c_set_progress_function_address ($progress_function)
			c_set_write_function_address ($write_function)
			c_set_debug_function_address ($debug_function)
		end

	c_set_progress_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_PROGRESSFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_setopt_api /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_PROGRESSFUNCTION,
												curl_progress_function);
			}
			]"
		end

	c_set_debug_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_DEBUGFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_DEBUGFUNCTION,
												curl_debug_function);
																													
			}
			]"
		end

	c_set_write_function (a_setopt_api: POINTER; a_curl_handle: POINTER)
				-- Setting CURLOPT_WRITEFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a c function pointer as value.
		require
			exists: a_setopt_api /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_WRITEFUNCTION,
												curl_write_function);
			}
			]"
		end

feature -- cURL curl_easy_setopt functions

	progress_function (a_object_id: POINTER; a_download_total, a_download_now, a_upload_total, a_upload_now: REAL_64): INTEGER
			-- Function correspond to {CURL_OPT_CONSTANTS}.curlopt_progressfunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.
		deferred
		end

	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
			-- Function correspond to {CURL_OPT_CONSTANTS}.curlopt_writefunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.
		deferred
		end

	debug_function (a_curl_handle: POINTER; a_curl_infotype: INTEGER; a_char_pointer: POINTER; a_size: INTEGER; a_object_id: POINTER): INTEGER
			-- Function correspond to {CURL_OPT_CONSTANTS}.curlopt_debugfunction
			-- Note, pass a {IDENTIFIED}.object_id as `a_object_id' value is helpful since we can't directly pass an Eiffel Object address which
			-- may changed during GC.			
		require
			vaild: (create {CURL_INFO_TYPE}).is_valid (a_curl_infotype)
		deferred
		end

feature {NONE} -- Externals

	c_set_object (a_object: POINTER)
			-- Set Current object address.
		external
			"C signature (EIF_REFERENCE) use %"eiffel_curl.h%""
		end

	c_release_object
			-- Release Current pointer in C
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_progress_function_address (a_address: POINTER)
			-- Set progress function address.
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_write_function_address (a_address: POINTER)
			-- Set write function address.
		external
			"C use %"eiffel_curl.h%""
		end

	c_set_debug_function_address (a_address: POINTER)
			-- Set write function address.
		external
			"C use %"eiffel_curl.h%""
		end

feature {NONE} -- Implementation

	dispose
			-- Wean `Current'
		do
			c_release_object
			c_set_object (default_pointer)
		end

note
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
