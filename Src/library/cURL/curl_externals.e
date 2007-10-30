indexing
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

feature -- Command

	global_init is
			-- Declared as curl_global_init().
		local
			l_ptr: POINTER
		do
			l_ptr := api_loader.safe_load_api (module_name, "curl_global_init")
			if l_ptr /= default_pointer then
				c_curl_global_init (l_ptr, {CURL_GLOBAL_CONSTANTS}.curl_global_all);
			end
		end

	formadd_string_string (a_form: CURL_FORM; a_last_pointer: CURL_FORM; a_arg_1: INTEGER; a_arg_1_value: STRING_GENERAL; a_arg_2: INTEGER; a_arg_2_value: STRING_GENERAL; a_arg_3: INTEGER) is
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

feature -- Query

	is_dynamic_library_exists: BOOLEAN is
			-- If dll/so files exist?
		do
			Result := (api_loader.module_pointer (module_name) /= default_pointer)
		end

feature {CURL_FORM} -- Internal command

	formfree (a_curl_form: POINTER) is
			-- Declared as curl_formfree ().
		require
			exists: a_curl_form /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_formfree")
			if l_api /= default_pointer then
				c_formfree (l_api, a_curl_form)
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

	module_name: STRING is
			-- Module name.
		local
			l_utility: CURL_UTILITY
		once
			create l_utility
			Result := l_utility.module_name
		end

	internal_formadd_string_string (a_form: TYPED_POINTER [POINTER]; a_last_pointer: TYPED_POINTER [POINTER]; a_arg_1: INTEGER; a_arg_1_value: STRING_GENERAL; a_arg_2: INTEGER; a_arg_2_value: STRING_GENERAL; a_arg_3: INTEGER) is
			-- Declared as curl_formadd ().
		local
			l_c_string_1, l_c_string_2: C_STRING
			l_api: POINTER
		do
			l_api := api_loader.safe_load_api (module_name, "curl_formadd");
			if l_api /= default_pointer then
				create l_c_string_1.make (a_arg_1_value)
				create l_c_string_2.make (a_arg_2_value)
				c_formadd_string_string (l_api, a_form, a_last_pointer, a_arg_1, l_c_string_1.item, a_arg_2, l_c_string_2.item, a_arg_3)
			end
		end

feature {NONE} -- C externals

	c_formadd_string_string (a_api: POINTER; a_form: TYPED_POINTER [POINTER]; a_last_pointer: TYPED_POINTER [POINTER]; a_arg_1: INTEGER; a_arg_1_value: POINTER; a_arg_2: INTEGER; a_arg_2_value: POINTER; a_arg_3: INTEGER) is
			-- C implementation of formadd_string_string ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				(FUNCTION_CAST(void, (struct curl_httppost **, struct curl_httppost **, int, char *, int, char *, int)) $a_api)
																						((struct curl_httppost *)$a_form,
																						(struct curl_httppost *)$a_last_pointer,
																						(int)$a_arg_1,
																						(char *)$a_arg_1_value,
																						(int)$a_arg_2,
																						(char *)$a_arg_2_value,
																						(int)$a_arg_3);
			}
			]"
		end

	c_formfree (a_api: POINTER; a_curl_form: POINTER) is
			-- Declared as curl_formfree ().
		require
			exists: a_api /= default_pointer
			exists: a_curl_form /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				(FUNCTION_CAST(void, (struct curl_httppost *)) $a_api)
												((struct curl_httppost *) $a_curl_form);
			]"
		end

	c_curl_global_init (a_api: POINTER; a_opt: NATURAL_64) is
			-- `a_api' point to AIP curl_global_init ()
			-- `a_opt' is intialization option.
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				(FUNCTION_CAST(void, (long)) $a_api)((long) $a_opt);
			]"
		end

	c_slist_append (a_api: POINTER; a_list_pointer: POINTER; a_string: POINTER): POINTER is
			-- Declared as curl_slist_append ().
		require
			exists: a_api /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				return (FUNCTION_CAST(void *, (struct curl_slist *, const char *)) $a_api)
											((struct curl_slist *)$a_list_pointer, 
											(const char *)$a_string);
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
