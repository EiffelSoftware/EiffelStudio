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

deferred class
	CURL_EXTERNALS_I

feature -- Status report

	is_api_available: BOOLEAN
			-- Is cURL API available?
		deferred
		end

feature -- Function pointer

	curl_global_init_ptr: POINTER
		deferred
		end

	curl_global_cleanup_ptr: POINTER
		deferred
		end

	curl_slist_append_ptr: POINTER
		deferred
		end

	curl_slist_free_all_ptr: POINTER
		deferred
		end

	curl_easy_strerror_ptr: POINTER
		deferred
		end

	curl_formfree_ptr: POINTER
		deferred
		end

	curl_formadd_ptr: POINTER
		deferred
		end

	curl_mime_init_ptr: POINTER
		deferred
		end

	curl_mime_addpart_ptr: POINTER
		deferred
		end

	curl_mime_data_ptr: POINTER
		deferred
		end

	curl_mime_type_ptr: POINTER
		deferred
		end

	curl_mime_subparts_ptr: POINTER
		deferred
		end

	curl_mime_headers_ptr: POINTER
		deferred
		end

	curl_mime_filedata_ptr: POINTER
		deferred
		end

	curl_mime_free_ptr: POINTER
		deferred
		end

feature -- Command

	global_init
			-- Declared as curl_global_init().
		do
			c_curl_global_init (curl_global_init_ptr, {CURL_GLOBAL_CONSTANTS}.curl_global_all);
		end

	global_cleanup
			-- Declared as curl_global_cleanup().
		do
			c_curl_global_cleanup (curl_global_cleanup_ptr)
		end

	formadd_string_string (a_form: CURL_FORM; a_last_pointer: CURL_FORM; a_arg_1: INTEGER; a_arg_1_value: READABLE_STRING_GENERAL; a_arg_2: INTEGER; a_arg_2_value: READABLE_STRING_GENERAL; a_arg_3: INTEGER)
			-- Declared as curl_formadd ().
		require
			not_void: a_form /= Void
			not_void: a_last_pointer /= Void
			valid: (create {CURL_FORM_CONSTANTS}).is_valid (a_arg_1)
			not_void: a_arg_1_value /= Void
			valid: (create {CURL_FORM_CONSTANTS}).is_valid (a_arg_2)
			not_void: a_arg_2_value /= Void
			valid: (create {CURL_FORM_CONSTANTS}).is_valid (a_arg_3)
		local
			l_form_pointer, l_last_pointer: POINTER
		do
			l_form_pointer := a_form.item
			l_last_pointer := a_last_pointer.item

			internal_formadd_string_string ($l_form_pointer, $l_last_pointer, a_arg_1, a_arg_1_value, a_arg_2, a_arg_2_value, a_arg_3)

			if a_form.item /= l_form_pointer then
				check not_set: a_form.item = default_pointer end
				a_form.set_item (l_form_pointer)
			end
			if a_last_pointer.item /= l_last_pointer then
				a_last_pointer.set_item (l_last_pointer)
			end
		end

	slist_append (a_list: POINTER; a_string: READABLE_STRING_GENERAL): POINTER
			-- Declared as curl_slist_append ().
			-- note: call with a null `a_list' to get initialized pointer as Result
		require
			not_void: a_string /= Void
		local
			l_c_string: C_STRING
		do
			create l_c_string.make (a_string)
			Result := c_slist_append (curl_slist_append_ptr, a_list, l_c_string.item)
		end

	slist_free_all (a_curl_slist: POINTER)
			-- Declared as curl_slist_free_all ().
			-- See: http://curl.haxx.se/libcurl/c/curl_slist_free_all.html
			-- curl_slist_free_all - free an entire curl_slist list
			-- This must be called when the data has been used, which typically means after the curl_easy_perform(3) has been called.
		require
			exists: a_curl_slist /= default_pointer
		do
			c_slist_free_all (curl_slist_free_all_ptr, a_curl_slist)
		end

	error_message (a_code: INTEGER): READABLE_STRING_32
			-- error message given the code 'a_code' if any or return
			-- an Unknown error.
		local
			l_cstring: C_STRING
			l_pointer: POINTER
		do
			create {STRING_32} Result.make_from_string ("Unknown Error")
			l_pointer := c_curl_easy_strerror (curl_easy_strerror_ptr, a_code)
			if not l_pointer.is_default_pointer then
				create l_cstring.make_by_pointer (l_pointer)
				create {STRING_32} Result.make_from_string (l_cstring.string)
			end
		end

feature -- MIME

	curl_mime_init (a_curl_handle: POINTER): POINTER
		require
			exists: not a_curl_handle.is_default_pointer
		do
			Result := c_mime_init (curl_mime_init_ptr, a_curl_handle)
		end

	curl_mime_addpart (a_curl_mime: POINTER): POINTER
		require
			exists: not a_curl_mime.is_default_pointer
		do
			Result := c_mime_addpart (curl_mime_addpart_ptr, a_curl_mime)
		end

	curl_mime_data (a_curl_mime: POINTER; a_inline_html: READABLE_STRING_8; a_size: INTEGER): INTEGER
	 	require
	 		exists: not a_curl_mime.is_default_pointer
	 	local
	 		l_cstring: C_STRING
	 	do
	 		create l_cstring.make (a_inline_html)
			Result := c_mime_data (curl_mime_data_ptr, a_curl_mime, l_cstring.item, a_size)
	 	end

	curl_mime_type (a_curl_mime: POINTER; a_type: READABLE_STRING_8): INTEGER
	 	require
	 		exists: not a_curl_mime.is_default_pointer
	 	local
	 		l_cstring: C_STRING
	 	do
			create l_cstring.make (a_type)
			Result := c_mime_type (curl_mime_type_ptr, a_curl_mime, l_cstring.item)
	 	end

	curl_mime_subparts (a_curl_mime_part: POINTER; a_subpart: POINTER): INTEGER
	 	require
	 		exists_mime_part: not a_curl_mime_part.is_default_pointer
	 		exists_subpart: not a_subpart.is_default_pointer
	 	do
	 		Result := c_mime_subparts (curl_mime_subparts_ptr, a_curl_mime_part, a_subpart)
	 	end

	 curl_mime_headers (a_mime_part: POINTER; a_headers: POINTER; a_take_ownership: INTEGER): INTEGER
	 	require
	 		exists_mime_part: not a_mime_part.is_default_pointer
	 		exists_headers: not a_headers.is_default_pointer
	 	do
	 		Result := c_mime_headers (curl_mime_headers_ptr,a_mime_part, a_headers, a_take_ownership)
	 	end

	 curl_mime_filedata (a_mime_part: POINTER; a_filename: READABLE_STRING_8): INTEGER
	 	require
	 		exists_mime_part: not a_mime_part.is_default_pointer
	 	local
	 		l_cstring: C_STRING
	 	do
	 		create l_cstring.make (a_filename)
	 		Result := c_mime_filedata (curl_mime_filedata_ptr, a_mime_part, l_cstring.item)
	 	end

	 curl_mime_free (a_mime: POINTER)
	 	require
	 		exist_mime: not a_mime.is_default_pointer
	 	do
	 		c_mime_free (curl_mime_free_ptr, a_mime)
	 	end

feature {CURL_FORM} -- Internal command

	formfree (a_curl_form: POINTER)
			-- Declared as curl_formfree ().
			-- See: http://curl.askapache.com/libcurl/c/curl_formfree.html
			-- curl_formfree() is used to clean up data previously built/appended with curl_formadd(3).
			-- This must be called when the data has been used, which typically means after the curl_easy_perform(3) has been called.
		require
			exists: not a_curl_form.is_default_pointer
		do
			c_formfree (curl_formfree_ptr, a_curl_form)
		end

feature {NONE} -- Implementation

	internal_formadd_string_string (a_form: TYPED_POINTER [POINTER]; a_last_pointer: TYPED_POINTER [POINTER]; a_arg_1: INTEGER; a_arg_1_value: READABLE_STRING_GENERAL; a_arg_2: INTEGER; a_arg_2_value: READABLE_STRING_GENERAL; a_arg_3: INTEGER)
			-- Declared as curl_formadd ().
		local
			l_c_string_1, l_c_string_2: C_STRING
		do
			create l_c_string_1.make (a_arg_1_value)
			create l_c_string_2.make (a_arg_2_value)
			c_formadd_string_string (curl_formadd_ptr, a_form, a_last_pointer, a_arg_1, l_c_string_1.item, a_arg_2, l_c_string_2.item, a_arg_3)
		end

feature {NONE} -- C externals

	c_formadd_string_string (a_api: POINTER; a_form: TYPED_POINTER [POINTER]; a_last_pointer: TYPED_POINTER [POINTER]; a_arg_1: INTEGER; a_arg_1_value: POINTER; a_arg_2: INTEGER; a_arg_2_value: POINTER; a_arg_3: INTEGER)
			-- C implementation of formadd_string_string ().
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					(FUNCTION_CAST(void, (struct curl_httppost **, struct curl_httppost **, int, char *, int, char *, int)) $a_api)
											((struct curl_httppost **)$a_form,
											(struct curl_httppost **)$a_last_pointer,
											(int)$a_arg_1,
											(char *)$a_arg_1_value,
											(int)$a_arg_2,
											(char *)$a_arg_2_value,
											(int)$a_arg_3);
				#else
						/* Using the proper calling convention for dynamic module */
					(FUNCTION_CAST(void, (struct curl_httppost **, struct curl_httppost **, int, char *, int, char *, int)) $a_api)
														((struct curl_httppost **)$a_form,
														(struct curl_httppost **)$a_last_pointer,
														(int)$a_arg_1,
														(char *)$a_arg_1_value,
														(int)$a_arg_2,
														(char *)$a_arg_2_value,
														(int)$a_arg_3);
			 	#endif
			]"
		end

	c_formfree (a_api: POINTER; a_curl_form: POINTER)
			-- Declared as curl_formfree ().
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_form.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					(FUNCTION_CAST(void, (struct curl_httppost *)) $a_api)
											((struct curl_httppost *) $a_curl_form);
				#else
						/* Using the proper calling convention for dynamic module */
					(FUNCTION_CAST(void, (struct curl_httppost *)) $a_api)
											((struct curl_httppost *) $a_curl_form);
				#endif
			]"
		end

	c_curl_global_init (a_api: POINTER; a_opt: NATURAL_64)
			-- `a_api' point to API curl_global_init ()
			-- `a_opt' is intialization option.
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB	
					(FUNCTION_CAST(void, (long)) $a_api)((long) $a_opt);
				#else
						/* Using the proper calling convention for dynamic module */
					(FUNCTION_CAST(void, (long)) $a_api)((long) $a_opt);
				#endif
			]"
		end

	c_curl_global_cleanup (a_api: POINTER)
			-- `a_api' point to API curl_global_cleanup()
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB	
					(FUNCTION_CAST(void, ()) $a_api)();
				#else
						/* Using the proper calling convention for dynamic module */
					(FUNCTION_CAST(void, ()) $a_api)();
				#endif
			]"
		end

	c_slist_append (a_api: POINTER; a_list_pointer: POINTER; a_string: POINTER): POINTER
			-- Declared as curl_slist_append ().
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB	
					return (FUNCTION_CAST(void *, (struct curl_slist *, const char *)) $a_api)
											((struct curl_slist *)$a_list_pointer, 
											(const char *)$a_string);
				#else
						/* Using the proper calling convention for dynamic module */
					return (FUNCTION_CAST(void *, (struct curl_slist *, const char *)) $a_api)
											((struct curl_slist *)$a_list_pointer, 
											(const char *)$a_string);
				#endif
			]"
		end

	c_slist_free_all (a_api: POINTER; a_list_pointer: POINTER)
			-- Declared as void curl_slist_free_all(struct curl_slist * list)
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB	
					(FUNCTION_CAST(void *, (struct curl_slist *)) $a_api)
										((struct curl_slist *)$a_list_pointer);
				#else
						/* Using the proper calling convention for dynamic module */
					(FUNCTION_CAST(void *, (struct curl_slist *)) $a_api)
										((struct curl_slist *)$a_list_pointer);
				#endif
			]"
		end

	c_curl_easy_strerror (a_api: POINTER; a_code: INTEGER): POINTER
			-- Declared as CURL_EXTERN const char *curl_easy_strerror(CURLcode);
		require
			a_api_exists: not a_api.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB	
					return (FUNCTION_CAST(void *, (long)) $a_api)
											((long) $a_code);
				#else
						/* Using the proper calling convention for dynamic module */
					return (FUNCTION_CAST(void *, (long)) $a_api)
											((long) $a_code);
				#endif
			]"
		end

	c_mime_init (a_api: POINTER; a_curl_handle: POINTER): POINTER
			-- Decalred as curl_mime * curl_mime_init(CURL * easy_handle );.
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(curl_mime *, (CURL *)) $a_api)((CURL *)$a_curl_handle);
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(curl_mime *, (CURL *)) $a_api)((CURL *)$a_curl_handle);
				#endif
			]"
		end

	c_mime_addpart (a_api: POINTER; a_curl_handle: POINTER): POINTER
			-- Decalred as curl_mimepart * curl_mime_addpart(curl_mime * mime ).
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(curl_mimepart *, (curl_mime *)) $a_api)((curl_mime *)$a_curl_handle);
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(curl_mimepart *, (curl_mime *)) $a_api)((curl_mime *)$a_curl_handle);
				#endif
			]"
		end

	c_mime_data (a_api: POINTER; a_curl_handle: POINTER; a_data: POINTER; a_size: INTEGER): INTEGER
			-- Declared as CURLcode curl_mime_data(curl_mimepart * part , const char * data , size_t datasize );
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, const char *, size_t)) $a_api)((curl_mimepart *)$a_curl_handle, (const char *) $a_data , (size_t)$a_size );
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, const char *, size_t)) $a_api)((curl_mimepart *)$a_curl_handle, (const char *) $a_data , (size_t)$a_size);
				#endif
			]"
		end

	c_mime_type (a_api: POINTER; a_curl_handle: POINTER; a_mimetype: POINTER): INTEGER
			--	CURLcode curl_mime_type(curl_mimepart * part , const char * mimetype );
		require
			a_api_exists: not a_api.is_default_pointer
			exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, const char *)) $a_api)((curl_mimepart *)$a_curl_handle, (const char *) $a_mimetype);
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, const char *)) $a_api)((curl_mimepart *)$a_curl_handle, (const char *) $a_mimetype);
				#endif
			]"
		end

	c_mime_subparts (a_api: POINTER; a_curl_handle: POINTER; a_subparts: POINTER): INTEGER
			--	CURLcode curl_mime_subparts(curl_mimepart * part , curl_mime * subparts );
		require
			a_api_exists: not a_api.is_default_pointer
			exists_mimepart: not a_curl_handle.is_default_pointer
			exists_subparts: not a_subparts.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, curl_mime * )) $a_api)((curl_mimepart *)$a_curl_handle, (curl_mime *) $a_subparts);
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, curl_mime *)) $a_api)((curl_mimepart *)$a_curl_handle, (curl_mime *) $a_subparts);
				#endif
			]"
		end


	c_mime_headers (a_api: POINTER; a_curl_handle: POINTER; a_headers: POINTER; a_take_ownership: INTEGER): INTEGER
			-- CURLcode curl_mime_headers(curl_mimepart * part , struct curl_slist * headers , int take_ownership );
		require
			a_api_exists: not a_api.is_default_pointer
			exists_mimepart: not a_curl_handle.is_default_pointer
			exists_headers: not a_headers.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, struct curl_slist * , int )) $a_api)((curl_mimepart *)$a_curl_handle, (struct curl_slist *) $a_headers, $a_take_ownership);
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, struct curl_slist * , int)) $a_api)((curl_mimepart *)$a_curl_handle, (struct curl_slist *) $a_headers, $a_take_ownership);
				#endif
			]"
		end

	c_mime_filedata (a_api: POINTER; a_curl_handle: POINTER; a_filename: POINTER): INTEGER
			-- CURLcode curl_mime_filedata(curl_mimepart * part , const char * filename );
		require
			a_api_exists: not a_api.is_default_pointer
			exists_mimepart: not a_curl_handle.is_default_pointer
		external
				"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, const char * )) $a_api)((curl_mimepart *)$a_curl_handle, (const char *) $a_filename);
				#else
						/* Using proper calling convention for dynamic module */
					return (FUNCTION_CAST(CURLcode, (curl_mimepart *, const char *)) $a_api)((curl_mimepart *)$a_curl_handle, (const char *) $a_filename);
				#endif
			]"
		end


	c_mime_free (a_api: POINTER; a_curl_handle: POINTER)
		require
			a_api_exists: not a_api.is_default_pointer
			a_curl_handle_exists: not a_curl_handle.is_default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					(FUNCTION_CAST(void , (curl_mime *)) $a_api) ((curl_mime *)$a_curl_handle);
				#else
					(FUNCTION_CAST(void , (curl_mime *)) $a_api) ((curl_mime *)$a_curl_handle);
				#endif
			]"
		end


note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
