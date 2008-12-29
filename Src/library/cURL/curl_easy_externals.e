note
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

	init: POINTER
			-- Declared as curl_easy_init().
		require
			dynamic_library_exists: is_dynamic_library_exists
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

	setopt_string (a_curl_handle: POINTER; a_opt: INTEGER; a_string: STRING_GENERAL)
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

	setopt_form (a_curl_handle: POINTER; a_opt: INTEGER; a_form: CURL_FORM)
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_form /= Void and then a_form.is_exists
		do
			setopt_void_star (a_curl_handle, a_opt, a_form.item)
		end

	setopt_slist (a_curl_handle: POINTER; a_opt: INTEGER; a_curl_slist: POINTER)
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: a_opt = {CURL_OPT_CONSTANTS}.curlopt_httpheader
			exists: a_curl_slist /= default_pointer
		do
			setopt_void_star (a_curl_handle, a_opt, a_curl_slist)
		end

	setopt_curl_string (a_curl_handle: POINTER; a_opt: INTEGER; a_curl_string: CURL_STRING)
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_curl_string /= Void
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				c_setopt_int (l_api, a_curl_handle, a_opt, a_curl_string.object_id)
			end
		end

	setopt_integer (a_curl_handle: POINTER; a_opt: INTEGER; a_integer: INTEGER)
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

	perform (a_curl_handle: POINTER): INTEGER
			-- Declared as curl_easy_perform().
			-- Result is one value from {CURL_CODES}
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

	cleanup (a_curl_handle: POINTER)
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

feature -- Query

	is_dynamic_library_exists: BOOLEAN
			-- If dll/so files exist?
		do
			Result := (api_loader.module_pointer (module_name) /= default_pointer)
		end
		
feature -- Special setting

	set_curl_function (a_curl_function: CURL_FUNCTION)
			-- Set `curl_function' with `a_curl_function'
		do
			internal_curl_function := a_curl_function
		ensure
			set: a_curl_function /= Void implies curl_function = a_curl_function
		end

	curl_function: CURL_FUNCTION
			-- cURL functions in curl_easy_setopt.
		do
			Result := internal_curl_function
			if Result = Void then
				create {CURL_DEFAULT_FUNCTION} Result.make
				internal_curl_function := Result
			end
		ensure
			not_void: Result /= Void
		end

	set_write_function (a_curl_handle: POINTER)
				-- Set cURL write function
				-- Set cURL write function with Eiffel default write function.
				-- So we can use CURL_STRING as parameter in {CURL_EASY_EXTERNALS}.setopt_curl_string when the option is {CURL_OPT_CONSTANTS}.curlopt_writedata
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				curl_function.c_set_write_function (l_api, a_curl_handle)
			end
		end

	set_progress_function (a_curl_handle: POINTER)
				-- Set cURL progress function for upload/download progress.
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				curl_function.c_set_progress_function (l_api, a_curl_handle)
			end
		end

	set_debug_function (a_curl_handle: POINTER)
				-- Set cURL debug function
		require
			exists: a_curl_handle /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_easy_setopt")
			if l_api /= default_pointer then
				curl_function.c_set_debug_function (l_api, a_curl_handle)
			end
		end

feature {NONE} -- Implementation

	internal_curl_function: CURL_FUNCTION
			-- cURL functions.

	api_loader: API_LOADER
			-- API dynamic loader
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	module_name: STRING
			-- Module name.
		local
			l_utility: CURL_UTILITY
		once
			create l_utility
			Result := l_utility.module_name
		end

	setopt_void_star (a_curl_handle: POINTER; a_opt: INTEGER; a_data:POINTER)
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

	c_init (a_api: POINTER): POINTER
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

	c_cleanup (a_api: POINTER; a_curl_handle: POINTER)
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

	c_perform (a_api: POINTER; a_curl_handle: POINTER): INTEGER
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

	c_setopt_int (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data: INTEGER)
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
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_api)
												((CURL *) $a_curl_handle,
												(CURLoption)$a_opt,
												$a_data);			
			}
			]"
		end

	c_setopt (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data: POINTER)
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
				(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_api)
												((CURL *) $a_curl_handle,
												(CURLoption)$a_opt,
												$a_data);			
			}
			]"
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
