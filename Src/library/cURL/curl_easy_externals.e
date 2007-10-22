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

feature -- Externals

	init: POINTER is
			-- Declared as curl_easy_init().
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				return curl_easy_init();
			}
			]"
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
			l_c_str: C_STRING
		do
			create l_c_str.make (a_string)
			c_setopt_string (a_curl_handle, a_opt, l_c_str.item)
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
		do
			c_setopt_void_star (a_curl_handle, a_opt, a_memory_struct.item)
		end

	setopt_integer (a_curl_handle: POINTER; a_opt: INTEGER; a_integer: INTEGER) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				size_t l_int;
				l_int = $a_integer;
				
				curl_easy_setopt($a_curl_handle, $a_opt, l_int);	
			}
			]"
		end

	perform (a_curl_handle: POINTER): INTEGER is
			-- Declared as curl_easy_perform().
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				return curl_easy_perform ($a_curl_handle);
			}
			]"
		ensure
			valid:
		end

	cleanup (a_curl_handle: POINTER) is
			-- Declared as curl_easy_cleanup().
		require
			exists: a_curl_handle /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				curl_easy_cleanup($a_curl_handle);
								
			}
			]"
		end

feature {NONE} -- Implementation

	setopt_void_star (a_curl_handle: POINTER; a_opt: INTEGER; a_data:POINTER) is
			-- Declared as curl_easy_setopt().
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		do
			c_setopt_void_star (a_curl_handle, a_opt, a_data)
		end

	c_setopt_void_star (a_curl_handle: POINTER; a_opt: INTEGER; a_data:POINTER) is
			-- C implementation of `setopt_void_star'.
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				curl_easy_setopt($a_curl_handle, $a_opt, (void *)$a_data);	
			}
			]"
		end

	c_setopt_string (a_curl_handle: POINTER; a_opt: INTEGER; a_c_string: POINTER)	is
			-- C implementation of `setopt_string'.
		require
			exists: a_curl_handle /= default_pointer
			valid: (create {CURL_OPT_CONSTANTS}).is_valid (a_opt)
			exists: a_c_string /= default_pointer
		external
			"C inline use <curl/curl.h>"
		alias
			"[
			{
				curl_easy_setopt($a_curl_handle, $a_opt, (char *)$a_c_string);	
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
