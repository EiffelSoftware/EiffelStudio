note
	description: "[
					cURL form constants.
					For more informaton see:
					http://curl.haxx.se/libcurl/c/curl_formadd.html
																		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_FORM_CONSTANTS

feature -- Query

	curlform_copyname: INTEGER
			-- Declared as CURLFORM_COPYNAME
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				CURLFORM_COPYNAME
			]"
		end

	curlform_copycontents: INTEGER
			-- Declared as CURLFORM_COPYCONTENTS
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				CURLFORM_COPYCONTENTS
			]"
		end

	curlform_end: INTEGER
			-- Declared as CURLFORM_END
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				CURLFORM_END
			]"
		end

	curlform_file: INTEGER
			-- Declared as CURLFORM_FILE
		external
			"C inline use <curl/curl.h>"
		alias
			"[
				CURLFORM_FILE
			]"
		end

	is_valid (a_integer: INTEGER): BOOLEAN
			-- If `a_integer' valid?
		do
			Result := 	a_integer = curlform_copycontents or
						a_integer = curlform_copyname or
						a_integer =	curlform_end or
						a_integer = curlform_file
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
