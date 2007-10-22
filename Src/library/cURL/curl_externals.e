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

feature -- Externals

	global_init is
			-- Declared as curl_global_init().
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				curl_global_init (CURL_GLOBAL_ALL);
			}
			]"
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

	set_write_function (a_curl_handle: POINTER) is
			-- Setting CURLOPT_WRITEFUNCTION option of `a_curl_handle'.
			-- We need this function since cURL need a static c function pointer as value.
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				curl_easy_setopt ($a_curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
			}
			]"
		end

	set_debug_function (a_curl_handle: POINTER) is
			-- Setting CURLOPT_DEBUGFUNCTION option of `a_curl_handle'.
			-- We need this function since cURL need a static c function pointer as value.
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				curl_easy_setopt($a_curl_handle, CURLOPT_DEBUGFUNCTION, my_trace);
				curl_easy_setopt($a_curl_handle, CURLOPT_VERBOSE, TRUE);				
			}
			]"
		end

feature {CURL_FORM} -- Internal command

	formfree (a_curl_form: POINTER) is
			-- Declared as curl_formfree ().
		require
			exists: a_curl_form /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				curl_formfree($a_curl_form);
			}
			]"
		end

feature {NONE} -- Implementation

	c_slist_append (a_list_pointer: POINTER; a_string: POINTER): POINTER is
			-- Declared as curl_slist_append ().
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				return curl_slist_append ((struct curl_slist *)$a_list_pointer, (char *)$a_string);
			}
			]"
		end

	internal_formadd_string_string (a_form: TYPED_POINTER [POINTER]; a_last_pointer: TYPED_POINTER [POINTER]; a_arg_1: INTEGER; a_arg_1_value: STRING_GENERAL; a_arg_2: INTEGER; a_arg_2_value: STRING_GENERAL; a_arg_3: INTEGER) is
			-- Declared as curl_formadd ().
		local
			l_c_string_1, l_c_string_2: C_STRING
		do
			create l_c_string_1.make (a_arg_1_value)
			create l_c_string_2.make (a_arg_2_value)
			c_formadd_string_string (a_form, a_last_pointer, a_arg_1, l_c_string_1.item, a_arg_2, l_c_string_2.item, a_arg_3)
		end

	c_formadd_string_string (a_form: TYPED_POINTER [POINTER]; a_last_pointer: TYPED_POINTER [POINTER]; a_arg_1: INTEGER; a_arg_1_value: POINTER; a_arg_2: INTEGER; a_arg_2_value: POINTER; a_arg_3: INTEGER) is
			-- C implementation of formadd_string_string ().
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				curl_formadd ((struct curl_httppost *)$a_form, (struct curl_httppost *)$a_last_pointer, (int)$a_arg_1, (char *)$a_arg_1_value, (int)$a_arg_2, (char *)$a_arg_2_value, (int)$a_arg_3);
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
