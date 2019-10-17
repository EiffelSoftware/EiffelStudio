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

deferred class
	CURL_EASY_EXTERNALS_I

feature -- Status report

	is_api_available: BOOLEAN
			-- Is cURL API available?
		deferred
		end

feature -- Function pointer

	curl_easy_init_ptr: POINTER
		deferred
		end

	curl_easy_setopt_ptr: POINTER
		deferred
		end

	curl_easy_getinfo_ptr: POINTER
		deferred
		end

	curl_easy_cleanup_ptr: POINTER
		deferred
		end

	curl_easy_perform_ptr: POINTER
		deferred
		end

feature -- Command

	init: POINTER
			-- Declared as curl_easy_init().
		require
			is_api_available: is_api_available
		do
			Result := c_init (curl_easy_init_ptr)
		ensure
			exists: not Result.is_default_pointer
		end

	setopt_string (a_curl_handle: POINTER; a_opt: INTEGER; a_string: READABLE_STRING_GENERAL)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_string /= Void
		local
			l_c_str: C_STRING
		do
			create l_c_str.make (a_string)
			c_setopt (curl_easy_setopt_ptr, a_curl_handle, a_opt, l_c_str.item)
		end

	setopt_form (a_curl_handle: POINTER; a_opt: INTEGER; a_form: CURL_FORM)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_form /= Void and then a_form.is_exists
		do
			setopt_void_star (a_curl_handle, a_opt, a_form.item)
		end

	setopt_slist (a_curl_handle: POINTER; a_opt: INTEGER; a_curl_slist: POINTER)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: a_opt = {CURL_OPT_CONSTANTS}.curlopt_httpheader or else a_opt = {CURL_OPT_CONSTANTS}.curlopt_mail_rcpt
			exists: a_curl_slist /= default_pointer
		do
			setopt_void_star (a_curl_handle, a_opt, a_curl_slist)
		end

	setopt_curl_string (a_curl_handle: POINTER; a_opt: INTEGER; a_curl_string: CURL_STRING)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			not_void: a_curl_string /= Void
		do
			c_setopt_int (curl_easy_setopt_ptr, a_curl_handle, a_opt, a_curl_string.object_id)
		end

	setopt_integer (a_curl_handle: POINTER; a_opt: INTEGER; a_integer: INTEGER)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		do
			c_setopt_int (curl_easy_setopt_ptr, a_curl_handle, a_opt, a_integer)
		end

	setopt_file (a_curl_handle: POINTER; a_opt: INTEGER; a_file: FILE)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: a_opt = {CURL_OPT_CONSTANTS}.curlopt_readdata or a_opt = {CURL_OPT_CONSTANTS}.curlopt_headerdata 
			readable: a_file /= Void and then a_file.file_readable
		do
			setopt_void_star (a_curl_handle, a_opt, a_file.file_pointer)
		end

	setopt_mime (a_curl_handle: POINTER; a_opt: INTEGER; a_mime: POINTER)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: a_opt = {CURL_OPT_CONSTANTS}.curlopt_mimepost
			exists: a_mime /= default_pointer
		do
			setopt_void_star (a_curl_handle, a_opt, a_mime)
		end

	perform (a_curl_handle: POINTER): INTEGER
			-- Declared as curl_easy_perform.
			-- Result is one value from {CURL_CODES}
		require
			exists: not a_curl_handle.is_default_pointer
		do
			Result := c_perform (curl_easy_perform_ptr, a_curl_handle)
		end

	cleanup (a_curl_handle: POINTER)
			-- Declared as curl_easy_cleanup.
		require
			exists: not a_curl_handle.is_default_pointer
		do
			c_cleanup (curl_easy_cleanup_ptr, a_curl_handle)
		end

feature -- Query

	getinfo (a_curl_handle: POINTER; a_info: INTEGER; a_data: CELL [detachable ANY]): INTEGER
			-- `curl_getinfo
			--|* Request internal information from the curl session with this function.  The
 			--|* third argument MUST be a pointer to a long, a pointer to a char * or a
 			--|* pointer to a double (as the documentation describes elsewhere).  The data
 			--|* pointed to will be filled in accordingly and can be relied upon only if the
 			--|* function returns CURLE_OK.  This function is intended to get used *AFTER* a
 			--|* performed transfer, all results from this function are undefined until the
 			--|* transfer is completed.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_INFO_CONSTANTS}).is_valid (a_info)
		local
			l_api: POINTER
			mp: detachable MANAGED_POINTER
			l: INTEGER
			cs: C_STRING
			d: REAL_64
		do
			a_data.replace (Void)
			l_api := curl_easy_getinfo_ptr
			if a_info & {CURL_INFO_CONSTANTS}.curlinfo_long /= 0 then
				create mp.make ({PLATFORM}.integer_32_bytes)
			elseif a_info & {CURL_INFO_CONSTANTS}.curlinfo_string /= 0 then
				create mp.make ({PLATFORM}.pointer_bytes)
			elseif a_info & {CURL_INFO_CONSTANTS}.curlinfo_double /= 0 then
				create mp.make ({PLATFORM}.real_64_bytes)
			end
			if mp /= Void then
				Result := c_getinfo (l_api, a_curl_handle, a_info, mp.item)
				if Result = {CURL_CODES}.curle_ok then
					if a_info & {CURL_INFO_CONSTANTS}.curlinfo_long /= 0 then
						l := mp.read_integer_32 (0)
						a_data.put (l)
					elseif a_info & {CURL_INFO_CONSTANTS}.curlinfo_string /= 0 then
						create cs.make_shared_from_pointer (mp.read_pointer (0))
						a_data.put (cs.string)
					elseif a_info & {CURL_INFO_CONSTANTS}.curlinfo_double /= 0 then
						d := mp.read_real_64 (0)
						a_data.put (d)
					end
				end
			end
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
			if attached internal_curl_function as l_curl_function then
				Result := l_curl_function
			else
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
			exists: not a_curl_handle.is_default_pointer
		do
			curl_function.c_set_write_function (curl_easy_setopt_ptr, a_curl_handle)
		end

	set_read_function (a_curl_handle: POINTER)
				-- Set cURL read function
				-- Set cURL read function with Eiffel default read function.
				-- So we can use a c file pointer as parameter in {CURL_EASY_EXTERNALS}.setopt_file_pointer when the option is {CURL_OPT_CONSTANTS}.curlopt_readdata
		require
			exists: not a_curl_handle.is_default_pointer
		do
			curl_function.c_set_read_function (curl_easy_setopt_ptr, a_curl_handle)
		end

	set_progress_function (a_curl_handle: POINTER)
				-- Set cURL progress function for upload/download progress.
		require
			exists: not a_curl_handle.is_default_pointer
		do
			curl_function.c_set_progress_function (curl_easy_setopt_ptr, a_curl_handle)
		end

	set_debug_function (a_curl_handle: POINTER)
				-- Set cURL debug function
		require
			exists: not a_curl_handle.is_default_pointer
		do
			curl_function.c_set_debug_function (curl_easy_setopt_ptr, a_curl_handle)
		end

feature {NONE} -- Implementation

	internal_curl_function: detachable CURL_FUNCTION
			-- cURL functions.

	setopt_void_star (a_curl_handle: POINTER; a_opt: INTEGER; a_data:POINTER)
			-- Declared as curl_easy_setopt.
		require
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		do
			c_setopt (curl_easy_setopt_ptr, a_curl_handle, a_opt, a_data)
		end

feature {NONE} -- C externals

	c_init (a_api: POINTER): POINTER
			-- Declared curl_easy_init .
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURL *, ()) $a_api)();
				#else
						/* Using the proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURL *, ()) $a_api)();
				#endif
			]"
		end

	c_cleanup (a_api: POINTER; a_curl_handle: POINTER)
			-- Decalred as curl_easy_cleanup .
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					(FUNCTION_CAST(void, (CURL *)) $a_api)((CURL *)$a_curl_handle);
				#else
						/* Using proper calling convention for dynamic module */
					(FUNCTION_CAST(void, (CURL *)) $a_api)((CURL *)$a_curl_handle);
				#endif
			]"
		end

	c_perform (a_api: POINTER; a_curl_handle: POINTER): INTEGER
			-- Declared as curl_easy_perform.
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (CURL *)) $a_api)
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (CURL *)) $a_api)
				#endif
											((CURL *) $a_curl_handle);
			]"
		end

	c_setopt_int (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data: INTEGER)
			-- Same as `c_setopt' except we can pass `a_data' as integer.
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_api)
				#else
						/* Using proper calling convention for dynamic module */
					(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_api)
				#endif
											((CURL *) $a_curl_handle,
											(CURLoption)$a_opt,
											$a_data);
			]"
		end

	c_setopt (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data: POINTER)
			-- C implementation of `setopt_void_star'.
			-- Declared as curl_easy_setopt .
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_api)
				#else
						/* Using proper calling convention for dynamic module */
					(FUNCTION_CAST(void, (CURL *, CURLoption, ...)) $a_api)
				#endif
														((CURL *) $a_curl_handle,
														(CURLoption)$a_opt,
														$a_data);
			]"
		end

	c_getinfo (a_api: POINTER; a_curl_handle: POINTER; a_opt: INTEGER; a_data: POINTER): INTEGER
			-- C implementation of `curl_easy_getinfo'.
			-- Declared as curl_easy_setopt .
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (CURL *, CURLINFO info, ...)) $a_api)
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (CURL *, CURLINFO info, ...)) $a_api)
				#endif
											((CURL *) $a_curl_handle,
											(CURLINFO)$a_opt,
											$a_data);
			]"
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
