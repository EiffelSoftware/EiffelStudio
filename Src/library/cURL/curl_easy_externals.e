indexing
	description: "[
					cURL easy externals.
					For more informaton see:
					http://curl.haxx.se/libcurl/c/
																		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_EASY_EXTERNALS

feature -- Command

	init: POINTER is
			-- Declared as curl_easy_init().
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_init")
			if l_api /= default_pointer then
				Result := c_init (l_api)
			end
		ensure
			exists: Result /= default_pointer
		end

	setopt_string (a_curl_handle: POINTER; a_opt: INTEGER; a_string: STRING_GENERAL) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_string /= Void
		local
			l_api: POINTER
			l_c_str: C_STRING
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				create l_c_str.make (a_string)
				c_setopt (l_api, a_curl_handle, a_opt, l_c_str.item)
			end
		end

	setopt_form (a_curl_handle: POINTER; a_opt: INTEGER; a_form: CURL_FORM) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_form /= Void and then a_form.is_exists
		do
			setopt_void_star (a_curl_handle, a_opt, a_form.item)
		end

	setopt_memory_struct (a_curl_handle: POINTER; a_opt: INTEGER; a_memory_struct: CURL_MEMORY_STRUCT) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_memory_struct /= Void
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				c_setopt (l_api, a_curl_handle, a_opt, a_memory_struct.item)
			end
		end

	setopt_integer (a_curl_handle: POINTER; a_opt: INTEGER; a_integer: INTEGER) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				c_setopt_int (l_api, a_curl_handle, a_opt, a_integer)
			end
		end

	perform (a_curl_handle: POINTER): INTEGER is
			-- Declared as curl_easy_perform().
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_perform")
			if l_api /= default_pointer then
				Result := c_perform (l_api, a_curl_handle)
			end
		ensure
			valid:
		end

	cleanup (a_curl_handle: POINTER) is
			-- Declared as curl_easy_cleanup().
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_cleanup")
			if l_api /= default_pointer then
				c_cleanup (l_api, a_curl_handle)
			end
		end

feature -- Special setting

	set_write_function (a_curl_handle: POINTER) is
				-- Set cURL write function
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				c_set_write_function (l_api, a_curl_handle)
			end
		end

	set_debug_function (a_curl_handle: POINTER) is
				-- Set cURL debug function
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				c_debug_function (l_api, a_curl_handle)
			end
		end

feature {NONE} -- Implementation

	api_loader: API_LOADER is
			-- API dynamic loader
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	module_name: STRING is "libcurl.dll"
			-- Module name.

	setopt_void_star (a_curl_handle: POINTER; a_opt: INTEGER; a_data:POINTER) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				c_setopt (l_api, a_curl_handle, a_opt, a_data)
			end
		end

feature {NONE} -- C externals

	c_init (a_api: POINTER): POINTER is
			-- Declared curl_easy_init ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return (FUNCTION_CAST(CURL *, ()) $a_api)();
			]"
		end

	c_cleanup (a_api: POINTER; a_curl_handle: POINTER) is
			-- Decalred as curl_easy_cleanup ().
		require
			exists: a_api /= default_pointer
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				(FUNCTION_CAST(void, (CURL *)) $a_api)((CURL *)$a_curl_handle);
			]"
		end

	c_perform (a_api: POINTER; a_curl_handle: POINTER): INTEGER is
			-- Declared as curl_easy_perform().
		require
			exists: a_api /= default_pointer
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				return (FUNCTION_CAST(CURLcode, (CURL *)) $a_api)
											((CURL *) $a_curl_handle);
			]"
		end

	c_setopt_int (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data: INTEGER) is
			-- Same as `c_setopt' except we can pass `a_data' as integer.
		require
			exists: a_api /= default_pointer
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, CURLoption)) $a_api)
												((CURL *) $a_curl_handle,
												(CURLoption)$a_opt,
												(CURLoption)$a_data);			
			}
			]"
		end

	c_setopt (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data:POINTER) is
			-- C implementation of `setopt_void_star'.
			-- Declared as curl_easy_setopt ().
		require
			exists: a_api /= default_pointer
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, CURLoption)) $a_api)
												((CURL *) $a_curl_handle,
												(CURLoption)$a_opt,
												(CURLoption)$a_data);			
			}
			]"
		end

	c_set_write_function (a_setopt_api: POINTER; a_curl_handle: POINTER) is
				-- Setting CURLOPT_WRITEFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a static c function pointer as value.
		require
			exists: a_setopt_api /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, CURLoption)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_WRITEFUNCTION,
												(CURLoption)WriteMemoryCallback);
			}
			]"
		end

	c_debug_function (a_setopt_api: POINTER; a_curl_handle: POINTER) is
				-- Setting CURLOPT_DEBUGFUNCTION option of `a_curl_handle'.
				-- We need this function since cURL need a static c function pointer as value.
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (CURL *, CURLoption, CURLoption)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_DEBUGFUNCTION,
												(CURLoption)curl_trace);

				(FUNCTION_CAST(void, (CURL *, CURLoption, CURLoption)) $a_setopt_api)
												((CURL *) $a_curl_handle,
												(CURLoption)CURLOPT_VERBOSE,
												(CURLoption)TRUE);																														
			}
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
