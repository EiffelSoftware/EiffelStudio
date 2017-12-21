note
	description: "[
					Utilities for Eiffel cURL wrapper library.
																		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_UTILITY

feature -- Query

	is_static: BOOLEAN
			-- Is CURL_STATICLIB defined?
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
				#ifdef CURL_STATICLIB
					return EIF_TRUE;
				#else
					return EIF_FALSE;
				#endif
			]"
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
